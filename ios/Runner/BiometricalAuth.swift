//
//  BiometricalAuth.swift
//  Runner
//
//  Created by Daria Yes'kova on 10.06.2020.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

import Foundation
import LocalAuthentication

final class BiometricalAuth {

	private struct _Constants {
		static let key: String = "pin"
		static let code: String = "resultCode"

		static let lockedDescription: String = "Access sample keychain entry"
	}

	enum Strategy {
		case encrypt(pincode: String)
		case decrypt
	}

	enum Result {
		static let codeSuccess = 100

		case success(String)
		case failure(Int)

		enum Error: Int {
			case disabled = 101
			case notEnrolled = 102
			case notRecognized = 103
			case deleted = 104
			case unknown = 105
			case cancelled = 10
		}
	}

	enum BiometryState {
		case available, locked, notAvailable, notEnrolled
	}

	private var bioSecAccessControl: SecAccessControl {
		var error: Unmanaged<CFError>?
        var access: SecAccessControl?
		if #available(iOS 11.3, *) {
			access = SecAccessControlCreateWithFlags(nil, kSecAttrAccessibleWhenUnlockedThisDeviceOnly, .biometryAny, &error)
		}
		else {
			access = SecAccessControlCreateWithFlags(nil, kSecAttrAccessibleWhenUnlockedThisDeviceOnly, .userPresence, &error)
		}
		guard let unwrappedAccess = access else {
			preconditionFailure("SecAccessControlCreateWithFlags failed")
        }
        return unwrappedAccess
	}

	private var biometryState: BiometryState {
		let authContext = LAContext()
		var error: NSError?

		let biometryAvailable = authContext.canEvaluatePolicy(
			LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error)
		if let laError = error as? LAError, laError.code == LAError.Code.biometryLockout {
			return .locked
		}

		if let notEnrolledError = error as? LAError, notEnrolledError.code == LAError.Code.biometryNotEnrolled {
			return .notEnrolled
		}
		return biometryAvailable ? .available : .notAvailable
	}

	func handle(strategy: Strategy, result: @escaping FlutterResult) {
		switch strategy {
		case .decrypt:
			readEntry { readResult in
				switch readResult {
				case .success(let pincode):
					Self.parse(pincode: pincode, for: result)

				case .failure(let code):
					Self.parse(code: code, for: result)
				}
			}

		case .encrypt(let pincode):
			createEntry(pin: pincode) { createResult in
				switch createResult {
				case .success(let pincode):
					Self.parse(pincode: pincode, for: result)

				case .failure(let code):
					Self.parse(code: code, for: result)
				}
			}
		}
	}

	private func createBioProtectedEntry(key: String, data: Data) -> OSStatus {
		let queryToRemove = [
			kSecClass: kSecClassGenericPassword,
			kSecAttrAccount: key
		] as CFDictionary

		SecItemDelete(queryToRemove)

		let query = [
			kSecClass: kSecClassGenericPassword,
			kSecAttrAccount: key,
			kSecAttrAccessControl: bioSecAccessControl,
			kSecValueData: data
		] as CFDictionary

		return SecItemAdd(query, nil)
	}

	private func checkBiometryState(_ completion: @escaping (Result.Error?)->Void) {
		let bioState = self.biometryState
		switch bioState {
		case .available:
			completion(nil)
		case .locked:
			let authContext = LAContext()
			authContext.evaluatePolicy(
				LAPolicy.deviceOwnerAuthentication,
				localizedReason: _Constants.lockedDescription,
				reply: { [weak self] (success, error) in
					DispatchQueue.main.async {
						guard let self = self else {
							completion(.unknown)
							return
						}
						if success {
							completion(nil)
						}
						else if let error = error {
							completion(self.handleBiometryError(error))
						}
						else {
							completion(.unknown)
						}
					}
				}
			)
		case .notAvailable:
			completion(.disabled)

		case .notEnrolled:
			completion(.notEnrolled)
		}
	}

	private func createEntry(pin: String, completion: @escaping (Result) -> Void) {
		checkBiometryState { [weak self] error in
			guard let self = self else {
				completion(.failure(Result.Error.unknown.rawValue))
				return
			}
			if let error = error {
				completion(.failure(error.rawValue))
			}
			else if let data = pin.data(using: .utf8), self.createBioProtectedEntry(key: _Constants.key, data: data) == errSecSuccess {
				completion(.success(pin))
			}
			else {
				completion(.failure(Result.Error.notRecognized.rawValue))
			}
		}
	}

	private func readEntry(completion: @escaping (Result) -> Void) {
		checkBiometryState { [weak self] error in
			guard let self = self else {
				completion(.failure(Result.Error.unknown.rawValue))
				return
			}
			if let error = error {
				completion(.failure(error.rawValue))
			}
			else {
				let result = self.loadBioProtected(key: _Constants.key)
				if let data = result.0, let string = String(data: data, encoding: .utf8) {
					completion(.success(string))
				}
				else if let readingError = result.1, readingError == .cancelled {
					completion(.failure(Result.Error.cancelled.rawValue))
				}
				else {
					completion(.failure(Result.Error.notRecognized.rawValue))
				}
			}
		}
	}

	private func handleBiometryError(_ error: Error) -> Result.Error {
		switch biometryState {
		case .notEnrolled:
			return .notEnrolled

		case .notAvailable:
			return .disabled

		default:
			if let laError = error as? LAError, laError.isCancel {
				return .cancelled
			}
			return .unknown
		}

	}

	private func loadBioProtected(key: String, context: LAContext? = nil, prompt: String? = nil) -> (Data?, Result.Error?) {
		var query: [CFString: Any?] = [
			kSecClass: kSecClassGenericPassword,
			kSecAttrAccount: key,
			kSecReturnData: kCFBooleanTrue,
			kSecAttrAccessControl: bioSecAccessControl,
			kSecMatchLimit: kSecMatchLimitOne
		]

		if let context = context {
			query[kSecUseAuthenticationContext] = context
			query[kSecUseAuthenticationUI] = kSecUseAuthenticationUISkip
		}

		if let prompt = prompt {
			query[kSecUseOperationPrompt] = prompt
		}

		var dataTypeRef: AnyObject? = nil

		let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

		if status == noErr {
			return ((dataTypeRef as? Data), nil)
		}
		else if status == errSecUserCanceled {
			return (nil, .cancelled)
		}
		else {
			return (nil, .notRecognized)
		}
	}

	private static func parse(code: Int = BiometricalAuth.Result.codeSuccess, pincode: String? = nil, for result: @escaping FlutterResult) {
		var response: [String: Any] = [
			_Constants.code: code
		]
		if let pincode = pincode {
			response[_Constants.key] = pincode
		}
		result(response)
	}

}

private extension LAError {
	var isCancel: Bool {
		switch code {
		case .userCancel, .appCancel, .systemCancel:
			return true
		default:
			return false
		}
	}
}

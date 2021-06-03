import UIKit
import Flutter
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
	private let biometricAuthManager = BiometricalAuth()

	override func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		FirebaseApp.configure()
		if let controller: FlutterViewController = window?.rootViewController as? FlutterViewController {
			FlutterMethodChannel(name: Constants.FlutterChannels.data, binaryMessenger: controller.binaryMessenger)
				.setMethodCallHandler { [weak self] (call, result) in
					switch call.method {
					case Constants.FlutterChannelMethod.firstStart:
						result(true)

					case Constants.FlutterChannelMethod.openSecuritySettings:
						guard
							let url = URL(string: UIApplication.openSettingsURLString),
							UIApplication.shared.canOpenURL(url)
						else {
							result(false)
							return
						}
						UIApplication.shared.open(url, completionHandler: result)

					case Constants.FlutterChannelMethod.decryptPin:
						self?.biometricAuthManager.handle(strategy: .decrypt, result: result)
							?? result(FlutterMethodNotImplemented)

					case Constants.FlutterChannelMethod.encryptPin:
						guard
							let args = call.arguments as? [String: Any],
							let pincode = args[Constants.FlutterChannelArgument.pin] as? String
						else {
							result(FlutterMethodNotImplemented)
							return
						}
						self?.biometricAuthManager.handle(strategy: .encrypt(pincode: pincode), result: result)
							?? result(FlutterMethodNotImplemented)

					default:
						result(FlutterMethodNotImplemented)
					}
				}
		}
		GeneratedPluginRegistrant.register(with: self)
		return super.application(application, didFinishLaunchingWithOptions: launchOptions)
	}
}

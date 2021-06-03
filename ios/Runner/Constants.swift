//
//  Constants.swift
//  Runner
//
//  Created by Mike Price on 26.02.2021.
//

import Foundation

struct Constants {
	struct FlutterChannels {
		static let data = "app.channel.shared.data"
	}

	struct FlutterChannelMethod {
		static let firstStart = "readIsFirstStart"

		static let encryptPin: String = "encryptPin"
		static let decryptPin: String = "decryptPin"

		static let openSecuritySettings: String = "openSecuritySettings"
	}

	struct FlutterChannelArgument {
		static let pin: String = "pin"
	}
}

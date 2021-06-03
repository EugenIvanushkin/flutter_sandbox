//
//  SwiftStreamHandler.swift
//  Runner
//
//  Created by Daria Yes'kova on 15.06.2020.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

class SwiftStreamHandler: NSObject, FlutterStreamHandler {
	var listenCompletion: ((_ arguments: Any?, _ events: @escaping FlutterEventSink) -> Void)?
	var cancelCompletion: ((_ arguments: Any?) -> Void)?

	public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
		listenCompletion?(arguments, events)
		return nil
	}

	public func onCancel(withArguments arguments: Any?) -> FlutterError? {
		cancelCompletion?(arguments)
		return nil
	}
}

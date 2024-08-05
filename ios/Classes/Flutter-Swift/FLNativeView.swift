//
//  FLNativeView.swift
//  flutter_swiftui_test
//
//  Created by Konrad Feiler on 05.08.24.
//

import Flutter
import SwiftUI
import OSLog

let log = Logger(subsystem: "com.mhc", category: "swiftuitest")

class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView
    private var methodChannel: FlutterMethodChannel

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        _view = UIView()
        methodChannel = FlutterMethodChannel(name: "flutter_swiftui_test", binaryMessenger: messenger)

        super.init()
        // iOS views can be created here
        methodChannel.setMethodCallHandler(onMethodCall)
        _view.createSwiftUIView(channel: methodChannel)

        // trigger a test message
        sendMessageToFlutter()
    }

    func view() -> UIView {
        return _view
    }

    func onMethodCall(call: FlutterMethodCall, result: FlutterResult) {
        switch(call.method){
        case "getPlatformVersion":
            log.debug("Received getPlatformVersion on \(self.methodChannel)")
            result("iOS " + UIDevice.current.systemVersion)
        default:
            log.debug("Method not implemented: \(call.method)")
            result(FlutterMethodNotImplemented)
        }
    }

    func sendMessageToFlutter() {
        log.debug("Sending message to Flutter: on_back_tapped with arguments: [\"x\": 10]: \(self.methodChannel)")
        methodChannel.invokeMethod("on_back_tapped", arguments: ["x": 10])
    }
}

extension UIView {
    func createSwiftUIView(channel: FlutterMethodChannel){

        // FOR SWIFTUI
        let keyWindows = UIApplication.shared.windows.first(where: { $0.isKeyWindow}) ?? UIApplication.shared.windows.first
        let topController = keyWindows?.rootViewController

        let vc = UIHostingController(
            rootView: MainView(onButtonPressed: {
                channel.invokeMethod("swiftui_button_pressed", arguments: ["x": 10])
            })
        )
        let swiftUiView = vc.view!
        swiftUiView.translatesAutoresizingMaskIntoConstraints = false

        topController?.addChild(vc)
        addSubview(swiftUiView)

        NSLayoutConstraint.activate(
            [
                swiftUiView.leadingAnchor.constraint(equalTo: leadingAnchor),
                swiftUiView.trailingAnchor.constraint(equalTo: trailingAnchor),
                swiftUiView.topAnchor.constraint(equalTo: topAnchor),
                swiftUiView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])

        vc.didMove(toParent: topController)
    }
}

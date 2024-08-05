import Flutter
import UIKit

public class FlutterSwiftuiTestPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        registrar.register(FlutterNativeViewFactory(messenger: registrar.messenger()), withId: "plugins.flutter_swiftui_test.swift_ui_view")
    }
}

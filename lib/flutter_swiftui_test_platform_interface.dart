import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_swiftui_test_method_channel.dart';

abstract class FlutterSwiftuiTestPlatform extends PlatformInterface {
  /// Constructs a FlutterSwiftuiTestPlatform.
  FlutterSwiftuiTestPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterSwiftuiTestPlatform _instance = MethodChannelFlutterSwiftuiTest();

  /// The default instance of [FlutterSwiftuiTestPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterSwiftuiTest].
  static FlutterSwiftuiTestPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterSwiftuiTestPlatform] when
  /// they register themselves.
  static set instance(FlutterSwiftuiTestPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_swiftui_test_platform_interface.dart';

/// An implementation of [FlutterSwiftuiTestPlatform] that uses method channels.
class MethodChannelFlutterSwiftuiTest extends FlutterSwiftuiTestPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_swiftui_test');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  // listen to methodChannel messages
  @override
  void listenToMessages(void Function(String) onMsgReceived) {
    methodChannel.setMethodCallHandler((call) async {
      onMsgReceived.call(call.method);
    });
  }
}

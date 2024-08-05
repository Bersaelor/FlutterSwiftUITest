import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_swiftui_test/flutter_swiftui_test.dart';
import 'package:flutter_swiftui_test/flutter_swiftui_test_platform_interface.dart';
import 'package:flutter_swiftui_test/flutter_swiftui_test_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterSwiftuiTestPlatform
    with MockPlatformInterfaceMixin
    implements FlutterSwiftuiTestPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterSwiftuiTestPlatform initialPlatform = FlutterSwiftuiTestPlatform.instance;

  test('$MethodChannelFlutterSwiftuiTest is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterSwiftuiTest>());
  });

  test('getPlatformVersion', () async {
    FlutterSwiftuiTest flutterSwiftuiTestPlugin = FlutterSwiftuiTest();
    MockFlutterSwiftuiTestPlatform fakePlatform = MockFlutterSwiftuiTestPlatform();
    FlutterSwiftuiTestPlatform.instance = fakePlatform;

    expect(await flutterSwiftuiTestPlugin.getPlatformVersion(), '42');
  });
}

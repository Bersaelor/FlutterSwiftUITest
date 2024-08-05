import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiftui_test/flutter_swiftui_test_platform_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _lastReceivedMethodName = '';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SwiftUI Plugin test app'),
        ),
        body: Center(
          child:
              // vertical column
              Column(
            children: [
              _lastReceivedMethodName.isEmpty
                  ? const Text('No method called yet')
                  : Text('Received: $_lastReceivedMethodName\n'),
              // restrict height to 200
              SizedBox(
                height: 200,
                child: UiKitView(
                    viewType: 'plugins.flutter_swiftui_test.swift_ui_view',
                    layoutDirection: TextDirection.ltr,
                    creationParams: creationParams,
                    creationParamsCodec: const StandardMessageCodec()),
              ),
              Text('Running on: $_platformVersion\n'),
              ElevatedButton(
                onPressed: () async {
                  // call the plugin
                  fetchPlatformState();
                },
                child: const Text('Get Platform Version'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> fetchPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await FlutterSwiftuiTestPlatform.instance.getPlatformVersion() ??
              'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  void initState() {
    super.initState();

    // listen to messages from the plugin
    FlutterSwiftuiTestPlatform.instance.listenToMessages((String methodName) {
      setState(() {
        _lastReceivedMethodName = methodName;
      });
    });
  }
}

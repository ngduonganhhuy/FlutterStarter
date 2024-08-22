import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_stater/core/utils/storage_util.dart';
import 'package:flutter_stater/root/app/root.dart';
import 'package:flutter_stater/root/bootstrap.dart';

Future<void> mainDelegate() async {
  //TODO if true, just remove this comment
  debugRepaintRainbowEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  await StorageUtil.initPreferences();
  registerErrorHandlers();
  await bootstrap(() => const Root());
}

void registerErrorHandlers() {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint(error.toString());
    return true;
  };
  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('An error occurred'),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}

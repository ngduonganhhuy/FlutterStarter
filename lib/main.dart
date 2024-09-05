import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/core/extensions/widget_extension.dart';
import 'package:flutter_starter/core/utils/error_handler.dart';
import 'package:flutter_starter/core/utils/storage_util.dart';
import 'package:flutter_starter/injection_container.dart';
import 'package:flutter_starter/root/app/root.dart';
import 'package:flutter_starter/root/bootstrap.dart';

Future<void> mainDelegate() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await StorageUtil.initPreferences();
      registerErrorHandlers();
      setupLocator();
      await bootstrap(() => const Root());
    },
    ErrorHandler.handleAsyncError,
  );
}

void registerErrorHandlers() {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = ErrorHandler.handleFlutterError;
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
        title: const Text('Holmes: 😡😡'),
      ),
      body: Text(details.toString()).center,
    );
  };
}

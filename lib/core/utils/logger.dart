import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static final logger = Logger(
    printer: PrettyPrinter(colors: Platform.isAndroid, dateTimeFormat: DateTimeFormat.dateAndTime),
  );

  //[Debug]
  static void d(dynamic message) {
    if (kDebugMode == true) {
      logger.d(message);
    }
  }

  //[Info]
  static void i(dynamic message) {
    if (kDebugMode == true) {
      logger.i(message);
    }
  }

  //[Trace]
  static void t(dynamic message) {
    if (kDebugMode == true) {
      logger.t(message);
    }
  }

  //[Error]
  static void e(dynamic message) {
    if (kDebugMode == true) {
      logger.e(message);
    }
  }

  //[Warning]
  static void w(dynamic message) {
    if (kDebugMode == true) {
      logger.w(message);
    }
  }

  //[Fatal]
  static void f(dynamic message) {
    if (kDebugMode == true) {
      logger.f(message);
    }
  }
}

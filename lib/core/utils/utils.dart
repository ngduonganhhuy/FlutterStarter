import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stater/core/utils/logger.dart';
import 'package:intl/intl.dart';

class Utils {
  /// Checks if data is null or empty.
  static bool isNullOrEmpty(dynamic value) {
    if (value == null) {
      return true;
    }
    if (value is String) {
      return value.trim().isEmpty;
    }
    if (value is List && value.isEmpty) {
      return true;
    }
    if (value is Iterable && value.isEmpty) {
      return true;
    }
    if (value is Map && value.isEmpty) {
      return true;
    }
    return false;
  }

  static bool isNotNullOrEmpty(dynamic value) {
    return !isNullOrEmpty(value);
  }

  static String enumToString(Enum? type) {
    return isNullOrEmpty(type) ? '' : type.toString().split('.')[1];
  }

  static T? stringToEnum<T>(String? str, List<T> values) {
    final valuesInStr = values.map((e) => enumToString(e as Enum)).toList();
    return isNullOrEmpty(str) || !valuesInStr.contains(str) ? null : values.firstWhere((e) => enumToString(e as Enum) == str);
  }

  static void logWithJson(String url, dynamic responseBody, int? statusCode, String? statusMessage) {
    try {
      final prettyprint = const JsonEncoder.withIndent('  ').convert(responseBody);
      if (!kReleaseMode) {
        AppLogger.d(prettyprint);
      }
    } catch (e) {
      if (!kReleaseMode) {
        AppLogger.d(responseBody);
      }
    }
  }

  static void logWithBreakLine(String msg) {
    if (kDebugMode) {
      try {
        if (!kReleaseMode) {
          AppLogger.d('---------------------$msg---------------------');
        }
      } catch (e) {
        AppLogger.d(e.toString());
      }
    }
  }

  static String convertDateTimeToPatternTime(DateTime? now, {String pattern = 'yyyy-MM-dd'}) {
    return now == null ? '' : DateFormat(pattern).format(now);
  }

  static void closeKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.requestFocus(FocusNode());
    }
  }

  static T? jsonToModel<T>(dynamic json, T Function(Map<String, dynamic> data) factory) {
    try {
      return isNullOrEmpty(json) ? null : factory(json as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  static List<T>? jsonToList<T>(dynamic json, T Function(Map<String, dynamic> data) factory) {
    try {
      return isNullOrEmpty(json) ? [] : (json as List).map((model) => factory(model as Map<String, dynamic>)).toList();
    } catch (_) {
      return null;
    }
  }

  static String getCurrentMethodName() {
    final frames = StackTrace.current.toString().split('\n');
    final frame = frames.elementAtOrNull(1);
    if (frame != null) {
      final tokens = frame.replaceAll('<anonymous closure>', '<anonymous_closure>').split(' ');
      final methodName = tokens.elementAtOrNull(tokens.length - 2);
      if (methodName != null) {
        final methodTokens = methodName.split('.');
        return methodTokens.length >= 2 && methodTokens[1] != '<anonymous_closure>' ? (methodTokens.elementAtOrNull(1) ?? '') : methodName;
      }
    }
    return '';
  }
}

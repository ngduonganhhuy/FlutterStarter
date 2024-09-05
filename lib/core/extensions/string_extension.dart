import 'package:flutter/material.dart';

extension StringNullExt on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullAndEmtpy => !isNullOrEmpty;
}

extension StringExt on String {
  Color toColor() {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

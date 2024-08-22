import 'package:flutter/material.dart';
import 'package:flutter_stater/core/constants/constants.dart';

final roboto = RobotoTextStyle();
final appFont = AppTextStyles();

class RobotoTextStyle extends AppTextStyles {
  @override
  TextStyle Function() get useFont => () => const TextStyle(
        fontFamily: Constants.fontFamilyName,
        letterSpacing: 0,
      );
}

class AppTextStyles {
  double? _height(double? lineHeight, double fontSize) => lineHeight == null ? null : lineHeight / fontSize;

  TextStyle Function() useFont = () => roboto.useFont();

  TextStyle size14({double? lineHeight, FontWeight? fontWeight, Color? color}) {
    return useFont().copyWith(
      fontSize: 14,
      color: color,
      fontWeight: fontWeight ?? FontWeight.w400,
      height: _height(lineHeight, 14),
    );
  }

  TextStyle size16({double? lineHeight, FontWeight? fontWeight, Color? color}) {
    return useFont().copyWith(
      fontSize: 16,
      color: color,
      fontWeight: fontWeight ?? FontWeight.w400,
      height: _height(lineHeight, 16),
    );
  }

  TextStyle size20({double? lineHeight, FontWeight? fontWeight, Color? color}) {
    return useFont().copyWith(
      fontSize: 20,
      color: color,
      fontWeight: fontWeight ?? FontWeight.w400,
      height: _height(lineHeight, 20),
    );
  }
}

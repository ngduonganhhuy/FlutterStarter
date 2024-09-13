import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starter/core/constants/constants.dart';

final roboto = RobotoTextStyle();
final appFont = AppTextStyles();

typedef TextStylesParams = TextStyle Function({double? lineHeight, FontWeight? fontWeight, Color? color, double? fontSize});

class RobotoTextStyle extends AppTextStyles {
  @override
  TextStylesParams get useFont => ({double? lineHeight, FontWeight? fontWeight, Color? color, double? fontSize}) => TextStyle(
        fontFamily: Constants.fontFamilyName,
        letterSpacing: 0,
        fontSize: fontSize?.sp,
        height: _height(lineHeight, 14),
        color: color,
        fontWeight: fontWeight,
      );
}

class AppTextStyles {
  double? _height(double? lineHeight, double fontSize) => lineHeight == null ? null : lineHeight / fontSize;

  TextStylesParams useFont = ({double? lineHeight, FontWeight? fontWeight, Color? color, double? fontSize}) => roboto.useFont(
        lineHeight: lineHeight,
        fontWeight: fontWeight,
        color: color,
        fontSize: fontSize,
      );
}

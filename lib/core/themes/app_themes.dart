import 'package:flutter/material.dart';
import 'package:flutter_starter/core/themes/app_colors.dart';

enum AppTheme {
  GreenLight,
  GreenDark,
  BlueLight,
  BlueDark;

  String get key => switch (this) {
        GreenLight => 'GreenLight',
        GreenDark => 'GreenDark',
        BlueLight => 'BlueLight',
        BlueDark => 'BlueDark',
      };
}

final appColorsData = {
  AppTheme.GreenLight: AppColors(
    brightness: Brightness.light,
    primaryColor: Colors.green,
  ),
  AppTheme.GreenDark: AppColors(
    brightness: Brightness.dark,
    primaryColor: Colors.green.shade700,
  ),
  AppTheme.BlueLight: AppColors(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
  ),
  AppTheme.BlueDark: AppColors(
    brightness: Brightness.dark,
    primaryColor: Colors.blue.shade700,
  ),
};

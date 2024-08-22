import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stater/core/themes/app_themes.dart';
import 'package:flutter_stater/core/utils/injection.dart';
import 'package:flutter_stater/core_bloc/theme/theme_bloc.dart';

AppColors get appScheme {
  final appTheme = Injection.navKey.currentContext!.select((ThemeBloc bloc) => bloc.getTheme());
  return appColorsData[appTheme] ?? appColorsData[AppTheme.GreenLight]!;
}

class AppColors {
  AppColors({
    required this.brightness,
    required this.primaryColor,
  });

  final Brightness brightness;
  final Color primaryColor;
}

extension StringToColor on String {
  Color toColor() {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

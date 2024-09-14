import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aes_room/core/themes/app_themes.dart';
import 'package:aes_room/core/utils/injection.dart';
import 'package:aes_room/core_bloc/theme/theme_bloc.dart';

AppColors get appScheme {
  final appTheme = BlocProvider.of<ThemeBloc>(Injection.navKey.currentContext!).getTheme();
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

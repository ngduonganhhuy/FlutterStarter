part of 'theme_bloc.dart';

sealed class ThemeState extends Equatable {
  const ThemeState(this.appColors);
  final AppColors? appColors;

  @override
  List<Object?> get props => [appColors];
}

class GreenLightThemeState extends ThemeState {
  GreenLightThemeState() : super(appColorsData[AppTheme.GreenLight]);
}

class GreenDarkThemeState extends ThemeState {
  GreenDarkThemeState() : super(appColorsData[AppTheme.GreenDark]);
}

class BlueLightThemeState extends ThemeState {
  BlueLightThemeState() : super(appColorsData[AppTheme.BlueLight]);
}

class BlueDarkThemeState extends ThemeState {
  BlueDarkThemeState() : super(appColorsData[AppTheme.BlueDark]);
}

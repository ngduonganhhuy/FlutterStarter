part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class SetInitialTheme extends ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {
  const ToggleThemeEvent({
    required this.theme,
  });

  final AppTheme theme;
}

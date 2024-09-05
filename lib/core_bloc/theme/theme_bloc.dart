import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_starter/core/themes/app_colors.dart';
import 'package:flutter_starter/core/themes/app_themes.dart';
import 'package:flutter_starter/core/utils/storage_util.dart';
import 'package:flutter_starter/core/utils/utils.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(GreenLightThemeState()) {
    // execute this event when the app starts
    on<SetInitialTheme>(
      (event, emit) async {
        final currentAppTheme = getTheme();
        await setTheme(emit, newTheme: currentAppTheme ?? AppTheme.GreenLight);
      },
    );

    // toggle the app theme
    on<ToggleThemeEvent>((event, emit) {
      setTheme(emit, newTheme: event.theme);
    });
  }

  AppTheme? getTheme() {
    final themeStorage = StorageUtil.getString(StorageKey.THEME);
    final currentTheme = Utils.stringToEnum(themeStorage, AppTheme.values);
    return currentTheme;
  }

  Future<void> setTheme(Emitter<ThemeState> emit, {required AppTheme newTheme}) async {
    switch (newTheme) {
      case AppTheme.GreenLight:
        emit(GreenLightThemeState());
      case AppTheme.BlueLight:
        emit(BlueLightThemeState());
      case AppTheme.GreenDark:
        emit(GreenDarkThemeState());
      case AppTheme.BlueDark:
        emit(BlueDarkThemeState());
    }
    await StorageUtil.putString(StorageKey.THEME, newTheme.key);
  }
}

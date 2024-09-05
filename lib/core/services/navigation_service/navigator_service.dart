import 'package:flutter/material.dart';
import 'package:flutter_starter/core/impl/base_page.dart';
import 'package:flutter_starter/core/utils/device_utils.dart';
import 'package:flutter_starter/core/utils/utils.dart';
import 'package:flutter_starter/presentation/pages/home/home_page.dart';
import 'package:flutter_starter/presentation/pages/weather/weather_page.dart';

class NavigatorService {
  static Future<T?> _goTo<T extends Object?>(
    BuildContext context,
    BasePage screen, {
    Object? arguments,
    bool clearToHome = false,
    bool clearStack = false,
    bool replace = false,
    T? resultForReplace,
  }) async {
    Utils.closeKeyboard(context);
    final newRoute = FormFactor.isDesktop || FormFactor.isDesktopDevice
        ? PageRouteBuilder<T>(
            pageBuilder: (BuildContext context, _, __) => screen,
            settings: RouteSettings(name: screen.screenName),
          )
        : MaterialPageRoute<T>(
            builder: (context) => screen,
            settings: RouteSettings(name: screen.screenName),
          );
    if (clearToHome) {
      return Navigator.of(context).pushAndRemoveUntil<T>(newRoute, (route) => route.isFirst);
    }
    if (clearStack) {
      return Navigator.of(context).pushAndRemoveUntil<T>(newRoute, (route) => false);
    }
    if (replace) {
      return Navigator.of(context).pushReplacement<T, T>(newRoute, result: resultForReplace);
    }
    return Navigator.of(context).push<T>(newRoute);
  }

  static Future<T?> goToCustom<T extends Object?>(
    BuildContext context, {
    required BasePage screen,
    required String screenName,
    bool clearStack = true,
    bool replace = false,
  }) async {
    return _goTo<T>(context, screen, clearStack: clearStack, replace: replace);
  }

  static void goBack<T>(BuildContext context, [T? result]) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop(result);
    }
  }

  static void goBackUntil<T>(BuildContext context, String untilScreenName) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).popUntil((route) => route.settings.name == untilScreenName);
    }
  }

  static Future<T?> goToHomePage<T extends Object?>(BuildContext context) async {
    return _goTo<T>(context, const HomePage());
  }

  static Future<T?> goToWeatherPage<T extends Object?>(BuildContext context) async {
    return _goTo<T>(context, const WeatherPage());
  }
}

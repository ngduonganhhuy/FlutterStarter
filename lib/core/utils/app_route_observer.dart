import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_starter/core/services/api_service/api_service.dart';
import 'package:flutter_starter/core/utils/logger.dart';

class ScreenChangeModel {
  ScreenChangeModel({required this.screenName, required this.args});
  final String screenName;
  final Map<String, dynamic>? args;
}

class AppRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  static const UNDEFINED_SCREEN_NAME = 'undefined screenName';

  final screenChangeStreamCtrl = StreamController<ScreenChangeModel>.broadcast();
  final homeTabChangeStreamCtrl = StreamController<ScreenChangeModel>.broadcast();
  String currentScreen = UNDEFINED_SCREEN_NAME;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      updateCurrentScreen(getScreenName(route), args: route.settings.arguments as Map<String, dynamic>?);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      updateCurrentScreen(getScreenName(newRoute), args: newRoute.settings.arguments as Map<String, dynamic>?);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute) {
      updateCurrentScreen(getScreenName(previousRoute), args: route.settings.arguments as Map<String, dynamic>?);
    }
  }

  void updateCurrentScreen(String screen, {bool switchTab = false, Map<String, dynamic>? args}) {
    currentScreen = screen;
    screenChangeStreamCtrl.add(ScreenChangeModel(screenName: screen, args: args));
    if (switchTab) {
      homeTabChangeStreamCtrl.add(ScreenChangeModel(screenName: screen, args: args));
    }
    AppLogger.d('--- CURRENT SCREEN $currentScreen');
  }

  String getScreenName(Route<dynamic>? route) {
    if (route != null) {
      var screenName = route.settings.name ?? UNDEFINED_SCREEN_NAME;
      if (screenName == '/') {
        screenName = ApiService.hasToken() ? 'HomePage' : 'LoginPage';
      }
      return screenName;
    } else {
      return UNDEFINED_SCREEN_NAME;
    }
  }
}

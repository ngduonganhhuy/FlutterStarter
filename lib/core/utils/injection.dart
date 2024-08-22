import 'package:flutter/material.dart';
import 'package:flutter_stater/core/utils/app_route_observer.dart';

/// This use for global singleton like bloc, cubit,...
class Injection {
  static final appRouteObserver = AppRouteObserver();

  // Global Key
  static final navKey = GlobalKey<NavigatorState>();
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  //Bloc
}
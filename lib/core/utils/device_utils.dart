import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stater/core/utils/injection.dart';

enum ScreenType { desktop, tablet, handset, watch }

class FormFactor {
  static double desktop = 900;
  static double tablet = 600;
  static double handset = 300;

  static bool get isMobileDevice => !kIsWeb && (Platform.isIOS || Platform.isAndroid);
  static bool get isDesktopDevice => !kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux);
  static bool get isMobileDeviceOrWeb => kIsWeb || isMobileDevice;
  static bool get isDesktopDeviceOrWeb => kIsWeb || isDesktopDevice;

  static ScreenType getFormFactor(BuildContext context) {
    final deviceWidth = kIsWeb || isDesktopDevice ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.shortestSide;
    if (deviceWidth > FormFactor.desktop) return ScreenType.desktop;
    if (deviceWidth > FormFactor.tablet) return ScreenType.tablet;
    if (deviceWidth > FormFactor.handset) return ScreenType.handset;
    return ScreenType.watch;
  }

  static bool get isDesktop => getFormFactor(Injection.navKey.currentContext!) == ScreenType.desktop;
}

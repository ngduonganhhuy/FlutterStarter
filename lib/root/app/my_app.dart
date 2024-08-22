import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_stater/core/constants/constants.dart';
import 'package:flutter_stater/core/utils/injection.dart';
import 'package:flutter_stater/core_bloc/theme/theme_bloc.dart';
import 'package:flutter_stater/presentation/pages/home/home_page.dart';
import 'package:flutter_stater/root/l10n/l10n.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return ScreenUtilInit(
          //TODO replace screen size to default
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: state.appColors?.primaryColor,
                fontFamily: Constants.fontFamilyName,
              ),
              navigatorObservers: [Injection.appRouteObserver, FlutterSmartDialog.observer],
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              builder: (context, widget) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
                  child: widget ?? const SizedBox.shrink(),
                );
              },
              home: child,
            );
          },
          child: const HomePage(),
        );
      },
    );
  }
}

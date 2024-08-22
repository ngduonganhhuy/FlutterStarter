import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stater/core/utils/utils.dart';
import 'package:flutter_stater/core_bloc/theme/theme_bloc.dart';
import 'package:flutter_stater/injection_container.dart';
import 'package:flutter_stater/presentation/bloc/weather/weather_bloc.dart';
import 'package:flutter_stater/root/app/my_app.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc()..add(SetInitialTheme()),
        ),
        BlocProvider(
          create: (context) => locator<WeatherBloc>(),
        ),
      ],
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Utils.closeKeyboard(context);
        },
        child: const MyApp(),
      ),
    );
  }
}

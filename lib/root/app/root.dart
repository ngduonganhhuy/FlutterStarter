import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter/core/utils/utils.dart';
import 'package:flutter_starter/core_bloc/theme/theme_bloc.dart';
import 'package:flutter_starter/injection_container.dart';
import 'package:flutter_starter/root/app/my_app.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<ThemeBloc>()..add(SetInitialTheme()),
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

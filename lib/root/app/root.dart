import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aes_room/core/utils/utils.dart';
import 'package:aes_room/core_bloc/theme/theme_bloc.dart';
import 'package:aes_room/injection_container.dart';
import 'package:aes_room/root/app/my_app.dart';

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

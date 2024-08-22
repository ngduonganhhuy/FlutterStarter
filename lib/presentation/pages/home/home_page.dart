import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stater/core/impl/base_page.dart';
import 'package:flutter_stater/core/services/navigation_service/navigator_service.dart';
import 'package:flutter_stater/core/themes/app_colors.dart';
import 'package:flutter_stater/core/themes/app_text_styles.dart';
import 'package:flutter_stater/core/themes/app_themes.dart';
import 'package:flutter_stater/core_bloc/theme/theme_bloc.dart';
import 'package:flutter_stater/widgets/app_safe_area.dart';
import 'package:flutter_stater/widgets/app_text.dart';

class HomePage extends StatefulWidget implements BasePage {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  @override
  String get screenName => 'HomePage';
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AppSafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: AppTheme.values.length,
                itemBuilder: (context, index) {
                  final itemAppTheme = AppTheme.values[index];
                  return Card(
                    color: appColorsData[itemAppTheme]?.primaryColor,
                    child: ListTile(
                      title: MediumText(
                        itemAppTheme.toString(),
                        color: appColorsData[itemAppTheme]?.primaryColor,
                      ),
                      onTap: () {
                        context.read<ThemeBloc>().add(ToggleThemeEvent(theme: itemAppTheme));
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                NavigatorService.goToHomePage(context);
              },
              child: Text(
                'Go to weather page',
                style: appFont.size14(
                  color: appScheme.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

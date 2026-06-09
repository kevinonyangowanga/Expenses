
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:personal_finance_app/core/theme/theme_provider.dart';
import 'package:personal_finance_app/core/routing/app_router.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp.router(
          title: 'Personal Finance App',
          theme: themeProvider.lightTheme,
          darkTheme: themeProvider.darkTheme,
          themeMode: themeProvider.themeMode,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}

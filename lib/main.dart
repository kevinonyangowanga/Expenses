
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:personal_finance_app/app.dart';
import 'package:personal_finance_app/core/theme/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const App(),
    ),
  );
}

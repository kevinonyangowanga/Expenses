
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:myapp/app.dart';
import 'package:myapp/core/theme/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const App(),
    ),
  );
}

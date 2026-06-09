import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/finance_dashboard/dashboard_screen.dart';
import 'package:myapp/financial_provider.dart';
import 'package:myapp/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FinancialProvider(),
      child: MaterialApp(
        title: 'Finance App',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const FinanceDashboardScreen(),
      ),
    );
  }
}

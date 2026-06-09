import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/auth/providers/auth_provider.dart';
import 'package:myapp/premium/screens/upgrade_screen.dart';
import 'package:myapp/main.dart';
import 'package:provider/provider.dart';

class FinanceDashboard extends ConsumerWidget {
  const FinanceDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authNotifierProvider.notifier);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Dashboard'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Toggle Theme',
          ),
          IconButton(
            icon: const Icon(Icons.auto_mode),
            onPressed: () => themeProvider.setSystemTheme(),
            tooltip: 'Set System Theme',
          ),
          IconButton(
            onPressed: () {
              authNotifier.signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UpgradeScreen()),
            );
          },
          child: const Text('Upgrade to Premium'),
        ),
      ),
    );
  }
}

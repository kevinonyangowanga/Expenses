import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/premium/screens/financial_goals_screen.dart';
import 'package:myapp/insights/screens/financial_insights_screen.dart';

class UpgradeScreen extends StatelessWidget {
  const UpgradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upgrade to Premium', style: GoogleFonts.oswald(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.star, size: 100, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 24.0),
            Text(
              'Unlock Premium Features!',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Upgrade to premium to access exclusive features like financial goal tracking, debt management, and more.',
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(fontSize: 16),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FinancialGoalsScreen()),
                );
              },
              child: const Text('Financial Goals'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FinancialInsightsScreen()),
                );
              },
              child: const Text('Financial Insights'),
            ),
          ],
        ),
      ),
    );
  }
}

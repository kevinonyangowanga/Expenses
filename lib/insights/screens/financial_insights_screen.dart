import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/insights/models/financial_insight.dart';
import 'package:myapp/transactions/data/mock_transactions.dart';

class FinancialInsightsScreen extends StatelessWidget {
  const FinancialInsightsScreen({super.key});

  Future<List<FinancialInsight>> _generateInsights() async {
    // Simulate a network request
    await Future.delayed(const Duration(seconds: 2));

    // In a real app, you would use a generative AI model to analyze the transactions
    // and generate insights. For this example, we'll use a mock insight.
    final insights = [
      FinancialInsight(
        id: '1',
        title: 'Spending on Food',
        summary: 'You have spent a total of \$${mockTransactions.where((t) => t.category == 'Food').map((t) => t.amount).reduce((a, b) => a + b).toStringAsFixed(2)} on food in the last few days. Consider cooking at home to save money.',
        date: DateTime.now(),
      ),
    ];

    return insights;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Financial Insights', style: GoogleFonts.oswald(fontWeight: FontWeight.bold)),
      ),
      body: FutureBuilder<List<FinancialInsight>>(
        future: _generateInsights(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error generating insights'));
          }

          final insights = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: insights.length,
            itemBuilder: (context, index) {
              final insight = insights[index];
              return Card(
                elevation: 4.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(insight.title, style: GoogleFonts.roboto(fontSize: 18.0, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8.0),
                      Text(insight.summary, style: GoogleFonts.openSans()),
                      const SizedBox(height: 8.0),
                      Text('Generated on: ${insight.date.toLocal().toString().split(' ')[0]}', style: GoogleFonts.openSans(fontStyle: FontStyle.italic, color: Colors.grey)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

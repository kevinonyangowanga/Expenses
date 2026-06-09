import 'package:flutter/material.dart';
import 'package:myapp/reports/widgets/spending_bar_chart.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SpendingBarChart(),
      ),
    );
  }
}

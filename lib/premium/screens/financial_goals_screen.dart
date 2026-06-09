import 'package:flutter/material.dart';

class FinancialGoalsScreen extends StatelessWidget {
  const FinancialGoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Goals'),
      ),
      body: const Center(
        child: Text('Financial Goals Screen'),
      ),
    );
  }
}

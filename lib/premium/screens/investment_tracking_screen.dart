import 'package:flutter/material.dart';

class InvestmentTrackingScreen extends StatelessWidget {
  const InvestmentTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investment Tracking'),
      ),
      body: const Center(
        child: Text('Investment Tracking Screen'),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DebtTrackingScreen extends StatelessWidget {
  const DebtTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debt Tracking'),
      ),
      body: const Center(
        child: Text('Debt Tracking Screen'),
      ),
    );
  }
}

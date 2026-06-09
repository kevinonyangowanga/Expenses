import 'package:flutter/material.dart';

class SubscriptionManagementScreen extends StatelessWidget {
  const SubscriptionManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription Management'),
      ),
      body: const Center(
        child: Text('Subscription Management Screen'),
      ),
    );
  }
}

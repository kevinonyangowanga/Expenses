import 'package:flutter/material.dart';

class NetWorthDashboardScreen extends StatelessWidget {
  const NetWorthDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Net Worth Dashboard'),
      ),
      body: const Center(
        child: Text('Net Worth Dashboard Screen'),
      ),
    );
  }
}

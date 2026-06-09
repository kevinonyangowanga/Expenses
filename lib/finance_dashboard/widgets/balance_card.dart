import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Total Balance'),
            const SizedBox(height: 8),
            const Text(
              '\$12,345.67',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('**** **** **** 1234'),
                Image.asset(
                  'assets/images/mastercard-logo.png', 
                  height: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

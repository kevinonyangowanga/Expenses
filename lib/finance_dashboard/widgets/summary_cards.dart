import 'package:flutter/material.dart';

class SummaryCards extends StatelessWidget {
  const SummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: SummaryCard(
            title: 'Income',
            amount: '\$5,000',
            icon: Icons.arrow_upward,
            color: Colors.green,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: SummaryCard(
            title: 'Expenses',
            amount: '\$2,500',
            icon: Icons.arrow_downward,
            color: Colors.red,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: SummaryCard(
            title: 'Savings',
            amount: '\$1,000',
            icon: Icons.savings,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;
  final Color color;

  const SummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                Icon(icon, color: color),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              amount,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

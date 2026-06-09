import 'package:flutter/material.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Recent Transactions'),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const TransactionTile(
                  title: 'Starbucks',
                  subtitle: 'Coffee',
                  amount: '-\$5.45',
                  icon: Icons.local_cafe,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final IconData icon;

  const TransactionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(icon),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

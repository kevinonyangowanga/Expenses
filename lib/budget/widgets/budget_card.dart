import 'package:flutter/material.dart';

class BudgetCard extends StatelessWidget {
  final String category;
  final double amount;
  final double spent;

  const BudgetCard({
    super.key,
    required this.category,
    required this.amount,
    required this.spent,
  });

  @override
  Widget build(BuildContext context) {
    final remaining = amount - spent;
    final progress = spent / amount;
    final isOverspent = spent > amount;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Remaining: \$${remaining.toStringAsFixed(2)}'),
                Text('Spent: \$${spent.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 8.0),
            LinearProgressIndicator(
              value: progress,
              minHeight: 10.0,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                isOverspent ? Colors.red : Theme.of(context).colorScheme.primary,
              ),
            ),
            if (isOverspent)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Overspent!',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

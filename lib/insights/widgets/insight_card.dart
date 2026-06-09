import 'package:flutter/material.dart';
import 'package:myapp/insights/models/financial_insight.dart';

class InsightCard extends StatelessWidget {
  final FinancialInsight insight;

  const InsightCard({super.key, required this.insight});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(insight.icon, color: insight.color, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    insight.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              insight.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '${insight.date.day}/${insight.date.month}/${insight.date.year}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

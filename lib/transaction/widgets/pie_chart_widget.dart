import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/transaction/notifiers/transaction_notifier.dart';

class PieChartWidget extends ConsumerWidget {
  const PieChartWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionProvider);

    if (transactions.isEmpty) {
      return const Center(child: Text('No transactions yet'));
    }

    final Map<String, double> categorySpending = {};
    for (final transaction in transactions) {
      categorySpending.update(
        transaction.category.name,
        (value) => value + transaction.amount,
        ifAbsent: () => transaction.amount,
      );
    }

    final totalSpending = categorySpending.values.fold(0.0, (sum, amount) => sum + amount);

    return PieChart(
      PieChartData(
        sections: categorySpending.entries.map((entry) {
          final percentage = (entry.value / totalSpending) * 100;
          return PieChartSectionData(
            value: percentage,
            title: '${entry.key}\n${percentage.toStringAsFixed(1)}%',
            titleStyle: const TextStyle(fontSize: 12),
          );
        }).toList(),
      ),
    );
  }
}

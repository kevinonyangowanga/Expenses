import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/transaction/notifiers/transaction_notifier.dart';

class SpendingBarChart extends ConsumerWidget {
  const SpendingBarChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionProvider);

    final spendingByCategory = <String, double>{};
    for (var transaction in transactions) {
      spendingByCategory.update(
        transaction.category.name,
        (value) => value + transaction.amount,
        ifAbsent: () => transaction.amount,
      );
    }

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: spendingByCategory.values.reduce((a, b) => a > b ? a : b) * 1.2,
        barGroups: spendingByCategory.entries.map((entry) {
          return BarChartGroupData(
            x: spendingByCategory.keys.toList().indexOf(entry.key),
            barRods: [
              BarChartRodData(
                toY: entry.value,
                width: 15,
                color: Colors.amber,
              )
            ],
          );
        }).toList(),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < spendingByCategory.keys.length) {
                  return Text(spendingByCategory.keys.toList()[index]);
                }
                return const Text('');
              },
            ),
          ),
        ),
      ),
    );
  }
}

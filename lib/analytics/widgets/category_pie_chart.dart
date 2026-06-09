import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/transaction/providers/transaction_provider.dart';

class CategoryPieChart extends ConsumerWidget {
  final DateTimeRange? dateRange;

  const CategoryPieChart({super.key, this.dateRange});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionProvider);

    final filteredTransactions = dateRange == null
        ? transactions
        : transactions.where((t) {
            return t.date.isAfter(dateRange!.start) &&
                t.date.isBefore(dateRange!.end);
          }).toList();

    final categorySpending = <String, double>{};
    for (var t in filteredTransactions) {
      categorySpending.update(t.category, (value) => value + t.amount,
          ifAbsent: () => t.amount);
    }

    final pieChartSections = categorySpending.entries.map((entry) {
      return PieChartSectionData(
        color: Colors.primaries[entry.key.hashCode % Colors.primaries.length],
        value: entry.value,
        title: '${entry.key}\n\$${entry.value.toStringAsFixed(2)}',
        radius: 80,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    return PieChart(
      PieChartData(
        sections: pieChartSections,
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            // Implement touch interaction here
          },
        ),
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/budget/providers/budget_provider.dart';
import 'package:myapp/transaction/providers/transaction_provider.dart';

class BudgetVsActualBarChart extends ConsumerWidget {
  final DateTimeRange? dateRange;

  const BudgetVsActualBarChart({super.key, this.dateRange});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgets = ref.watch(budgetProvider);
    final transactions = ref.watch(transactionProvider);

    final filteredTransactions = dateRange == null
        ? transactions
        : transactions.where((t) {
            return t.date.isAfter(dateRange!.start) &&
                t.date.isBefore(dateRange!.end);
          }).toList();

    final barGroups = <BarChartGroupData>[];
    for (var i = 0; i < budgets.length; i++) {
      final budget = budgets[i];
      final spent = filteredTransactions
          .where((t) => t.category == budget.category)
          .fold(0.0, (sum, t) => sum + t.amount);

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: budget.amount,
              color: Theme.of(context).colorScheme.primary,
              width: 16,
            ),
            BarChartRodData(
              toY: spent,
              color: Theme.of(context).colorScheme.secondary,
              width: 16,
            ),
          ],
        ),
      );
    }

    return BarChart(
      BarChartData(
        barGroups: barGroups,
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() < budgets.length) {
                  return Text(budgets[value.toInt()].category);
                }
                return const Text('');
              },
            ),
          ),
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Theme.of(context).colorScheme.background,
          ),
        ),
      ),
    );
  }
}

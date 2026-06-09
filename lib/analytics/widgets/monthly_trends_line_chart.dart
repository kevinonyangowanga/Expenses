import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/transaction/providers/transaction_provider.dart';
import 'package:collection/collection.dart';

class MonthlyTrendsLineChart extends ConsumerWidget {
  final DateTimeRange? dateRange;

  const MonthlyTrendsLineChart({super.key, this.dateRange});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionProvider);

    final filteredTransactions = dateRange == null
        ? transactions
        : transactions.where((t) {
            return t.date.isAfter(dateRange!.start) &&
                t.date.isBefore(dateRange!.end);
          }).toList();

    final monthlySpending = <int, double>{};
    for (var t in filteredTransactions) {
      monthlySpending.update(t.date.month, (value) => value + t.amount,
          ifAbsent: () => t.amount);
    }

    final lineBarsData = [
      LineChartBarData(
        spots: monthlySpending.entries
            .map((e) => FlSpot(e.key.toDouble(), e.value))
            .toList(),
        isCurved: true,
        color: Theme.of(context).colorScheme.primary,
        barWidth: 4,
        isStrokeCapRound: true,
        belowBarData: BarAreaData(
          show: true,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
      ),
    ];

    return LineChart(
      LineChartData(
        lineBarsData: lineBarsData,
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const monthAbbreviations = {
                  1: 'Jan',
                  2: 'Feb',
                  3: 'Mar',
                  4: 'Apr',
                  5: 'May',
                  6: 'Jun',
                  7: 'Jul',
                  8: 'Aug',
                  9: 'Sep',
                  10: 'Oct',
                  11: 'Nov',
                  12: 'Dec',
                };
                return Text(monthAbbreviations[value.toInt()] ?? '');
              },
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Theme.of(context).colorScheme.background,
          ),
        ),
      ),
    );
  }
}

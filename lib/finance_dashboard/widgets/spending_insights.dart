import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SpendingInsights extends StatelessWidget {
  const SpendingInsights({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Spending Insights'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(value: 40, color: Colors.blue, title: 'Food'),
                          PieChartSectionData(value: 25, color: Colors.green, title: 'Transport'),
                          PieChartSectionData(value: 20, color: Colors.orange, title: 'Shopping'),
                          PieChartSectionData(value: 15, color: Colors.red, title: 'Other'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChartLegend(color: Colors.blue, text: 'Food'),
                    SizedBox(height: 4),
                    ChartLegend(color: Colors.green, text: 'Transport'),
                    SizedBox(height: 4),
                    ChartLegend(color: Colors.orange, text: 'Shopping'),
                    SizedBox(height: 4),
                    ChartLegend(color: Colors.red, text: 'Other'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChartLegend extends StatelessWidget {
  final Color color;
  final String text;

  const ChartLegend({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}

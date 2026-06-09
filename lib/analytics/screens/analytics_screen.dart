import 'package:flutter/material.dart';
import 'package:myapp/analytics/widgets/budget_vs_actual_bar_chart.dart';
import 'package:myapp/analytics/widgets/category_pie_chart.dart';
import 'package:myapp/analytics/widgets/monthly_trends_line_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  DateTimeRange? _selectedDateRange;

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        actions: [
          IconButton(
            onPressed: () => _selectDateRange(context),
            icon: const Icon(Icons.calendar_today),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SizedBox(
            height: 300,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Category Spending',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Expanded(child: CategoryPieChart(dateRange: _selectedDateRange)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            height: 300,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Budget vs. Actual',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Expanded(child: BudgetVsActualBarChart(dateRange: _selectedDateRange)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            height: 300,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Monthly Trends',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Expanded(child: MonthlyTrendsLineChart(dateRange: _selectedDateRange)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

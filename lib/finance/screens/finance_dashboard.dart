import 'package:flutter/material.dart';
import 'package:myapp/analytics/screens/analytics_screen.dart';
import 'package:myapp/budget/screens/budget_screen.dart';
import 'package:myapp/insights/screens/insights_screen.dart';
import 'package:myapp/transaction/screens/transaction_screen.dart';

class FinanceDashboard extends StatefulWidget {
  const FinanceDashboard({super.key});

  @override
  State<FinanceDashboard> createState() => _FinanceDashboardState();
}

class _FinanceDashboardState extends State<FinanceDashboard> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    BudgetScreen(),
    TransactionScreen(),
    AnalyticsScreen(),
    InsightsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Budget',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Insights',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

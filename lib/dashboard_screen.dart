import 'package:flutter/material.dart';
import 'package:myapp/category_screen.dart';
import 'package:myapp/theme.dart';
import 'package:myapp/transaction_screen.dart';
import 'package:myapp/widgets/charts.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TransactionScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.category),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CategoryScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummary(context),
              const SizedBox(height: 24),
              _buildBudgets(context),
              const SizedBox(height: 24),
              _buildCharts(context),
              const SizedBox(height: 24),
              _buildRecentTransactions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummary(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Total Balance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '\$1,234.56',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat('Income', '\$2,500.00', Colors.green),
                _buildStat('Expenses', '\$1,265.44', Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String amount, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildBudgets(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Budgets',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildBudgetCard(
                context,
                'Groceries',
                Icons.shopping_cart,
                Colors.orange,
                250.00,
                500.00,
              ),
              _buildBudgetCard(
                context,
                'Transport',
                Icons.directions_bus,
                Colors.blue,
                100.00,
                200.00,
              ),
              _buildBudgetCard(
                context,
                'Entertainment',
                Icons.movie,
                Colors.purple,
                50.00,
                150.00,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBudgetCard(
    BuildContext context,
    String category, 
    IconData icon,
    Color color, 
    double spent, 
    double budget) {
    final percentage = spent / budget;

    return Card(
      child: SizedBox(
        width: 150,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 8),
              Text(
                category,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '\$${spent.toStringAsFixed(2)} / \$${budget.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: percentage,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCharts(BuildContext context) {
    return const Column(
      children: [
        CategoryPieChart(),
        SizedBox(height: 24),
        SpendingLineChart(),
      ],
    );
  }

  Widget _buildRecentTransactions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Transactions',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildTransactionItem(
          'Netflix', 
          'Entertainment', 
          '\$15.99', 
          'June 25'),
        _buildTransactionItem(
          'Shell', 
          'Transport', 
          '\$45.50', 
          'June 24'
        ),
        _buildTransactionItem(
          'Starbucks', 
          'Food', 
          '\$5.25', 
          'June 23'
        ),
      ],
    );
  }

  Widget _buildTransactionItem(
    String title, String category, String amount, String date) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.payment, color: AppTheme.primaryColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(category),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amount,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.red,
              ),
            ),
            Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
            tooltip: 'Notifications',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildBalanceCard(context, colorScheme),
          const SizedBox(height: 24),
          _buildSectionHeader(context, 'Budgets'),
          const SizedBox(height: 16),
          _buildBudgets(context, colorScheme),
          const SizedBox(height: 24),
          _buildSectionHeader(context, 'Recent Activity'),
          const SizedBox(height: 16),
          _buildRecentActivity(context, colorScheme),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.tertiary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Balance',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: colorScheme.onPrimary),
          ),
          const SizedBox(height: 8),
          Text(
            '\$12,345.67',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(color: colorScheme.onPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget _buildBudgets(BuildContext context, ColorScheme colorScheme) {
    // Replace with actual data
    final budgets = [
      {'category': 'Groceries', 'spent': 250.0, 'total': 500.0, 'icon': Icons.shopping_cart},
      {'category': 'Entertainment', 'spent': 150.0, 'total': 200.0, 'icon': Icons.movie},
      {'category': 'Transport', 'spent': 80.0, 'total': 100.0, 'icon': Icons.directions_car},
    ];

    if (budgets.isEmpty) {
      return _buildEmptyState(
        context,
        icon: Icons.pie_chart_outline,
        message: 'No budgets created yet.',
        suggestion: 'Create your first budget to start tracking your spending.',
        buttonText: 'Create Budget',
        onPressed: () {},
      );
    }

    return Column(
      children: budgets.map((budget) => _buildBudgetCard(context, colorScheme, budget)).toList(),
    );
  }

  Widget _buildBudgetCard(BuildContext context, ColorScheme colorScheme, Map<String, dynamic> budget) {
    final double progress = budget['spent'] / budget['total'];
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(budget['icon'], color: colorScheme.primary),
                const SizedBox(width: 16),
                Text(budget['category'], style: Theme.of(context).textTheme.titleMedium),
                const Spacer(),
                Text('\$${budget['spent']} / \$${budget['total']}', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: colorScheme.surfaceVariant,
              valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context, ColorScheme colorScheme) {
    // Replace with actual data
    final activities = [
      {'name': 'Netflix Subscription', 'amount': -15.99, 'date': 'Today'},
      {'name': 'Salary Deposit', 'amount': 2500.00, 'date': 'Yesterday'},
      {'name': 'Coffee Shop', 'amount': -4.50, 'date': 'Yesterday'},
    ];

    if (activities.isEmpty) {
      return _buildEmptyState(
        context,
        icon: Icons.receipt_long_outlined,
        message: 'No transactions yet.',
        suggestion: 'Add your first transaction to get started.',
        buttonText: 'Add Transaction',
        onPressed: () {},
      );
    }

    return Card(
      child: Column(
        children: activities.map((activity) {
          final isExpense = activity['amount']! < 0;
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: isExpense ? colorScheme.errorContainer : colorScheme.primaryContainer,
              child: Icon(
                isExpense ? Icons.arrow_downward : Icons.arrow_upward,
                color: isExpense ? colorScheme.onErrorContainer : colorScheme.onPrimaryContainer,
              ),
            ),
            title: Text(activity['name']! as String, style: Theme.of(context).textTheme.titleMedium),
            subtitle: Text(activity['date']! as String, style: Theme.of(context).textTheme.bodyMedium),
            trailing: Text(
              '\$${activity['amount']!.abs().toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isExpense ? colorScheme.error : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, {
    required IconData icon,
    required String message,
    required String suggestion,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                suggestion,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onPressed,
                icon: const Icon(Icons.add),
                label: Text(buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

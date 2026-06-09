import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/budget/providers/budget_provider.dart';
import 'package:myapp/budget/widgets/add_budget_dialog.dart';
import 'package:myapp/budget/widgets/budget_card.dart';
import 'package:myapp/transaction/providers/transaction_provider.dart';

class BudgetScreen extends ConsumerWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgets = ref.watch(budgetProvider);
    final transactions = ref.watch(transactionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget'),
      ),
      body: ListView.builder(
        itemCount: budgets.length,
        itemBuilder: (context, index) {
          final budget = budgets[index];
          final spent = transactions
              .where((t) => t.category == budget.category)
              .fold(0.0, (sum, t) => sum + t.amount);

          return BudgetCard(
            category: budget.category,
            amount: budget.amount,
            spent: spent,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddBudgetDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

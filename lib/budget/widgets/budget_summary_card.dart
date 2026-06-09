import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/budget/notifiers/budget_analysis_provider.dart';
import 'package:myapp/budget/models/budget_model.dart';
import 'package:myapp/budget/notifiers/budget_notifier.dart';
import 'package:myapp/budget/screens/edit_budget_screen.dart';

class BudgetSummaryCard extends ConsumerWidget {
  final Budget budget;

  const BudgetSummaryCard({super.key, required this.budget});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analysis = ref.watch(budgetAnalysisProvider)[budget.category.id];

    if (analysis == null) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(budget.category.name, style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 8.0),
            LinearProgressIndicator(
              value: analysis.percent,
              backgroundColor: Colors.grey[300],
              color: analysis.percent > 1.0 ? Colors.red : Colors.blue,
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Spent: ${analysis.spent.toStringAsFixed(2)}'),
                Text('Budget: ${budget.amount.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 8.0),
            Text('Remaining: ${analysis.remaining.toStringAsFixed(2)}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditBudgetScreen(budget: budget),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ref.read(budgetProvider.notifier).deleteBudget(budget.id);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

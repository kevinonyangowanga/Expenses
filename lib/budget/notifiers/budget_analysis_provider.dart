import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/budget/notifiers/budget_notifier.dart';
import 'package:myapp/transaction/notifiers/transaction_notifier.dart';

class BudgetAnalysis {
  final double budget;
  final double spent;

  BudgetAnalysis({required this.budget, required this.spent});

  double get remaining => budget - spent;
  double get percent => spent / budget;
}

final budgetAnalysisProvider = Provider<Map<String, BudgetAnalysis>>((ref) {
  final budgets = ref.watch(budgetProvider);
  final transactions = ref.watch(transactionProvider);

  final analysis = <String, BudgetAnalysis>{};

  for (final budget in budgets) {
    final spent = transactions
        .where((t) => t.category.id == budget.category.id)
        .fold(0.0, (sum, t) => sum + t.amount);
    analysis[budget.category.id] = BudgetAnalysis(budget: budget.amount, spent: spent);
  }

  return analysis;
});

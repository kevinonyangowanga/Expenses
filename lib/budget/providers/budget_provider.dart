import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:myapp/budget/models/budget.dart';
import 'package:uuid/uuid.dart';

final budgetProvider = StateNotifierProvider<BudgetNotifier, List<Budget>>((ref) {
  return BudgetNotifier();
});

class BudgetNotifier extends StateNotifier<List<Budget>> {
  BudgetNotifier() : super([]) {
    _loadBudgets();
  }

  final _budgetsBox = Hive.box<Budget>('budgets');
  final _uuid = const Uuid();

  void _loadBudgets() {
    state = _budgetsBox.values.toList();
  }

  void addBudget(String category, double amount) {
    final newBudget = Budget(
      id: _uuid.v4(),
      category: category,
      amount: amount,
    );
    _budgetsBox.put(newBudget.id, newBudget);
    state = [...state, newBudget];
  }
}

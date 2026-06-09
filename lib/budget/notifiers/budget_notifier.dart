import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/budget/models/budget_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BudgetNotifier extends StateNotifier<List<Budget>> {
  BudgetNotifier() : super([]);

  void addBudget(Budget budget) {
    state = [...state, budget];
    _saveBudgets();
  }

  void editBudget(Budget budget) {
    state = [
      for (final b in state)
        if (b.id == budget.id) budget else b,
    ];
    _saveBudgets();
  }

  void deleteBudget(String id) {
    state = state.where((b) => b.id != id).toList();
    _saveBudgets();
  }

  Future<void> _saveBudgets() async {
    final prefs = await SharedPreferences.getInstance();
    final budgets = state.map((b) => jsonEncode(b.toMap())).toList();
    await prefs.setStringList('budgets', budgets);
  }

  Future<void> loadBudgets() async {
    final prefs = await SharedPreferences.getInstance();
    final budgetStrings = prefs.getStringList('budgets');
    if (budgetStrings != null) {
      state = budgetStrings.map((b) => Budget.fromMap(jsonDecode(b))).toList();
    }
  }
}

final budgetProvider = StateNotifierProvider<BudgetNotifier, List<Budget>>((ref) => BudgetNotifier());

import 'package:flutter/material.dart';
import 'package:myapp/models.dart';

class FinancialProvider with ChangeNotifier {
  final List<Transaction> _transactions = [];
  final List<FinancialCategory> _categories = [
    FinancialCategory(id: '1', name: 'Groceries'),
    FinancialCategory(id: '2', name: 'Transport'),
    FinancialCategory(id: '3', name: 'Entertainment'),
    FinancialCategory(id: '4', name: 'Food'),
  ];
  final List<Budget> _budgets = [];

  List<Transaction> get transactions => _transactions;
  List<FinancialCategory> get categories => _categories;
  List<Budget> get budgets => _budgets;

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }

  void addCategory(FinancialCategory category) {
    _categories.add(category);
    notifyListeners();
  }

  void updateCategory(FinancialCategory category) {
    final index = _categories.indexWhere((c) => c.id == category.id);
    if (index != -1) {
      _categories[index] = category;
      notifyListeners();
    }
  }

  void deleteCategory(String id) {
    _categories.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  void addBudget(Budget budget) {
    _budgets.add(budget);
    notifyListeners();
  }
}

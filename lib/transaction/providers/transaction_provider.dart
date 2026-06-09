import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:myapp/transaction/models/transaction.dart';
import 'package:uuid/uuid.dart';

final transactionProvider = StateNotifierProvider<TransactionNotifier, List<Transaction>>((ref) {
  return TransactionNotifier();
});

class TransactionNotifier extends StateNotifier<List<Transaction>> {
  TransactionNotifier() : super([]) {
    _loadTransactions();
  }

  final _transactionsBox = Hive.box<Transaction>('transactions');
  final _uuid = const Uuid();

  void _loadTransactions() {
    state = _transactionsBox.values.toList();
  }

  void addTransaction(String title, double amount, String category, DateTime date) {
    final newTransaction = Transaction(
      id: _uuid.v4(),
      title: title,
      amount: amount,
      category: category,
      date: date,
    );
    _transactionsBox.put(newTransaction.id, newTransaction);
    state = [...state, newTransaction];
  }
}

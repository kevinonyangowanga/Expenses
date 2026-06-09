import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/services/firestore_service.dart';
import 'package:myapp/transaction/models/categories.dart';
import 'package:myapp/transaction/models/transaction.dart';

final transactionProvider = StateNotifierProvider<TransactionNotifier, List<Transaction>>((ref) {
  return TransactionNotifier();
});

class TransactionNotifier extends StateNotifier<List<Transaction>> {
  final FirestoreService _firestoreService = FirestoreService();

  TransactionNotifier() : super([]) {
    _firestoreService.getTransactions().listen((transactions) {
      state = transactions;
    });
  }

  Future<void> addTransaction(String title, double amount, DateTime date, String categoryId) async {
    final category = categories.firstWhere((cat) => cat.id == categoryId);
    final newTransaction = Transaction(
      id: '_temp_id', // Temporary ID, Firestore will generate one
      title: title,
      amount: amount,
      date: date,
      category: category,
    );
    await _firestoreService.addTransaction(newTransaction);
  }

  Future<void> editTransaction(String id, String title, double amount, DateTime date, String categoryId) async {
    final category = categories.firstWhere((cat) => cat.id == categoryId);
    final updatedTransaction = Transaction(
      id: id,
      title: title,
      amount: amount,
      date: date,
      category: category,
    );
    await _firestoreService.updateTransaction(updatedTransaction);
  }

  Future<void> deleteTransaction(String id) async {
    await _firestoreService.deleteTransaction(id);
  }
}

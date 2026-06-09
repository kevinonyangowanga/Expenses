import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/transaction/models/transaction_model.dart';

class FinancialProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late final CollectionReference<Transaction> _transactionsRef;
  late final CollectionReference<FinancialCategory> _categoriesRef;
  late final CollectionReference<Budget> _budgetsRef;

  List<Transaction> _transactions = [];
  List<FinancialCategory> _categories = [];
  List<Budget> _budgets = [];

  List<Transaction> get transactions => _transactions;
  List<FinancialCategory> get categories => _categories;
  List<Budget> get budgets => _budgets;

  FinancialProvider() {
    final user = _auth.currentUser;
    if (user != null) {
      _transactionsRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('transactions')
          .withConverter<Transaction>(
            fromFirestore: (snapshots, _) => Transaction.fromMap(snapshots.data()!),
            toFirestore: (transaction, _) => transaction.toMap(),
          );
      _categoriesRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('categories')
          .withConverter<FinancialCategory>(
            fromFirestore: (snapshots, _) =>
                FinancialCategory.fromMap(snapshots.data()!),
            toFirestore: (category, _) => category.toMap(),
          );
      _budgetsRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('budgets')
          .withConverter<Budget>(
            fromFirestore: (snapshots, _) => Budget.fromMap(snapshots.data()!),
            toFirestore: (budget, _) => budget.toMap(),
          );
      fetchData();
    }
  }

  Future<void> fetchData() async {
    _transactions = await _transactionsRef
        .get()
        .then((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
    _categories = await _categoriesRef
        .get()
        .then((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
    _budgets = await _budgetsRef
        .get()
        .then((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
    notifyListeners();
  }

  Future<void> addTransaction(Transaction transaction) async {
    await _transactionsRef.add(transaction);
    await fetchData();
  }

  Future<void> addCategory(FinancialCategory category) async {
    await _categoriesRef.add(category);
    await fetchData();
  }

  Future<void> updateCategory(FinancialCategory category) async {
    await _categoriesRef.doc(category.id).update(category.toMap());
    await fetchData();
  }

  Future<void> deleteCategory(String id) async {
    await _categoriesRef.doc(id).delete();
    await fetchData();
  }

  Future<void> addBudget(Budget budget) async {
    await _budgetsRef.add(budget);
    await fetchData();
  }
}

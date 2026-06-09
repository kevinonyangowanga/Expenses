import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/transaction/models/financial_category.dart';
import 'package:myapp/transaction/models/transaction.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Transaction>> getTransactions() {
    final user = _auth.currentUser;
    if (user == null) {
      return Stream.value([]);
    }
    return _db
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return Transaction(
                id: doc.id,
                title: data['title'] ?? '',
                amount: (data['amount'] ?? 0).toDouble(),
                date: (data['date'] as Timestamp).toDate(),
                category: FinancialCategory(
                  id: data['category']['id'] ?? '',
                  name: data['category']['name'] ?? '',
                  icon: data['category']['icon'] ?? '',
                ),
              );
            }).toList());
  }

  Future<void> addTransaction(Transaction transaction) {
    final user = _auth.currentUser;
    if (user == null) {
      return Future.value();
    }
    return _db.collection('users').doc(user.uid).collection('transactions').add({
      'title': transaction.title,
      'amount': transaction.amount,
      'date': transaction.date,
      'category': {
        'id': transaction.category.id,
        'name': transaction.category.name,
        'icon': transaction.category.icon,
      },
    });
  }

  Future<void> updateTransaction(Transaction transaction) {
    final user = _auth.currentUser;
    if (user == null) {
      return Future.value();
    }
    return _db
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .doc(transaction.id)
        .update({
      'title': transaction.title,
      'amount': transaction.amount,
      'date': transaction.date,
      'category': {
        'id': transaction.category.id,
        'name': transaction.category.name,
        'icon': transaction.category.icon,
      },
    });
  }

  Future<void> deleteTransaction(String id) {
    final user = _auth.currentUser;
    if (user == null) {
      return Future.value();
    }
    return _db.collection('users').doc(user.uid).collection('transactions').doc(id).delete();
  }
}

import 'package:myapp/transactions/models/transaction.dart';

final List<Transaction> mockTransactions = [
  Transaction(
    id: '1',
    title: 'Groceries',
    amount: 75.50,
    category: 'Food',
    date: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Transaction(
    id: '2',
    title: 'Gas',
    amount: 45.20,
    category: 'Transportation',
    date: DateTime.now().subtract(const Duration(days: 2)),
  ),
  Transaction(
    id: '3',
    title: 'Rent',
    amount: 1200.00,
    category: 'Housing',
    date: DateTime.now().subtract(const Duration(days: 3)),
  ),
  Transaction(
    id: '4',
    title: 'Dinner',
    amount: 60.00,
    category: 'Food',
    date: DateTime.now().subtract(const Duration(days: 4)),
  ),
  Transaction(
    id: '5',
    title: 'Movie Tickets',
    amount: 25.00,
    category: 'Entertainment',
    date: DateTime.now().subtract(const Duration(days: 5)),
  ),
];

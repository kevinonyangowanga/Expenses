import 'package:myapp/transaction/models/financial_category.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final FinancialCategory category;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  Transaction.fromMap(Map<String, dynamic> data) :
    id = data['id'],
    title = data['title'],
    amount = data['amount'],
    date = DateTime.parse(data['date']),
    category = FinancialCategory.fromMap(data['category']);

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'amount': amount,
        'date': date.toIso8601String(),
        'category': category.toMap(),
      };
}

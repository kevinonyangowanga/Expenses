import 'package:myapp/transaction/models/financial_category.dart';

class Budget {
  final String id;
  final FinancialCategory category;
  final double amount;

  Budget({
    required this.id,
    required this.category,
    required this.amount,
  });

  Budget.fromMap(Map<String, dynamic> data) :
    id = data['id'],
    category = FinancialCategory.fromMap(data['category']),
    amount = data['amount'];

  Map<String, dynamic> toMap() => {
        'id': id,
        'category': category.toMap(),
        'amount': amount,
      };
}

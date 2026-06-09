import 'package:flutter/material.dart';

class FinancialCategory {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  FinancialCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

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
    date = data['date'].toDate(),
    category = FinancialCategory(id: data['category']['id'], name: data['category']['name'], icon: IconData(data['category']['icon'], fontFamily: 'MaterialIcons'), color: Color(data['category']['color']));

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'amount': amount,
        'date': date,
        'category': {
          'id': category.id,
          'name': category.name,
          'icon': category.icon.codePoint,
          'color': category.color.value,
        },
      };
}

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
    category = FinancialCategory(id: data['category']['id'], name: data['category']['name'], icon: IconData(data['category']['icon'], fontFamily: 'MaterialIcons'), color: Color(data['category']['color'])),
    amount = data['amount'];

  Map<String, dynamic> toMap() => {
        'id': id,
        'category': {
          'id': category.id,
          'name': category.name,
          'icon': category.icon.codePoint,
          'color': category.color.value,
        },
        'amount': amount,
      };
}

import 'package:flutter/material.dart';

enum TransactionType { income, expense }

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
  final double amount;
  final DateTime date;
  final String categoryId;
  final TransactionType type;
  final String description;

  Transaction({
    required this.id,
    required this.amount,
    required this.date,
    required this.categoryId,
    required this.type,
    this.description = '',
  });
}

class Budget {
  final String id;
  final String categoryId;
  final double amount;
  final DateTime startDate;
  final DateTime endDate;

  Budget({
    required this.id,
    required this.categoryId,
    required this.amount,
    required this.startDate,
    required this.endDate,
  });
}

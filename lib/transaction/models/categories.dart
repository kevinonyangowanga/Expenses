import 'package:flutter/material.dart';
import 'package:myapp/transaction/models/financial_category.dart';

final List<FinancialCategory> categories = [
  const FinancialCategory(id: '1', name: 'Groceries', icon: Icons.shopping_cart),
  const FinancialCategory(id: '2', name: 'Transport', icon: Icons.directions_bus),
  const FinancialCategory(id: '3', name: 'Entertainment', icon: Icons.movie),
  const FinancialCategory(id: '4', name: 'Bills', icon: Icons.receipt),
  const FinancialCategory(id: '5', name: 'Other', icon: Icons.category),
];

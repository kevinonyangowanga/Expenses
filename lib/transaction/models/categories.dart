import 'package:flutter/material.dart';
import 'package:myapp/transaction/models/transaction_model.dart';

final List<FinancialCategory> categories = [
  FinancialCategory(id: '1', name: 'Groceries', icon: Icons.shopping_cart, color: Colors.green),
  FinancialCategory(id: '2', name: 'Bills', icon: Icons.receipt, color: Colors.red),
  FinancialCategory(id: '3', name: 'Salary', icon: Icons.attach_money, color: Colors.blue),
];

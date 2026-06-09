import 'package:flutter/material.dart';
import 'package:myapp/transaction/widgets/add_transaction_form.dart';
import 'package:myapp/transaction/widgets/transaction_list.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: const Column(
        children: [
          AddTransactionForm(),
          Expanded(child: TransactionList()),
        ],
      ),
    );
  }
}

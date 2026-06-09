import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/transaction/models/transaction_model.dart';
import 'package:myapp/transaction/notifiers/transaction_notifier.dart';
import 'package:myapp/transaction/screens/add_transaction_screen.dart';
import 'package:myapp/transaction/screens/edit_transaction_screen.dart';

class FinanceDashboardScreen extends ConsumerWidget {
  const FinanceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Dashboard'),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return ListTile(
            title: Text(transaction.title),
            subtitle: Text(transaction.category.name),
            trailing: Text(transaction.amount.toString()),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditTransactionScreen(transaction: transaction),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddTransactionScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

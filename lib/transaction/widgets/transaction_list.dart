import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/transaction/providers/transaction_provider.dart';

class TransactionList extends ConsumerWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionProvider);

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ListTile(
          title: Text(transaction.title),
          subtitle: Text(transaction.category),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('\$${transaction.amount.toStringAsFixed(2)}'),
              Text(transaction.date.toLocal().toString().split(' ')[0]),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/budget/models/budget_model.dart';
import 'package:myapp/budget/notifiers/budget_notifier.dart';

class EditBudgetScreen extends ConsumerWidget {
  final Budget budget;

  const EditBudgetScreen({super.key, required this.budget});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    final _amountController = TextEditingController(text: budget.amount.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Budget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text('Category: ${budget.category.name}'),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedBudget = Budget(
                      id: budget.id,
                      category: budget.category,
                      amount: double.parse(_amountController.text),
                    );
                    ref.read(budgetProvider.notifier).editBudget(updatedBudget);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

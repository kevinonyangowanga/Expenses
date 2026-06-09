import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/budget/models/budget_model.dart';
import 'package:myapp/budget/notifiers/budget_notifier.dart';
import 'package:myapp/transaction/models/categories.dart';
import 'package:myapp/transaction/models/financial_category.dart';

class AddBudgetScreen extends ConsumerWidget {
  const AddBudgetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    FinancialCategory? _selectedCategory;
    final _amountController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Budget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<FinancialCategory>(
                items: categories.map((category) {
                  return DropdownMenuItem<FinancialCategory>(
                    value: category,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (value) {
                  _selectedCategory = value;
                },
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
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
                    final budget = Budget(
                      id: DateTime.now().toString(),
                      category: _selectedCategory!,
                      amount: double.parse(_amountController.text),
                    );
                    ref.read(budgetProvider.notifier).addBudget(budget);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Add Budget'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

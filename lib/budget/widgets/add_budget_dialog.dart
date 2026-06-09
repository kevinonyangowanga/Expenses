import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/budget/providers/budget_provider.dart';

class AddBudgetDialog extends ConsumerStatefulWidget {
  const AddBudgetDialog({super.key});

  @override
  ConsumerState<AddBudgetDialog> createState() => _AddBudgetDialogState();
}

class _AddBudgetDialogState extends ConsumerState<AddBudgetDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _category;
  double? _amount;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Budget'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Category',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a category';
                }
                return null;
              },
              onSaved: (value) {
                _category = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
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
              onSaved: (value) {
                _amount = double.tryParse(value!);
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              ref.read(budgetProvider.notifier).addBudget(_category!, _amount!);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

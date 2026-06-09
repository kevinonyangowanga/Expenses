import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/transaction/providers/transaction_provider.dart';

class AddTransactionForm extends ConsumerStatefulWidget {
  const AddTransactionForm({super.key});

  @override
  ConsumerState<AddTransactionForm> createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends ConsumerState<AddTransactionForm> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  double? _amount;
  String? _category;
  DateTime _date = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
              onSaved: (value) {
                _title = value;
              },
            ),
            TextFormField(
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
              onSaved: (value) {
                _amount = double.tryParse(value!);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Category'),
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
            Row(
              children: [
                Expanded(
                  child: Text('Date: ${_date.toLocal()}'.split(' ')[0]),
                ),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: const Text('Select date'),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ref.read(transactionProvider.notifier).addTransaction(
                        _title!,
                        _amount!,
                        _category!,
                        _date,
                      );
                  _formKey.currentState!.reset();
                }
              },
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}

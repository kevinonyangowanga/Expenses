import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/transaction/models/categories.dart';
import 'package:myapp/transaction/models/transaction_model.dart';
import 'package:myapp/transaction/notifiers/transaction_notifier.dart';
import 'package:uuid/uuid.dart';

class AddTransactionScreen extends ConsumerWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    final _titleController = TextEditingController();
    final _amountController = TextEditingController();
    final _notesController = TextEditingController();
    FinancialCategory? _selectedCategory;
    DateTime? _selectedDate;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
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
              DropdownButtonFormField<FinancialCategory>(
                value: _selectedCategory,
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
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notes'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  _selectedDate = selectedDate;
                },
                child: const Text('Select Date'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newTransaction = Transaction(
                      id: const Uuid().v4(),
                      title: _titleController.text,
                      amount: double.parse(_amountController.text),
                      date: _selectedDate ?? DateTime.now(),
                      category: _selectedCategory!,
                    );
                    ref.read(transactionProvider.notifier).addTransaction(newTransaction);
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

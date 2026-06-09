import 'package:flutter/material.dart';
import 'package:myapp/models.dart';
import 'package:provider/provider.dart';
import 'package:myapp/financial_provider.dart';

class CategoryDialog extends StatefulWidget {
  final FinancialCategory? category;

  const CategoryDialog({super.key, this.category});

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _name = widget.category?.name ?? '';
    _nameController = TextEditingController(text: _name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final financialProvider =
          Provider.of<FinancialProvider>(context, listen: false);
      if (widget.category == null) {
        // Add new category
        financialProvider.addCategory(FinancialCategory(
          id: DateTime.now().toString(), // Simple unique ID
          name: _name,
        ));
      } else {
        // Update existing category
        final updatedCategory = FinancialCategory(
          id: widget.category!.id,
          name: _name,
        );
        financialProvider.updateCategory(updatedCategory);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.category == null ? 'Add Category' : 'Edit Category'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a name';
            }
            return null;
          },
          onSaved: (value) => _name = value!,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveForm,
          child: const Text('Save'),
        ),
      ],
    );
  }
}

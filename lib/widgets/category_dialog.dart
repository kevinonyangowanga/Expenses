import 'package:flutter/material.dart';

void showAddCategoryDialog(BuildContext context, Function(String) onAdd) {
  final _nameController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Add Category'),
      content: TextField(
        controller: _nameController,
        decoration: const InputDecoration(labelText: 'Category Name'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onAdd(_nameController.text);
            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        ),
      ],
    ),
  );
}

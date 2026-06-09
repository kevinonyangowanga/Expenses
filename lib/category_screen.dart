import 'package:flutter/material.dart';
import 'package:myapp/models.dart';
import 'package:myapp/widgets/category_dialog.dart';
import 'package:provider/provider.dart';
import 'package:myapp/financial_provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const CategoryDialog(),
              );
            },
          ),
        ],
      ),
      body: Consumer<FinancialProvider>(
        builder: (context, financialProvider, child) {
          final categories = financialProvider.categories;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return ListTile(
                leading: const Icon(Icons.category),
                title: Text(category.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => CategoryDialog(category: category),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Optional: Show a confirmation dialog before deleting
                        financialProvider.deleteCategory(category.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/transaction/models/categories.dart';
import 'package:myapp/transaction/models/financial_category.dart';
import 'package:myapp/widgets/category_dialog.dart';

final categoryProvider = StateNotifierProvider<CategoryNotifier, List<FinancialCategory>>((ref) {
  return CategoryNotifier();
});

class CategoryNotifier extends StateNotifier<List<FinancialCategory>> {
  CategoryNotifier() : super(categories);

  void addCategory(String name) {
    final newCategory = FinancialCategory(
      id: (state.length + 1).toString(),
      name: name,
      icon: Icons.category, // Default icon
    );
    state = [...state, newCategory];
  }

  void deleteCategory(String id) {
    state = state.where((category) => category.id != id).toList();
  }
}

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            leading: Icon(category.icon),
            title: Text(category.name),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                ref.read(categoryProvider.notifier).deleteCategory(category.id);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddCategoryDialog(context, (name) {
            ref.read(categoryProvider.notifier).addCategory(name);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

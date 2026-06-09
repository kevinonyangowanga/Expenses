import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/budget/screens/budget_screen.dart';
import 'package:myapp/category_screen.dart';
import 'package:myapp/main.dart';
import 'package:myapp/reports/screens/reports_screen.dart';
import 'package:myapp/transaction/notifiers/transaction_notifier.dart';
import 'package:myapp/transaction/screens/add_transaction_screen.dart';
import 'package:myapp/transaction/screens/edit_transaction_screen.dart';
import 'package:myapp/transaction/widgets/pie_chart_widget.dart';
import 'package:provider/provider.dart' as p;

class FinanceDashboardScreen extends ConsumerStatefulWidget {
  const FinanceDashboardScreen({super.key});

  @override
  ConsumerState<FinanceDashboardScreen> createState() => _FinanceDashboardScreenState();
}

class _FinanceDashboardScreenState extends ConsumerState<FinanceDashboardScreen> {
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    final transactions = ref.watch(transactionProvider);
    final themeProvider = p.Provider.of<ThemeProvider>(context);

    final filteredTransactions = _searchController.text.isEmpty
        ? transactions
        : transactions.where((transaction) =>
            transaction.title.toLowerCase().contains(_searchController.text.toLowerCase())).toList();

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search transactions...',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              )
            : const Text('Finance Dashboard'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                }
              });
            },
          ),
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Toggle Theme',
          ),
          IconButton(
            icon: const Icon(Icons.category),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CategoryScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.assessment),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BudgetScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ReportsScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 250, child: PieChartWidget()),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTransactions.length,
              itemBuilder: (context, index) {
                final transaction = filteredTransactions[index];
                return ListTile(
                  title: Text(transaction.title),
                  subtitle: Text(transaction.category.name),
                  trailing: Text(transaction.amount.toString()),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            EditTransactionScreen(transaction: transaction),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddTransactionScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

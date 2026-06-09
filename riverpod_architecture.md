# Riverpod Architecture for a Personal Finance App

This document outlines a complete Riverpod architecture for a personal finance application. It covers providers, state notifiers, the repository layer, dependency injection, and state management for transactions, budgets, and categories.

## 1. Core Concepts

This architecture is built around the following core concepts of Riverpod:

*   **Providers:** These are the most important part of Riverpod. They are used to store and expose the state of your application.
*   **StateNotifiers:** These are used to manage the state of your application in a more complex way than simple providers. They are ideal for managing state that can change over time, such as a list of transactions.
*   **Repository Pattern:** This pattern is used to abstract the data layer from the rest of the application. This makes the code more modular, testable, and easier to maintain.
*   **Dependency Injection:** Riverpod has built-in support for dependency injection. This is used to provide dependencies (such as repositories) to your state notifiers.

## 2. Repository Layer

The repository layer is responsible for all communication with the data source (e.g., a local database like Hive or a remote database like Firestore).

### Abstract Repositories

First, we define abstract classes for our repositories. This allows us to easily switch between different data sources without changing the rest of the application.

```dart
// lib/repositories/transaction_repository.dart
abstract class TransactionRepository {
  Future<List<Transaction>> getAllTransactions();
  Future<void> addTransaction(Transaction transaction);
  Future<void> updateTransaction(Transaction transaction);
  Future<void> deleteTransaction(String id);
}

// lib/repositories/category_repository.dart
abstract class CategoryRepository {
  Future<List<Category>> getAllCategories();
  Future<void> addCategory(Category category);
}

// lib/repositories/budget_repository.dart
abstract class BudgetRepository {
  Future<List<Budget>> getAllBudgets();
  Future<void> updateBudget(Budget budget);
}
```

### Concrete Repositories (Example with Firestore)

Next, we create concrete implementations of these repositories. This example uses Firestore.

```dart
// lib/repositories/firestore_transaction_repository.dart
class FirestoreTransactionRepository implements TransactionRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Implementations for getAllTransactions, addTransaction, etc.
}
```

## 3. Providers

We use providers to expose our repositories and state notifiers to the UI.

### Repository Providers

These providers expose the repository implementations.

```dart
// lib/providers/repository_providers.dart
final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return FirestoreTransactionRepository();
});

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return FirestoreCategoryRepository();
});

final budgetRepositoryProvider = Provider<BudgetRepository>((ref) {
  return FirestoreBudgetRepository();
});
```

### StateNotifier Providers

These providers expose the state notifiers that manage the application's state.

```dart
// lib/providers/transaction_provider.dart
final transactionProvider = StateNotifierProvider<TransactionNotifier, List<Transaction>>((ref) {
  final transactionRepository = ref.watch(transactionRepositoryProvider);
  return TransactionNotifier(transactionRepository);
});

// lib/providers/category_provider.dart
final categoryProvider = StateNotifierProvider<CategoryNotifier, List<Category>>((ref) {
  final categoryRepository = ref.watch(categoryRepositoryProvider);
  return CategoryNotifier(categoryRepository);
});

// lib/providers/budget_provider.dart
final budgetProvider = StateNotifierProvider<BudgetNotifier, List<Budget>>((ref) {
  final budgetRepository = ref.watch(budgetRepositoryProvider);
  return BudgetNotifier(budgetRepository);
});
```

## 4. StateNotifiers

State notifiers contain the business logic for managing the state of the application.

### `TransactionNotifier`

This notifier manages the state of the transactions.

```dart
// lib/notifiers/transaction_notifier.dart
class TransactionNotifier extends StateNotifier<List<Transaction>> {
  final TransactionRepository _repository;

  TransactionNotifier(this._repository) : super([]) {
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    state = await _repository.getAllTransactions();
  }

  Future<void> addTransaction(Transaction transaction) async {
    await _repository.addTransaction(transaction);
    _loadTransactions();
  }

  // Other methods for updating and deleting transactions
}
```

### `CategoryNotifier` and `BudgetNotifier`

The `CategoryNotifier` and `BudgetNotifier` would follow a similar pattern for managing their respective states.

## 5. Dependency Injection

Riverpod makes dependency injection simple. In the `StateNotifierProvider` definition, we use `ref.watch` to get an instance of the repository and pass it to the state notifier's constructor.

```dart
final transactionProvider = StateNotifierProvider<...>((ref) {
  // Inject the repository into the notifier
  final transactionRepository = ref.watch(transactionRepositoryProvider);
  return TransactionNotifier(transactionRepository);
});
```

## 6. State Management in the UI

Finally, we use the providers in our widgets to listen to state changes and rebuild the UI.

```dart
// lib/screens/transaction_screen.dart
class TransactionScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the provider to get the list of transactions
    final transactions = ref.watch(transactionProvider);

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ListTile(
          title: Text(transaction.title),
          subtitle: Text(transaction.amount.toString()),
        );
      },
    );
  }
}
```

To add a new transaction, you would call the `addTransaction` method on the notifier:

```dart
// Inside a button's onPressed callback
ref.read(transactionProvider.notifier).addTransaction(newTransaction);
```

This architecture provides a robust and scalable foundation for your personal finance app using Riverpod. It promotes a clean separation of concerns, making your code easier to test, maintain, and reason about.

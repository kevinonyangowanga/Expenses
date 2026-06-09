# Hive Database Architecture for Flutter Budgeting App

This document outlines a scalable and maintainable database architecture for a Flutter budgeting application using Hive.

## 1. Introduction

Hive is a lightweight and fast key-value database for Flutter applications. It is a great choice for local data storage because it is easy to use, has a small footprint, and provides excellent performance.

This architecture uses the repository pattern to abstract the data layer from the rest of the application. This makes the code more modular, testable, and easier to maintain.

## 2. Models

The data models are the core of the application. They define the structure of the data that will be stored in the database.

### `Transaction` Model

The `Transaction` model represents a single transaction.

```dart
import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late double amount;

  @HiveField(3)
  late DateTime date;

  @HiveField(4)
  late String categoryId;
}
```

### `Category` Model

The `Category` model represents a spending category.

```dart
import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
class Category extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;
}
```

### `Budget` Model

The `Budget` model represents a budget for a specific category.

```dart
import 'package:hive/hive.dart';

part 'budget.g.dart';

@HiveType(typeId: 2)
class Budget extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String categoryId;

  @HiveField(2)
  late double amount;
}
```

## 3. TypeAdapters

Hive uses `TypeAdapter`s to serialize and deserialize objects. These adapters can be generated automatically using the `hive_generator` package.

To generate the adapters, run the following command in your terminal:

```bash
flutter packages pub run build_runner build
```

This will generate the `*.g.dart` files for your models.

## 4. Repository Pattern

The repository pattern is used to abstract the data layer from the rest of the application. It provides a clean API for accessing and manipulating data, without exposing the implementation details of the database.

### `TransactionRepository`

```dart
abstract class TransactionRepository {
  Future<void> addTransaction(Transaction transaction);
  Future<void> updateTransaction(Transaction transaction);
  Future<void> deleteTransaction(String id);
  Future<List<Transaction>> getAllTransactions();
  Future<List<Transaction>> getTransactionsByCategory(String categoryId);
}
```

### `CategoryRepository`

```dart
abstract class CategoryRepository {
  Future<void> addCategory(Category category);
  Future<void> updateCategory(Category category);
  Future<void> deleteCategory(String id);
  Future<List<Category>> getAllCategories();
}
```

### `BudgetRepository`

```dart
abstract class BudgetRepository {
  Future<void> addBudget(Budget budget);
  Future<void> updateBudget(Budget budget);
  Future<void> deleteBudget(String id);
  Future<List<Budget>> getAllBudgets();
  Future<Budget?> getBudgetByCategory(String categoryId);
}
```

## 5. CRUD Operations

The following are examples of how to implement the CRUD operations for each model.

### `TransactionRepositoryImpl`

```dart
class TransactionRepositoryImpl implements TransactionRepository {
  final Box<Transaction> _transactionBox;

  TransactionRepositoryImpl(this._transactionBox);

  @override
  Future<void> addTransaction(Transaction transaction) async {
    await _transactionBox.put(transaction.id, transaction);
  }

  @override
  Future<void> updateTransaction(Transaction transaction) async {
    await _transactionBox.put(transaction.id, transaction);
  }

  @override
  Future<void> deleteTransaction(String id) async {
    await _transactionBox.delete(id);
  }

  @override
  Future<List<Transaction>> getAllTransactions() async {
    return _transactionBox.values.toList();
  }

  @override
  Future<List<Transaction>> getTransactionsByCategory(String categoryId) async {
    return _transactionBox.values
        .where((transaction) => transaction.categoryId == categoryId)
        .toList();
  }
}
```

## 6. Data Relationships

Hive does not have built-in support for relationships. However, you can manage relationships between objects by storing the `id` of the related object.

For example, the `Transaction` model has a `categoryId` field that stores the `id` of the `Category` to which the transaction belongs.

## 7. Migration Strategy

When you change your data models, you may need to migrate the data in your database. Hive does not have a built-in migration strategy, but you can implement your own.

One approach is to version your models and create a migration script that converts the data from the old version to the new version.

### Example Migration

Let's say you want to add a `notes` field to the `Transaction` model.

**1. Update the `Transaction` model:**

```dart
@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late double amount;

  @HiveField(3)
  late DateTime date;

  @HiveField(4)
  late String categoryId;

  @HiveField(5) // New field
  late String? notes;
}
```

**2. Create a migration script:**

```dart
Future<void> migrateTransactions() async {
  final oldBox = await Hive.openBox('transactions_v1');
  final newBox = await Hive.openBox<Transaction>('transactions_v2');

  for (var oldTransaction in oldBox.values) {
    final newTransaction = Transaction()
      ..id = oldTransaction['id']
      ..title = oldTransaction['title']
      ..amount = oldTransaction['amount']
      ..date = oldTransaction['date']
      ..categoryId = oldTransaction['categoryId']
      ..notes = null; // Set default value for new field

    await newBox.put(newTransaction.id, newTransaction);
  }

  await oldBox.deleteFromDisk();
}
```

This is a basic example of a migration strategy. For more complex migrations, you may need to use a more sophisticated approach.

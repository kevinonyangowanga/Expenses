# Budgeting App Blueprint

## 1. Overview

This document outlines the architectural design and implementation plan for a production-ready Flutter budgeting application. The goal is to create a scalable, maintainable, and high-performance application using modern best practices.

**Core Technologies:**

*   **UI Framework:** Flutter with Material 3
*   **State Management:** Riverpod
*   **Navigation:** GoRouter
*   **Local Storage:** Hive
*   **Architecture:** Clean Architecture (Feature-First)

## 2. Architecture: Clean Architecture

The application will be structured into three main layers:

*   **Presentation:** Contains UI (Screens/Widgets) and state management (Riverpod Providers). This layer depends on the Domain layer.
*   **Domain:** The core business logic, containing Entities (business objects) and Use Cases (interactors). This layer has no dependencies on other layers.
*   **Data:** Responsible for data persistence and retrieval. It implements repositories defined in the Domain layer and uses data sources like Hive or a remote API. This layer depends on the Domain layer.

### **Feature-First Folder Structure**

The project is organized by feature, with each feature having its own `presentation`, `domain`, and `data` subdirectories.

```
lib/
├── src/
│   ├── core/                  # Core utilities, services, and app-wide logic
│   │   ├── api/               # API client configuration (if any)
│   │   ├── error/             # Custom exception and failure classes
│   │   ├── navigation/        # GoRouter configuration
│   │   ├── theme/             # App-wide theme data and providers
│   │   └── usecases/          # Core use cases (e.g., UseCase with parameters)
│   │
│   ├── features/              # Feature modules
│   │   ├── auth/              # Authentication feature
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   │
│   │   ├── budget/            # Budgeting feature
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   │
│   │   ├── dashboard/         # Home/Dashboard screen
│   │   │   └── presentation/
│   │   │
│   │   └── transactions/      # Transactions feature
│   │       ├── data/
│   │       ├── domain/
│   │       └── presentation/
│   │
│   └── shared/                # Shared widgets, constants, and extensions
│       ├── constants/
│       ├── widgets/
│       └── extensions/
│
├── main.dart                  # App entry point
└── app.dart                     # MaterialApp widget
```

## 3. Data Models & Persistence (Hive)

We will use **Hive** for local, on-device data storage. Data models will be created as `HiveObject`s to enable seamless persistence.

**Example Transaction Model:**

```dart
// lib/src/features/transactions/data/models/transaction_model.dart
import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String categoryId;

  TransactionModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.categoryId,
  });
}
```

## 4. State Management (Riverpod)

**Riverpod** will be used for both dependency injection and state management.

*   `Provider`: To provide repository implementations to the domain layer.
*   `FutureProvider`: For handling asynchronous operations like fetching data.
*   `StateNotifierProvider`: To manage the state of UI screens, exposing a `StateNotifier` that holds the UI state.

## 5. Navigation (GoRouter)

**GoRouter** will handle all routing declaratively.

**Router Configuration:**

```dart
// lib/src/core/navigation/app_router.dart
final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/transactions',
      builder: (context, state) => const TransactionsScreen(),
      routes: [
        GoRoute(
          path: ':id', // e.g., /transactions/xyz
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return TransactionDetailScreen(transactionId: id);
          },
        ),
      ]
    ),
    // ... other routes
  ],
  // ... error handling and redirects
);
```

## 6. Theme Architecture (Material 3)

A centralized theme will be created in `lib/src/core/theme`.

*   `theme_provider.dart`: A `ChangeNotifier` to toggle between light and dark modes.
*   `app_theme.dart`: Defines `ThemeData` for both light and dark modes using `ColorScheme.fromSeed` for Material 3 compliance. It will also contain custom text themes and component themes.

## 7. Scalability Recommendations

*   **Modularity:** The feature-first structure allows teams to work on different features in isolation.
*   **Abstraction:** The use of repositories and abstract data sources allows for easy swapping of implementations (e.g., moving from Hive to a cloud backend) without affecting the UI.
*   **Testing:** The separation of concerns makes the app highly testable. Unit tests for the domain layer, widget tests for the presentation layer, and integration tests can be written easily.
*   **Reusable Components:** Building a library of shared widgets in `lib/src/shared/widgets` will speed up development and ensure UI consistency.

## 8. Implementation Plan

1.  **Finalize Folder Structure:** Create all the necessary directories outlined above.
2.  **Setup Core Components:**
    *   Implement GoRouter configuration.
    *   Implement Material 3 Theme and ThemeProvider.
    *   Define base classes for UseCases and Errors.
3.  **Implement Auth Feature:**
    *   Create data models, repositories, and use cases for authentication.
    *   Build the authentication screen.
4.  **Implement Transactions Feature:**
    *   Set up Hive and the Transaction data model.
    *   Implement repositories and use cases for CRUD operations on transactions.
    *   Build the transactions list and detail screens.
5.  **Build Dashboard:**
    *   Create the main dashboard screen that presents an overview of budgets and recent transactions.

This structured approach will ensure a robust and scalable foundation for the budgeting app.

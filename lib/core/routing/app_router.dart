
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:personal_finance_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:personal_finance_app/features/home/presentation/screens/home_screen.dart';
import 'package:personal_finance_app/features/transactions/presentation/screens/transaction_screen.dart';
import 'package:personal_finance_app/features/transactions/presentation/screens/add_transaction_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/transactions',
        builder: (context, state) => const TransactionScreen(),
      ),
      GoRoute(
        path: '/add_transaction',
        builder: (context, state) => const AddTransactionScreen(),
      ),
    ],
  );
}

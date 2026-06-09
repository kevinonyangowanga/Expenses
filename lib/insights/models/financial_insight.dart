import 'package:flutter/material.dart';

enum InsightType {
  spendingPattern,
  budgetRecommendation,
  overspendingWarning,
  savingsSuggestion,
  monthlySummary,
}

class FinancialInsight {
  final String id;
  final InsightType type;
  final String title;
  final String description;
  final DateTime date;
  final IconData icon;
  final Color color;

  FinancialInsight({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.date,
    required this.icon,
    required this.color,
  });
}

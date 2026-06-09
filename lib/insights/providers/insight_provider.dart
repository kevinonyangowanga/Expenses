import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/budget/providers/budget_provider.dart';
import 'package:myapp/insights/models/financial_insight.dart';
import 'package:myapp/insights/services/financial_insight_service.dart';
import 'package:myapp/transaction/providers/transaction_provider.dart';

final financialInsightServiceProvider = Provider<FinancialInsightService>((ref) {
  final transactions = ref.watch(transactionProvider);
  final budgets = ref.watch(budgetProvider);
  return FinancialInsightService(transactions, budgets);
});

final insightProvider =
    StateNotifierProvider<InsightNotifier, List<FinancialInsight>>((ref) {
  final insightService = ref.watch(financialInsightServiceProvider);
  return InsightNotifier(insightService);
});

class InsightNotifier extends StateNotifier<List<FinancialInsight>> {
  final FinancialInsightService _insightService;

  InsightNotifier(this._insightService) : super([]) {
    generateInsights();
  }

  void generateInsights() {
    state = _insightService.generateInsights();
  }
}

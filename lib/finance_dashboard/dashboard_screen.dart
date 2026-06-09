import 'package:flutter/material.dart';
import 'package:myapp/finance_dashboard/widgets/app_bar.dart';
import 'package:myapp/finance_dashboard/widgets/balance_card.dart';
import 'package:myapp/finance_dashboard/widgets/budget_indicator.dart';
import 'package:myapp/finance_dashboard/widgets/recent_transactions.dart';
import 'package:myapp/finance_dashboard/widgets/spending_insights.dart';
import 'package:myapp/finance_dashboard/widgets/summary_cards.dart';

class FinanceDashboardScreen extends StatelessWidget {
  const FinanceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: FinanceAppBar(),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Tablet layout
            return const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          BalanceCard(),
                          SizedBox(height: 16),
                          SummaryCards(),
                          SizedBox(height: 16),
                          BudgetIndicator(),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          SpendingInsights(),
                          SizedBox(height: 16),
                          RecentTransactions(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // Mobile layout
            return const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BalanceCard(),
                    SizedBox(height: 16),
                    SummaryCards(),
                    SizedBox(height: 16),
                    BudgetIndicator(),
                    SizedBox(height: 16),
                    SpendingInsights(),
                    SizedBox(height: 16),
                    RecentTransactions(),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

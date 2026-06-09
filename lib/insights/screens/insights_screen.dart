import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/insights/providers/insight_provider.dart';
import 'package:myapp/insights/widgets/insight_card.dart';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insights = ref.watch(insightProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Insights'),
      ),
      body: ListView.builder(
        itemCount: insights.length,
        itemBuilder: (context, index) {
          final insight = insights[index];
          return InsightCard(insight: insight);
        },
      ),
    );
  }
}

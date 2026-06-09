import 'package:flutter/material.dart';

class BudgetIndicator extends StatelessWidget {
  const BudgetIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Monthly Budget'),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$1,500 / \$2,000'),
                Text('75%'),
              ],
            ),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.75,
              minHeight: 10,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ],
        ),
      ),
    );
  }
}

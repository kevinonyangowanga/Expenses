import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinancialGoalsScreen extends StatefulWidget {
  const FinancialGoalsScreen({super.key});

  @override
  _FinancialGoalsScreenState createState() => _FinancialGoalsScreenState();
}

class _FinancialGoalsScreenState extends State<FinancialGoalsScreen> {
  final List<FinancialGoal> _goals = [
    FinancialGoal(name: 'Buy a House', targetAmount: 100000, currentAmount: 25000),
    FinancialGoal(name: 'Save for Retirement', targetAmount: 500000, currentAmount: 150000),
    FinancialGoal(name: 'Vacation to Europe', targetAmount: 10000, currentAmount: 8000),
  ];

  void _addGoal() {
    // TODO: Implement add goal functionality
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Financial Goals', style: GoogleFonts.oswald(fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _goals.length,
        itemBuilder: (context, index) {
          final goal = _goals[index];
          return Card(
            elevation: 4.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(goal.name, style: GoogleFonts.roboto(fontSize: 18.0, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8.0),
                  Text('Target: \$${goal.targetAmount.toStringAsFixed(2)}', style: GoogleFonts.openSans()),
                  Text('Saved: \$${goal.currentAmount.toStringAsFixed(2)}', style: GoogleFonts.openSans()),
                  const SizedBox(height: 8.0),
                  LinearProgressIndicator(
                    value: goal.currentAmount / goal.targetAmount,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addGoal,
        child: const Icon(Icons.add),
        tooltip: 'Add Goal',
      ),
    );
  }
}

class FinancialGoal {
  final String name;
  final double targetAmount;
  final double currentAmount;

  FinancialGoal({required this.name, required this.targetAmount, required this.currentAmount});
}

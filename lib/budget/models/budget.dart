import 'package:hive/hive.dart';

part 'budget.g.dart';

@HiveType(typeId: 0)
class Budget extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String category;

  @HiveField(2)
  final double amount;

  Budget({
    required this.id,
    required this.category,
    required this.amount,
  });
}

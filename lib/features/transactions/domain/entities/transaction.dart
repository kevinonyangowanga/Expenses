
import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final String description;

  Transaction({
    required this.id,
    required this.amount,
    required this.date,
    required this.category,
    required this.description,
  });
}

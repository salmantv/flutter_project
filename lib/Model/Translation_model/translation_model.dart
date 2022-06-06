import 'package:hive/hive.dart';

import '../Categroy_Model/catagroy_model.dart';
part 'translation_model.g.dart';

@HiveType(typeId: 3)
class TranclationModel {
  @HiveField(1)
  late final double amount;
  @HiveField(2)
  final categorytype categorytyp;
  @HiveField(3)
  final DateTime datetime;
  @HiveField(4)
  final String not;
  @HiveField(5)
  final CategoryModel catagry;
  @HiveField(6)
  final String id;

  TranclationModel({
    required this.catagry,
    required this.amount,
    required this.categorytyp,
    required this.datetime,
    required this.not,
    required this.id,
  });
}

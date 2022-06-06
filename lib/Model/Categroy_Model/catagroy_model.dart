// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:hive/hive.dart';
part 'catagroy_model.g.dart';

@HiveType(typeId: 2)
enum categorytype {
  @HiveField(0)
  income,
  @HiveField(1)
  expanse,
}

@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isdeleted;
  @HiveField(3)
  final categorytype;

  CategoryModel(this.id,
      {required this.name, this.isdeleted = false, required this.categorytype});
}

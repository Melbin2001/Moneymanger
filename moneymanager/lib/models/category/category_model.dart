import 'package:hive_flutter/adapters.dart';
part 'category_model.g.dart';
@HiveType(typeId: 2)
enum categorytype {
  @HiveField(0)
  income,

  @HiveField(1)
  expense,
}



@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final bool isDeleted;

  @HiveField(3)
  final categorytype type;

  CategoryModel({
    required this.id,
    required this.name,
    required this.type,
    this.isDeleted = false,
  });
}

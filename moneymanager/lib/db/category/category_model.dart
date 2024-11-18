import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanager/models/category/category_model.dart';

const _category_dbname = 'category database';

abstract class CategoryDBfunctions {
  Future<List<CategoryModel>> getcategories();
  Future<void> insertcategory(CategoryModel value);
  Future<void> deletecategory(String categoryID);
}

class Categorydb implements CategoryDBfunctions {
  Categorydb._internal();
  static Categorydb instance = Categorydb._internal();
  factory Categorydb() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> Incomecategorylist = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> Expensecategorylist = ValueNotifier([]);
  @override
  Future<void> insertcategory(CategoryModel value) async {
    final Categorydatabase =
        await Hive.openBox<CategoryModel>(_category_dbname);
    await Categorydatabase.put(value.id, value);
    refreshui();
  }

  @override
  Future<List<CategoryModel>> getcategories() async {
    final Categorydatabase =
        await Hive.openBox<CategoryModel>(_category_dbname);
    return Categorydatabase.values.toList();
  }

  Future<void> refreshui() async {
    final allcategories = await getcategories();
    Incomecategorylist.value.clear();
    Expensecategorylist.value.clear();
    await Future.forEach(allcategories, (CategoryModel category) {
      if (category.type == categorytype.income) {
        Incomecategorylist.value.add(category);
      } else {
        Expensecategorylist.value.add(category);
      }
    });
    Incomecategorylist.notifyListeners();
    Expensecategorylist.notifyListeners();
  }

  @override
  Future<void> deletecategory(String categoryID) async {
    final categoryDb = await Hive.openBox<CategoryModel>(_category_dbname);
    await categoryDb.delete(categoryID);
    refreshui();
  }
}

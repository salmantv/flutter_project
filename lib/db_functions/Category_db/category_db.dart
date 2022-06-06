// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Model/Categroy_Model/catagroy_model.dart';

// ignore: constant_identifier_names
const CATEGORY_DB_NAME = 'category_database';

abstract class Categorydbfunctions {
  Future<List<CategoryModel>> getcategory();
  Future<void> insertcatgory(CategoryModel value);
  Future<void> deletecategory(String deletaId);
}

class Categoeydb implements Categorydbfunctions {
  Categoeydb._intrenal();

  static Categoeydb instense = Categoeydb._intrenal();

  factory Categoeydb(double totelincome) {
    return instense;
  }

  // ignore: non_constant_identifier_names
  ValueNotifier<List<CategoryModel>> IncomeCategory = ValueNotifier([]);
  // ignore: non_constant_identifier_names
  ValueNotifier<List<CategoryModel>> ExpanseCategory = ValueNotifier([]);

  @override
  Future<void> insertcatgory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    _categoryDB.put(value.id, value);
    RefershUi();
  }

  @override
  Future<List<CategoryModel>> getcategory() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  // ignore: non_constant_identifier_names
  Future<void> RefershUi() async {
    IncomeCategory.value.clear();
    ExpanseCategory.value.clear();
    final allcategory = await getcategory();
    Future.forEach(allcategory, (CategoryModel category) {
      if (category.categorytype == categorytype.income) {
        IncomeCategory.value.add(category);
      } else {
        ExpanseCategory.value.add(category);
      }
      IncomeCategory.notifyListeners();
      ExpanseCategory.notifyListeners();
    });
  }

  @override
  Future<void> deletecategory(String deletaId) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    _categoryDB.delete(deletaId);
    RefershUi();
  }

  Future<void> deletealldatafromedatabase() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    _categoryDB.clear();
  }
}

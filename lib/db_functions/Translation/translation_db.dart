// ignore_for_file: non_constant_identifier_names, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, override_on_non_overriding_member

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import '../../Model/Translation_model/translation_model.dart';
import '../../../Model/Categroy_Model/catagroy_model.dart';

// ignore: camel_case_types
abstract class Transactiom_db {
  Future<void> addtransltion(TranclationModel value);
  Future<List<TranclationModel>> gettranction();
  Future<void> deleteingTrastions(TranclationModel Id);
}

class Tracnsltion implements Transactiom_db {
  Tracnsltion._instens();

  ValueNotifier<List<TranclationModel>> transltionsnotfier = ValueNotifier([]);
  ValueNotifier<List<TranclationModel>> monthnotfier = ValueNotifier([]);
  ValueNotifier<List<TranclationModel>> todaynotfier = ValueNotifier([]);
  ValueNotifier<List<TranclationModel>> yesterdaynotfier = ValueNotifier([]);
  ValueNotifier<List<TranclationModel>> incomenotfiere = ValueNotifier([]);
  ValueNotifier<List<TranclationModel>> expansenotfiere = ValueNotifier([]);
  ValueNotifier<List<TranclationModel>> Testingnotfiere = ValueNotifier([]);

  static Tracnsltion instense = Tracnsltion._instens();
  factory Tracnsltion() {
    return instense;
  }

  Future refrsh() async {
    todaynotfier.value.clear();
    yesterdaynotfier.value.clear();
    final _alllist = await gettranction();

    Future.forEach(_alllist, (TranclationModel element) {
      if (element.datetime.day == DateTime.now().day) {
        Tracnsltion.instense.todaynotfier.value.add(element);
      } else if (element.datetime.day == DateTime.now().day - 1 &&
          element.datetime.month == DateTime.now().month) {
        yesterdaynotfier.value.add(element);
      } else if (element.categorytyp == categorytype.income) {}
    });

    incomenotfiere.value.clear();
    expansenotfiere.value.clear();
    Future.forEach(_alllist, (TranclationModel element) {
      if (element.categorytyp == categorytype.income) {
        incomenotfiere.value.add(element);
      } else {
        expansenotfiere.value.add(element);
      }
    });

    Testingnotfiere.value.toSet().toList().clear();
    Future.forEach(_alllist, (TranclationModel element) {});

    transltionsnotfier.value.clear();
    transltionsnotfier.value.addAll(_alllist);
    transltionsnotfier.notifyListeners();
    todaynotfier.notifyListeners();
    yesterdaynotfier.notifyListeners();
    incomenotfiere.notifyListeners();
    expansenotfiere.notifyListeners();
    Testingnotfiere.notifyListeners();
  }

  @override
  Future<void> addtransltion(TranclationModel value) async {
    final _db = await Hive.openBox<TranclationModel>("transltion_db_open");
    _db.put(value.id, value);
    refrsh();
  }

  @override
  Future<List<TranclationModel>> gettranction() async {
    final _db = await Hive.openBox<TranclationModel>("transltion_db_open");
    return _db.values.toSet().toList();
  }

  @override
  Future<void> deleteingTrastions(TranclationModel Id) async {
    final _db = await Hive.openBox<TranclationModel>("transltion_db_open");
    _db.delete(Id.id);
    refrsh();
  }

  @override
  Future<void> upadating(TranclationModel data) async {
    final _db = await Hive.openBox<TranclationModel>("transltion_db_open");
    _db.put(data.id, data);
    refrsh();
  }

  Future<void> Claredata() async {
    final _db = await Hive.openBox<TranclationModel>("transltion_db_open");
    _db.clear();
  }
}

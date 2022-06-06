// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';

import '../../Model/Categroy_Model/catagroy_model.dart';

import '../../Model/Translation_model/translation_model.dart';
import '../../db_functions/Translation/translation_db.dart';

categorytype? nowcategory;
CategoryModel? selectedcategory;
var categoryshow = TextEditingController();
late double toteltracstion;
late double totelincome;
late double totelexpanse;
DateTime selectedmonth = DateTime.now();
DateTime? selectday;
String dropselectedvalus = "2";
String chartdrop = 'transltionsnotfier';

var dateTimenow = DateTime.now().month.toString();
var dateTimeyear = DateTime.now().year.toString();
math(value) {
  toteltracstion = 0;
  totelincome = 0;
  totelexpanse = 0;

  Tracnsltion.instense.transltionsnotfier.value.forEach((element) {
    if (element.categorytyp == categorytype.income &&
        element.datetime.month == DateTime.now().month) {
      totelincome += element.amount;
    }
    if (element.categorytyp == categorytype.expanse &&
        element.datetime.month == DateTime.now().month) {
      totelexpanse += element.amount;
    }
  });
  toteltracstion = totelincome - totelexpanse;
}

class Chartdata {
  String? categories;
  double? amount;
  Chartdata({required this.categories, required this.amount});
}

List<Chartdata> chartlogic(List<TranclationModel> model) {
  double value;
  String catagoryname;
  List visted = [];
  List<Chartdata> thedata = [];

  for (var i = 0; i < model.length; i++) {
    visted.add(0);
  }

  for (var i = 0; i < model.length; i++) {
    value = model[i].amount;
    catagoryname = model[i].catagry.name;

    for (var j = i + 1; j < model.length; j++) {
      if (model[i].catagry.name == model[j].catagry.name) {
        value += model[j].amount;
        visted[j] = -1;
      }
    }

    if (visted[i] != -1) {
      thedata.add(Chartdata(categories: catagoryname, amount: value));
    }
  }

  return thedata;
}

final monthnames = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];
DateTime pressedtime = DateTime.now();

// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:sizer/sizer.dart';
import '../../Model/Translation_model/translation_model.dart';
import '../../db_functions/Translation/translation_db.dart';
import '../../icons/myicons.dart';
import '../Globlefunctions/globle.dart';
import 'fulltransaction.dart';

class Alltranslation extends StatefulWidget {
  const Alltranslation({Key? key}) : super(key: key);

  @override
  State<Alltranslation> createState() => _AlltranslationState();
}

class _AlltranslationState extends State<Alltranslation> {
  @override
  Widget build(BuildContext context) {
    Tracnsltion.instense.refrsh();
    return Scaffold(
        backgroundColor: const Color(0xffe0e0e0),
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          elevation: 10,
          backgroundColor: const Color(0xffe0e0e0),
          toolbarHeight: 10.h,
        ),
        body: SafeArea(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Visibility(
                      visible: dropselectedvalus == '4' ? true : false,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: IconButton(
                            onPressed: () {
                              onPressed(context: context);
                            },
                            icon: const Icon(MyFlutterApp.calendar)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 60),
                      child: SizedBox(
                        height: 7.h,
                        width: 33.w,
                        child: Card(
                          color: const Color.fromARGB(255, 4, 196, 196),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                          child: DropdownButton(
                            underline: const Text(""),
                            value: dropselectedvalus,
                            focusColor: Colors.black,
                            items: const [
                              DropdownMenuItem(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    "All",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                value: "1",
                              ),
                              DropdownMenuItem(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Today",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                value: "2",
                              ),
                              DropdownMenuItem(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Yesterday",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                value: "3",
                              ),
                              DropdownMenuItem(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    " Monthly",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                value: "4",
                              ),
                              DropdownMenuItem(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    " income",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                value: "5",
                              ),
                              DropdownMenuItem(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    " Expanse",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                value: "6",
                              ),
                            ],
                            onChanged: (newvalue) {
                              setState(() {
                                dropselectedvalus = newvalue.toString();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Datesbuliding(),
            ],
          ),
        ));
  }

  Future askingDeleting(contescx, TranclationModel value) async {
    showDialog(
        context: contescx,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Category Deleting"),
            content: SizedBox(
              height: 12.h,
              child: Column(
                children: [
                  const Text(
                    "Are you sure you want to delete the record ?",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("Cencel")),
              TextButton(
                  onPressed: () {
                    Tracnsltion.instense.deleteingTrastions(value);
                    Navigator.of(ctx).pop();

                    setState(() {});
                  },
                  child: const Text("ok"))
            ],
          );
        });
  }

  Future<void> onPressed({
    required BuildContext context,
    String? locale,
  }) async {
    final localeObj = locale != null ? Locale(locale) : null;
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: selectedmonth,
      firstDate: DateTime(2017),
      lastDate: DateTime(2023),
      locale: localeObj,
    );

    if (selected != null) {
      setState(() {
        selectedmonth = selected;
      });
    }

    Tracnsltion.instense.monthnotfier.value.clear();
    Future.forEach(Tracnsltion.instense.transltionsnotfier.value,
        (TranclationModel element) {
      if (element.datetime.month == selectedmonth.month &&
          element.datetime.year == selectedmonth.year) {
        Tracnsltion.instense.monthnotfier.value.add(element);
      }

      Tracnsltion.instense.monthnotfier.notifyListeners();
    });
  }
}

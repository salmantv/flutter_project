// ignore: file_names

import 'package:flutter/material.dart';
import 'package:moneymanger/Screens/Category/widgets/expanse_category.dart';
import 'package:moneymanger/Screens/Category/widgets/income_category.dart';
import 'package:sizer/sizer.dart';

import '../../db_functions/Category_db/category_db.dart';
import '../../icons/moneyicons.dart';
import '../Globlefunctions/globle.dart';

// ignore: camel_case_types
class Category_Page extends StatefulWidget {
  const Category_Page({Key? key}) : super(key: key);
  @override
  State<Category_Page> createState() => _Category_PageState();
}

// ignore: camel_case_types
class _Category_PageState extends State<Category_Page> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final deffent = DateTime.now().difference(pressedtime);
        final isExieit = deffent >= const Duration(seconds: 2);
        pressedtime = DateTime.now();

        if (isExieit) {
          backexitsnackbar();
          return false;
        } else {
          return true;
        }
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white10,
              elevation: 00,
              toolbarHeight: 8.h,
              bottom: TabBar(
                  labelColor: const Color(0xff0097a7),
                  unselectedLabelColor: Colors.black45,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Color(0x14000000),
                  ),
                  tabs: [
                    Tab(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(Money.finance),
                        Text("Income"),
                      ],
                    )),
                    Tab(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Money.business_loss_downfall,
                        ),
                        Text("Expanse"),
                      ],
                    )),
                  ])),
          body: TabBarView(children: [
            Center(
                child: ValueListenableBuilder(
              builder: (BuildContext context, value, Widget? child) {
                return const Incomecategoy();
              },
              valueListenable: Categoeydb.instense.IncomeCategory,
            )),
            Center(
                child: ValueListenableBuilder(
              builder: (BuildContext context, value, Widget? child) {
                return const ExpanseCategory();
              },
              valueListenable: Categoeydb.instense.ExpanseCategory,
            )),
          ]),
        ),
      ),
    );
  }

  backexitsnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromARGB(255, 66, 66, 66),
        content: Text(" Press back again to exite ")));
  }
}

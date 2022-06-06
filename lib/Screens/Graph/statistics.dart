import 'package:flutter/material.dart';
import 'package:moneymanger/Screens/Graph/widgets/statistics_Income.dart';
import 'package:moneymanger/Screens/Graph/widgets/statistics_total.dart';
import 'package:sizer/sizer.dart';
import '../../db_functions/Translation/translation_db.dart';
import '../../icons/moneyicons.dart';
import '../Globlefunctions/globle.dart';
import 'widgets/statistics_expanse.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: WillPopScope(
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
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
              elevation: 0.0,
              backgroundColor: const Color(0xffe0e0e0),
              toolbarHeight: 5.h,
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
                        Icon(
                          Icons.format_align_left,
                          size: 20,
                        ),
                        Text(
                          "Overviwe",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                      ],
                    )),
                    Tab(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Money.business_loss_downfall,
                          size: 20,
                        ),
                        Text("income"),
                      ],
                    )),
                    Tab(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Money.finance,
                          size: 20,
                        ),
                        Text("Expanse"),
                      ],
                    )),
                  ])),
          body: TabBarView(children: [
            Center(
              child: ValueListenableBuilder(
                builder: (BuildContext context, value, Widget? child) {
                  math(value);
                  return const Overreview();
                },
                valueListenable: Tracnsltion.instense.transltionsnotfier,
              ),
            ),
            Center(
                child: ValueListenableBuilder(
              builder: (BuildContext context, value, Widget? child) {
                math(value);

                return const Chartincome();
              },
              valueListenable: Tracnsltion.instense.transltionsnotfier,
            )),
            Center(
                child: ValueListenableBuilder(
              builder: (BuildContext context, value, Widget? child) {
                math(value);

                return const Expansewidget();
              },
              valueListenable: Tracnsltion.instense.transltionsnotfier,
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

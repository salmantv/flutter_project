// ignore_for_file: unused_field, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../Model/Translation_model/translation_model.dart';
import '../../../db_functions/Translation/translation_db.dart';
import '../../../icons/myicons.dart';
import '../../Globlefunctions/globle.dart';

class Overreview extends StatefulWidget {
  const Overreview({Key? key}) : super(key: key);

  @override
  State<Overreview> createState() => _OverreviewState();
}

class _OverreviewState extends State<Overreview> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Chartdata> all =
        chartlogic(Tracnsltion.instense.transltionsnotfier.value);
    List<Chartdata> today = chartlogic(Tracnsltion.instense.todaynotfier.value);
    List<Chartdata> yesterday =
        chartlogic(Tracnsltion.instense.yesterdaynotfier.value);
    List<Chartdata> monthly =
        chartlogic(Tracnsltion.instense.monthnotfier.value);

    return Scaffold(
      backgroundColor: const Color(0xffe0e0e0),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Row(
              children: [
                Visibility(
                  visible: chartdrop == 'monthnotfier' ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 60),
                    child: IconButton(
                        onPressed: () {
                          onPressed(context: context);
                        },
                        icon: const Icon(MyFlutterApp.calendar)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 60,
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(right: 70, top: 20),
                    width: 30.w,
                    height: 7.h, //It will take a 20% of screen width
                    child: Card(
                      color: const Color.fromARGB(255, 4, 196, 196),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                      child: DropdownButton(
                        underline: const Text(""),
                        value: chartdrop,
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
                            value: "transltionsnotfier",
                          ),
                          DropdownMenuItem(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "Today",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            value: "todaynotfier",
                          ),
                          DropdownMenuItem(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "Yesterday",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            value: "yesterdaynotfier",
                          ),
                          DropdownMenuItem(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                " Monthly",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            value: "monthnotfier",
                          ),
                        ],
                        onChanged: (newvalue) {
                          setState(() {
                            chartdrop = newvalue.toString();
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1.8.h,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 0,
                  right: 0,
                  bottom: 0,
                ),
                child: Column(children: [
                  SizedBox(
                    height: 58.6.h,
                    child: all.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "No transaction now trying to add",
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 16),
                              ),
                              Image.asset(
                                'assets/chart_data_.png',
                                height: 35.h,
                              ),
                            ],
                          )
                        : SfCircularChart(
                            legend: Legend(
                              isVisible: true,
                            ),
                            title: ChartTitle(text: 'Totel transactions'),
                            series: <DoughnutSeries>[
                                // Render pie chart
                                DoughnutSeries<Chartdata, String>(
                                    dataLabelSettings: const DataLabelSettings(
                                      isVisible: true,
                                      labelIntersectAction:
                                          LabelIntersectAction.shift,
                                    ),
                                    dataSource: chartdrop ==
                                            'transltionsnotfier'
                                        ? all
                                        : chartdrop == 'todaynotfier'
                                            ? today
                                            : chartdrop == 'yesterdaynotfier'
                                                ? yesterday
                                                : chartdrop == 'monthnotfier'
                                                    ? monthly
                                                    : all,
                                    xValueMapper: (Chartdata data, _) =>
                                        data.categories,
                                    yValueMapper: (Chartdata data, _) =>
                                        data.amount,
                                    explode: true,
                                    explodeIndex: 1),
                              ]),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
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

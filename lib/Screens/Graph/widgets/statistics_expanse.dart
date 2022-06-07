import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../db_functions/Translation/translation_db.dart';
import '../../Globlefunctions/globle.dart';
import '../../home/widget/totelBalanse.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Expansewidget extends StatefulWidget {
  const Expansewidget({Key? key}) : super(key: key);

  @override
  State<Expansewidget> createState() => _ExpansewidgetState();
}

class _ExpansewidgetState extends State<Expansewidget> {
  // ignore: unused_field
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      canShowMarker: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Chartdata> connectedList =
        chartlogic(Tracnsltion.instense.expansenotfiere.value);

    return Scaffold(
        body: Container(
      color: const Color(0xffe0e0e0),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 0,
        ),
        child: ListView(
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            SizedBox(
                height: 37.5.h,
                child: connectedList.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "No transaction now trying to add",
                            style:
                                TextStyle(color: Colors.black45, fontSize: 16),
                          ),
                          Image.asset(
                            'assets/chart_data_.png',
                            height: 25.h,
                          ),
                        ],
                      )
                    : connectedList.length < 2
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "Minimum two expanse transaction",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 16),
                              ),
                              Image.asset(
                                'assets/chart_data_.png',
                                height: 25.h,
                              ),
                            ],
                          )
                        : SfCartesianChart(
                            title: ChartTitle(
                              text: 'Expanse Category analysis',
                              textStyle: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            primaryXAxis: CategoryAxis(),
                            primaryYAxis: NumericAxis(isVisible: false),
                            series: <ChartSeries<Chartdata, String>>[
                                // Renders column chart
                                ColumnSeries<Chartdata, String>(
                                    dataSource: connectedList,
                                    xValueMapper: (Chartdata data, _) =>
                                        data.categories,
                                    yValueMapper: (Chartdata data, _) =>
                                        data.amount,
                                    pointColorMapper: (Chartdata data, _) =>
                                        const Color.fromARGB(255, 161, 45, 12),
                                    dataLabelSettings: const DataLabelSettings(
                                        isVisible: true))
                              ])),
            Total(
              amount: totelexpanse,
              heding: 'Totel Expanse',
              monthe: 'Stop solving problems with new products.',
            ),
          ],
        ),
      )),
    ));
  }
}

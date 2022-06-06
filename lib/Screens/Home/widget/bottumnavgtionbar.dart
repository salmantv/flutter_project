import 'package:flutter/material.dart';

import '../../../db_functions/Category_db/category_db.dart';
import '../../../db_functions/Translation/translation_db.dart';
import '../../../icons/myicons.dart';

// ignore: must_be_immutable
class DownnavigationBar extends StatefulWidget {
  const DownnavigationBar({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedvalu = ValueNotifier(0);

  @override
  State<DownnavigationBar> createState() => _DownnavigationBarState();
}

class _DownnavigationBarState extends State<DownnavigationBar> {
  int? currentindex;

  @override
  void initState() {
    Categoeydb.instense.RefershUi();
    Tracnsltion.instense.refrsh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (BuildContext context, int updatedvalue, _) {
        return SizedBox(
          height: 70,
          child: BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed, // This is all you need!
              currentIndex: updatedvalue,
              fixedColor: Colors.black,
              onTap: (index) {
                DownnavigationBar.selectedvalu.value = index;
              },
              items: const [
                BottomNavigationBarItem(
                    activeIcon: Icon(
                      MyFlutterApp.home,
                      size: 28,
                    ),
                    icon: Icon(MyFlutterApp.home),
                    label: "",
                    backgroundColor: Color.fromARGB(255, 255, 255, 255)),
                BottomNavigationBarItem(
                    activeIcon: Icon(
                      MyFlutterApp.pie_chart,
                      size: 28,
                    ),
                    icon: Icon(MyFlutterApp.pie_chart),
                    label: "",
                    backgroundColor: Color.fromARGB(255, 255, 255, 255)),
                BottomNavigationBarItem(
                    activeIcon: Icon(
                      MyFlutterApp.chart_bars,
                      size: 28,
                    ),
                    icon: Icon(
                      MyFlutterApp.chart_bars,
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    activeIcon: Icon(
                      MyFlutterApp.cog_1,
                      size: 28,
                    ),
                    icon: Icon(
                      MyFlutterApp.cog_1,
                    ),
                    label: ""),
              ]),
        );
      },
      valueListenable: DownnavigationBar.selectedvalu,
    );
  }
}

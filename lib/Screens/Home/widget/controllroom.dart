import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../AddingPage/main_adding_page.dart';
import '../../Category/category_mainpage.dart';
import '../../Globlefunctions/globle.dart';
import '../../Graph/statistics.dart';
import '../../Settings/settings.dart';
import '../home.dart';
import 'bottumnavgtionbar.dart';

class Controll extends StatefulWidget {
  const Controll({Key? key}) : super(key: key);

  @override
  State<Controll> createState() => _ControllState();
}

class _ControllState extends State<Controll> {
  final pages = [
    const Home(),
    const Category_Page(),
    const Statistics(),
    const Settings(),
  ];

  DateTime pressedtime = DateTime.now();

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
      child: Scaffold(
        drawerEnableOpenDragGesture: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () async {
              selectedcategory = null;
              categoryshow.text = '';
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(seconds: 1),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      animation = CurvedAnimation(
                          parent: animation,
                          curve: Curves.fastLinearToSlowEaseIn);
                      return ScaleTransition(
                          alignment: Alignment.center,
                          child: child,
                          scale: animation);
                    },
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return const Adding();
                    },
                  ));
            }),
        bottomNavigationBar: const DownnavigationBar(),
        body: ValueListenableBuilder(
          builder: (BuildContext context, int updatedvalue, _) {
            return pages[updatedvalue];
          },
          valueListenable: DownnavigationBar.selectedvalu,
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

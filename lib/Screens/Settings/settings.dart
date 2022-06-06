import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moneymanger/Screens/Settings/widgets/listTiile.dart';
import 'package:moneymanger/Screens/Settings/widgets/notication.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../db_functions/Category_db/category_db.dart';
import '../../db_functions/Translation/translation_db.dart';
import '../../icons/myicons.dart';
import '../Globlefunctions/globle.dart';
import '../Home/widget/controllroom.dart';
import '../Splshscreen/splash.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
    NotificationApi().init(initScheduled: true);
    listenNotifications();
  }

  void listenNotifications() {
    NotificationApi.onNotifications.listen(onClickNotifications);
  }

  onClickNotifications(String? payload) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const Controll(),
    ));
    return null;
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
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Center(
              child: ListView(
            children: [
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                height: 7.h,
                child: const Center(
                  child: Text(
                    "Settings",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontFamily: "HKGrotesk"),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  timePicking(context: context);
                },
                child: MylistTile(
                  icon: MyFlutterApp.alarm,
                  name: 'Notification',
                ),
              ),
              MylistTile(
                icon: MyFlutterApp.link,
                name: 'Share the app',
              ),
              GestureDetector(
                onTap: () async {
                  if (!await launch(
                      'mailto: salmanthaniveappil@gmail.com?subject= &body= Write Your feeback Suggesions etc ............. '
                      '')) {
                    throw 'Could not launch ';
                  }
                },
                child: MylistTile(
                  icon: MyFlutterApp.user_1,
                  name: 'Contect me',
                ),
              ),
              InkWell(
                onTap: () {
                  restalldata(
                    context,
                    "Rest Data",
                  );
                },
                child: MylistTile(
                  icon: MyFlutterApp.undo,
                  name: 'Reset',
                ),
              ),
              GestureDetector(
                onTap: () async {
                  // ignore: deprecated_member_use
                  if (!await launch(
                      'https://salmantv.github.io/Salman.com/#')) {
                    throw 'Could not launch ';
                  }
                },
                child: MylistTile(
                  icon: MyFlutterApp.envelope,
                  name: 'About me',
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  timePicking({required context}) async {
    final TimeOfDay? pickedTIme = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTIme != null && pickedTIme != TimeOfDay.now()) {
      setState(() {
        NotificationApi.showScheduledNotifications(
            title: "Levy",
            body:
                "⏳ Hi I thing We miss to add new transaction  🕥 And click the notfiaction and add   📅  ",
            scheduledTime: Time(pickedTIme.hour, pickedTIme.minute, 0));
      });
    }
  }

  backexitsnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromARGB(255, 66, 66, 66),
        content: Text(" Press back again to exite ")));
  }

  Future<void> restalldata(
    BuildContext context,
    String titel,
  ) async {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: SizedBox(
              height: 20.h,
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  const Text("All of this applications data will be deleted "
                      "Permanently . This includes all files ,settings , transaction , also data base.")
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () async {
                    await restingapp();
                    setState(() {});
                    await Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) {
                      return SecondScreen();
                    }), (route) => false);
                  },
                  child: const Text("Accept"))
            ],
          );
        });
  }

  restingapp() {
    Tracnsltion.instense.Claredata();
    Categoeydb.instense.deletealldatafromedatabase();
  }
}

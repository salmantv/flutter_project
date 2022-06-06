import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:sizer/sizer.dart';
import 'Model/Categroy_Model/catagroy_model.dart';
import 'Model/Translation_model/translation_model.dart';
import 'Screens/Splshscreen/splash.dart';
import 'db_functions/Translation/translation_db.dart';
import 'package:timezone/data/latest_all.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(categorytypeAdapter().typeId)) {
    Hive.registerAdapter(categorytypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TranclationModelAdapter().typeId)) {
    Hive.registerAdapter(TranclationModelAdapter());
  }

  await Tracnsltion.instense.gettranction();
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              MonthYearPickerLocalizations.delegate,
            ],
            theme: ThemeData(
              backgroundColor: const Color(0xff0097a7),
            ),
            home: SecondScreen());
      },
    );
  }
}

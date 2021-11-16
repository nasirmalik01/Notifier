import 'package:battery/battery.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:notifier_app/codegen_loader.g.dart';
import 'package:notifier_app/consts/colors.dart';
import 'package:notifier_app/consts/strings.dart';
import 'package:notifier_app/presentation/home_screen.dart';
import 'package:notifier_app/size_config.dart';
import 'package:notifier_app/view_model/method.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

int val = 0;
final battery = Battery();
final method = Method();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await MobileAds.instance.initialize();
  // await Firebase.initializeApp();
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: false // This should be false
  );
  Workmanager().registerPeriodicTask(
      TAG,
      "simplePeriodicTask",
      frequency: const Duration(minutes: 15)
  );
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('zh'),
        Locale('es'),
      ],
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      path: 'assets/translation',
      child: const MyApp()));
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print(TAG + " callbackDispatcher");
    // WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp();
    final batteryLevel = await battery.batteryLevel;
    // method.storeBatteryLevelToDb(batteryLevel: batteryLevel);
    // int batteryPercentage = await method.getBatteryLevel();
    // int batteryPercentage2 = await method.getBatteryLevel();

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt('battery_per', batteryLevel);
    int? batteryPercentage = _prefs.getInt('battery_per');

    print("BATTERY: $batteryPercentage");
    if(_prefs.getString('device_id') != null){
      String? _deviceId = _prefs.getString('device_id');
      if(_deviceId != ''){
        if(batteryPercentage! < 2){
          await method.playSoundLessThan2();
          method.showNotification(text: 'Charge Your Phone! Your phone battery is $batteryPercentage%');
        }
        else if(batteryPercentage < 4){
          await method.playSoundLessThan4();
          method.showNotification(text: 'Charge Your Phone! Your phone battery is $batteryPercentage%');
        }
        else if(batteryPercentage < 6){
          await method.playSoundLessThan6();
          method.showNotification(text: 'Charge Your Phone! Your phone battery is $batteryPercentage%');
        }
      }
    }
    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return OrientationBuilder(
            builder: (context, orientation){
              SizeConfig().init(constraints, orientation);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                title: 'Notifier App',
                theme: ThemeData(
                  textTheme: const TextTheme(
                    bodyText1: TextStyle(),
                    bodyText2: TextStyle(),
                  ).apply(
                    bodyColor: whiteColor,
                  ),
                ),
                home: const HomeScreen(),
              );
            });
      },
    );
  }
}

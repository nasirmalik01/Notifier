import 'dart:async';
import 'dart:io';

import 'package:battery/battery.dart';
import 'package:device_info/device_info.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:notifier_app/consts/colors.dart';
import 'package:notifier_app/lib.dart';
import 'package:notifier_app/presentation/country_drop_down.dart';
import 'package:notifier_app/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final battery = Battery();
  int batteryLevel = 100;
  BatteryState batteryState = BatteryState.full;
  late Timer timer;
  late StreamSubscription subscription;
  String _deviceId = '';

  @override
  void initState() {
    super.initState();
    listenBatteryLevel();
    listenBatteryState();
    getPrefs();
  }

  void listenBatteryState() =>
      subscription = battery.onBatteryStateChanged.listen(
            (batteryState) => setState(() => this.batteryState = batteryState),
      );

  void listenBatteryLevel() {
    updateBatteryLevel();
    timer = Timer.periodic(const Duration(seconds: 10), (_) async => updateBatteryLevel(),
    );
  }

  Future updateBatteryLevel() async {
    final batteryLevel = await battery.batteryLevel;
    setState(() => this.batteryLevel = batteryLevel);
  }

  Future<void> getPrefs() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if(_prefs.getString('device_id') == null){
      return;
    }
    setState(() => _deviceId = _prefs.getString('device_id')!);
  }


  @override
  void dispose() {
    timer.cancel();
    subscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CountryDropDown(),
          notifyTextWidget(),
          showBattery(batteryLevel: batteryLevel),
          activateButton(text: _deviceId == '' ? LocaleKeys.activateClutch.tr() : LocaleKeys.deActivateClutch.tr(),
              onPress: activateClutch
          ),
          showAd()
        ],
      ),
    );
  }
  
  activateClutch() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if(_deviceId != ''){
      setState(() {
        _prefs.setString('device_id', '');
        _deviceId = '';
      });
      return;
    }
    var deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid){
      var androidDeviceInfo = await deviceInfo.androidInfo;
      _prefs.setString('device_id', androidDeviceInfo.id);
      setState(() {
        _deviceId = _prefs.getString('device_id')!;
      });
    } else if(Platform.isIOS){
      var iOSDeviceInfo = await deviceInfo.iosInfo;
      _prefs.setString('device_id', iOSDeviceInfo.model);
      setState(() {
        _deviceId = _prefs.getString('device_id')!;
      });
    }
  }
}
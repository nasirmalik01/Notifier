import 'package:audioplayers/audioplayers.dart';
import 'package:battery/battery.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Method{
  AudioPlayer player = AudioPlayer(playerId: "123");
  AudioCache cache = AudioCache();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
      playSound: true
  );

  Future<void> showNotification({String? text}) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.show(
      123,
      "Battery may run out soon",
      text,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
          color: Colors.blue,
          icon: '@mipmap/ic_launcher',
          playSound: true,
          sound: const RawResourceAndroidNotificationSound('noti_sound'),
          // importance: Importance.max,
          // priority: Priority.high,
        ),
      ),
    );
  }

  Future<void> storeBatteryLevelToDb({int? batteryLevel}) async {
    var deviceInfo = DeviceInfoPlugin();
    var androidDeviceInfo = await deviceInfo.androidInfo;
    print('Id: ${androidDeviceInfo.id}');
    await FirebaseFirestore.instance.collection('Battery').doc(androidDeviceInfo.id).set({
      'battery_level': batteryLevel
    });
  }

  // Future<void> storeBatteryLevelToDb2() async {
  //   final battery = Battery();
  //   final batteryLevel = await battery.batteryLevel;
  //
  //   var deviceInfo = DeviceInfoPlugin();
  //   var androidDeviceInfo = await deviceInfo.androidInfo;
  //   print('Id: ${androidDeviceInfo.id}');
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   _prefs.setInt('battery_level', batteryLevel);
  // }

  Future<int> getBatteryLevel() async {
    var deviceInfo = DeviceInfoPlugin();
    var androidDeviceInfo = await deviceInfo.androidInfo;
    DocumentSnapshot _documentSnapshot = await FirebaseFirestore.instance.collection('Battery').doc(androidDeviceInfo.id).get();
    int batteryPercentage = _documentSnapshot.get('battery_level');
    return batteryPercentage;
  }

  // Future<int?> getBatteryLevel2() async {
  //   var deviceInfo = DeviceInfoPlugin();
  //   var androidDeviceInfo = await deviceInfo.androidInfo;
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   int? batteryPercentage = _prefs.getInt('battery_level');
  //   return batteryPercentage;
  // }

  playSoundLessThan2() async {
    player = await cache.play('audio/beep_sound.mp3', volume: 1.0);
  }

  playSoundLessThan4() async {
    player = await cache.play('audio/beep_sound.mp3', volume: 0.8);
  }

  playSoundLessThan6() async {
    player = await cache.play('audio/beep_sound.mp3', volume: 0.5);
  }
}
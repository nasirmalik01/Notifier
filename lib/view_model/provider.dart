// // import 'dart:io';
// //
// // import 'package:device_info/device_info.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
//
// // class ClutchProvider with ChangeNotifier{
// //
// //   void activateClutch({String? deviceId}) async {
// //     SharedPreferences _prefs = await SharedPreferences.getInstance();
// //     if(deviceId != ''){
// //         _prefs.setString('device_id', '');
// //         deviceId = '';
// //         notifyListeners();
// //       return;
// //     }
// //     var deviceInfo = DeviceInfoPlugin();
// //     if(Platform.isAndroid){
// //       var androidDeviceInfo = await deviceInfo.androidInfo;
// //       _prefs.setString('device_id', androidDeviceInfo.id);
// //         deviceId = _prefs.getString('device_id')!;
// //         notifyListeners();
// //     } else if(Platform.isIOS){
// //       var iOSDeviceInfo = await deviceInfo.iosInfo;
// //       _prefs.setString('device_id', iOSDeviceInfo.model);
// //         deviceId = _prefs.getString('device_id')!;
// //         notifyListeners();
// //     }
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ClutchProvider with ChangeNotifier{
//   void addClutch() async{
//     if(true){
//       var _deviceId = await SharedPreferences.getInstance();
//       _deviceId.setString('KEY_VALUE', '123456');
//       print(_deviceId.getString('KEY_VALUE'));
//     }else{
//       var iosDeviceID = await SharedPreferences.getInstance();
//     }
//   }
// }
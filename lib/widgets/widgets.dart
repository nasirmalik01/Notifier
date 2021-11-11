import 'package:battery_indicator/battery_indicator.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:notifier_app/consts/colors.dart';
import 'package:notifier_app/consts/config.dart';
import 'package:notifier_app/lib.dart';
import 'package:notifier_app/view_model/admob_service.dart';

Widget notifyTextWidget(){
  return Container(
    margin: EdgeInsets.only(top: heightMultiplier!*5),
    child: Center(
      child: Column(
        children: [
          Text(LocaleKeys.letUsNotify1.tr(), style: GoogleFonts.pressStart2p(
              fontSize: textMultiplier!*1.7
          ),),
          SizedBox(height: heightMultiplier!),
          Text(LocaleKeys.letUsNotify2.tr(), style: GoogleFonts.pressStart2p(
              fontSize: textMultiplier!*1.7
          ),),
          SizedBox(height: heightMultiplier!),
          Text(LocaleKeys.letUsNotify3.tr(), style: GoogleFonts.pressStart2p(
              fontSize: textMultiplier!*1.7
          ),),
        ],
      ),
    ),
  );
}

Widget showBattery({int? batteryLevel}){
  return Column(
    children: [
      BatteryIndicator(
        style: BatteryIndicatorStyle.values[1],
        colorful: true,
        showPercentNum: false,
        mainColor: Colors.white,
        size: 80,
        ratio: 2.7,
        showPercentSlide: true,
      ),
      SizedBox(height: heightMultiplier!,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(LocaleKeys.remainingBattery.tr(), style: GoogleFonts.pressStart2p(fontSize: textMultiplier!*1.2),),
          Text(' $batteryLevel%', style: GoogleFonts.pressStart2p(fontSize: textMultiplier!*1.2),),
        ],
      ),
    ],
  );
}

Widget activateButton({String? text, Function()? onPress}){
  return ElevatedButton(
    onPressed: onPress,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: widthMultiplier!*6, horizontal: widthMultiplier!*3),
        child: Text(text!, style: GoogleFonts.pressStart2p(
          fontSize: textMultiplier!*1.4
        ),),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: const BorderSide(color: whiteColor)
              )
          )
      )
  );
}

Widget showAd(){
  return SizedBox(
    width: double.infinity,
    height: 70,
    child: AdWidget(
      key: UniqueKey(),
      ad: AdMobService.createBannerAd()..load(),
    ),
  );
}
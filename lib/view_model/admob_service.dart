import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService{
  static String get bannerAdUnitId => Platform.isAndroid ? 'ca-app-pub-3940256099942544/6300978111' :
      '';

  static initialize() async {
    if(MobileAds.instance == null){
      await MobileAds.instance.initialize();
    }
  }

  static BannerAd createBannerAd(){
    BannerAd bannerAd = BannerAd(
        size: AdSize.largeBanner,
        adUnitId: 'ca-app-pub-3940256099942544/6300978111',
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) => print('Add loaded'),
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            print('Add loaded');
            ad.dispose();
          },
          onAdOpened: (Ad ad) => print('Add opened'),
          onAdClosed: (Ad ad) => print('Add closed'),

        ),
        request: const AdRequest());

    return bannerAd;
  }
}
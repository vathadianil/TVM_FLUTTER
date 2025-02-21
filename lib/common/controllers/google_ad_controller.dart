import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tsavaari/data/services/google_ads_helper.dart';

class GoogleAdController extends GetxController {
  BannerAd? bannerAd;
  var isBannerAdReady = false.obs;
  var isBannerAdError = false.obs;
  AdSize? adSize;

  GoogleAdController([this.adSize]);

  @override
  void onInit() {
    super.onInit();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    // Dispose of any existing ad first
    bannerAd?.dispose();

    bannerAd = BannerAd(
      size: adSize ?? AdSize.largeBanner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(
        onAdClicked: (ad) {
          return;
        },
        onAdLoaded: (_) {
          isBannerAdReady.value = true;
          isBannerAdError.value = false;
          print('=================Ad Loaded Successfully');
        },
        onAdFailedToLoad: (ad, error) {
          print('=================Ad Failed to Load: ${error.message}');
          isBannerAdReady.value = false;
          isBannerAdError.value = true;
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    );

    bannerAd?.load();
  }

  @override
  void onClose() {
    bannerAd?.dispose();
    super.onClose();
  }
}

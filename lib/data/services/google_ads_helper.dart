import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/controllers/google_ad_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';

class AdHelper {
  // Replace these test ad units with your real ones for production
  static String get bannerAdUnitId {
    return 'ca-app-pub-9888271084992801/9346906396';
  }

  // static String get topBannerAdUnitId {
  //   return 'ca-app-pub-3940256099942544/1033173712';
  // }
}

class GoogleAdBanner extends StatelessWidget {
  final double? width;
  final double? height;
  final AdSize adSize;

  const GoogleAdBanner({
    super.key,
    this.width,
    this.height,
    this.adSize = AdSize.largeBanner,
  });

  @override
  Widget build(BuildContext context) {
    final GoogleAdController adController = Get.put(GoogleAdController(adSize));
    adController.onInit(); // Explicitly call onInit to load the ads

    return Obx(() {
      final double actualWidth = width ?? adSize.width.toDouble();
      final double actualHeight = height ?? adSize.height.toDouble();
      
      return adController.isBannerAdReady.value && adController.bannerAd != null 
        ? Container(
            clipBehavior: Clip.hardEdge,
            width: actualWidth,
            height: actualHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TSizes.md),
              border: Border.all(
                width: 1,
                color: TColors.grey,
              ),
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: AbsorbPointer(
                absorbing: true,
                child: SizedBox(
                  width: adController.bannerAd!.size.width.toDouble(),
                  height: adController.bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: adController.bannerAd!),
                ),
              ),
            )
          )
          : adController.isBannerAdError.value
              ? const SizedBox.shrink()
              : ShimmerEffect(
                  width: actualWidth,
                  height: actualHeight,
                );

      // return Container(
      //   clipBehavior: Clip.hardEdge,
      //   width: actualWidth,
      //   height: actualHeight,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(TSizes.md),
      //     border: Border.all(
      //       width: 1,
      //       color: TColors.grey,
      //     ),
      //   ),
      //   child: adController.isBannerAdReady.value && adController.bannerAd != null
      //       ? FittedBox(
      //           fit: BoxFit.contain,
      //           child: AbsorbPointer(
      //             absorbing: true,
      //             child: SizedBox(
      //               width: adController.bannerAd!.size.width.toDouble(),
      //               height: adController.bannerAd!.size.height.toDouble(),
      //               child: AdWidget(ad: adController.bannerAd!),
      //             ),
      //           ),
      //         )
      //       : adController.isBannerAdError.value
      //           ? const Center(
      //               child: Icon(
      //                 Iconsax.warning_2,
      //                 color: TColors.darkGrey,
      //               ),
      //             )
      //           : ShimmerEffect(
      //               width: actualWidth,
      //               height: actualHeight,
      //             ),
      // );
    });
  }
}

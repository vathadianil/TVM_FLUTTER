import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tsavaari/common/widgets/containers/t_circular_container.dart';
import 'package:tsavaari/common/widgets/images/rounded_corner_image.dart';
import 'package:tsavaari/data/services/google_ads_helper.dart';
import 'package:tsavaari/features/home/controllers/banner_controller.dart';
import 'package:tsavaari/utils/constants/banner_page_type.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

import 'package:tsavaari/utils/loaders/shimmer_effect.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerImageSlider extends StatelessWidget {
   BannerImageSlider({
    super.key,
    this.autoPlay = false,
    required this.pageType, 
    // this.defaultImage,
    // this.showDefaultImage = true, 
  });

  final bool autoPlay;
  final String pageType;
  // final String? defaultImage;
  // final bool showDefaultImage; 
  final controller = Get.put(BannerController());

  Future<void> _launchURL(String? url) async {
    if (url == null || url.isEmpty) return;
    
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  bool _shouldShowGoogleAds() {
    if (controller.adsSettings.value == null) return false;

    switch (pageType) {
      case BannerPageType.homePage:
        return controller.adsSettings.value!.showGoogleAdsHomePage ?? false;
      case BannerPageType.qRTicketBooking:
        return controller.adsSettings.value!.showGoogleAdsQRTicketBooking ?? false;
      case BannerPageType.rechargeBanner:
        return controller.adsSettings.value!.showGoogleAdsRechargeBanner ?? false;
      case BannerPageType.loginPage:
        return controller.adsSettings.value!.showGoogleAdsLoginPage ?? false;
      case BannerPageType.qrTicketsDetails:
        return controller.adsSettings.value!.showGoogleAdsQRTicketDetails ?? false;
      case BannerPageType.metroNetworkMap:
        return controller.adsSettings.value!.showGoogleAdsMetroNetworkMap ?? false;
      default:
        return false;
    }
  }

  AdSize _getAdSizeForPageType() {
    switch (pageType) {
      case BannerPageType.homePage:
        return AdSize.largeBanner;
      case BannerPageType.qRTicketBooking:
        return AdSize.largeBanner;
      case BannerPageType.rechargeBanner:
        return AdSize.mediumRectangle;
      case BannerPageType.loginPage:
        return AdSize.largeBanner;
      case BannerPageType.qrTicketsDetails:
        return AdSize.mediumRectangle;
      case BannerPageType.metroNetworkMap:
        return AdSize.largeBanner;
      default:
        return AdSize.largeBanner;
    }
  }

  bool _shouldShowBanners() {
    if (controller.adsSettings.value == null) return false;

    switch (pageType) {
      case BannerPageType.homePage:
        return controller.adsSettings.value!.showBannersHomePage ?? false;
      case BannerPageType.qRTicketBooking:
        return controller.adsSettings.value!.showBannersQRTicketBooking ?? false;
      case BannerPageType.rechargeBanner:
        return controller.adsSettings.value!.showBannersRechargeBanner ?? false;
      case BannerPageType.loginPage:
        return controller.adsSettings.value!.showBannersLoginPage ?? false;
      case BannerPageType.qrTicketsDetails:
        return controller.adsSettings.value!.showBannersQRTicketDetails ?? false;
      case BannerPageType.metroNetworkMap:
        return controller.adsSettings.value!.showBannersMetroNetworkMap ?? false;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: TSizes.sm,
        ),
        Obx(() {
          //Loader
          if (controller.isLoading.value) {
            return Padding(
              padding: EdgeInsets.all(TDeviceUtils.getScreenWidth(context) * .04,),
              child: const ShimmerEffect(width: double.infinity, height: 180),
            );
          }

          // Show Google Ads if googleAds is true
          if (_shouldShowGoogleAds()) {
            return GoogleAdBanner(
              key: ValueKey('${pageType}_google_ad'), // Unique key for each ad
              adSize: _getAdSizeForPageType(),
            );
          }

          // Filter banners and create imageList reactively
          // final imageList = controller.bannersList
          //     .where((banner) => banner.bannerType == pageType)
          //     .expand((banner) => banner.bannerDetails!.map((detail) => detail.imageUrl ?? ''));
          
          // Filter banners and create imageList reactively
          final pageBanners = controller.bannersList
              .where((banner) => banner.bannerType == pageType)
              .expand((banner) => banner.bannerDetails!)
              .toList()
            ..sort((a, b) => (a.bannerSortId ?? 0).compareTo(b.bannerSortId ?? 0));
            
          if (_shouldShowBanners() && pageBanners.isNotEmpty) {
            return Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: autoPlay,
                    viewportFraction: 1,
                    padEnds: false,       
                    onPageChanged: (index, reason) {
                      controller.updatePageIndicator(index);
                    },
                  ),
                  items: pageBanners.map((bannerDetail) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding:  EdgeInsets.symmetric(
                                horizontal: TDeviceUtils.getScreenWidth(context) * .04,
                                vertical: TDeviceUtils.getScreenHeight() * .011,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: RoundedCornerImage(
                                  isNetworkImage: true,
                                  imageUrl: bannerDetail.imageUrl ?? '',
                                  fit: BoxFit.cover,
                                  applyBoxShadow: false,
                                  width: double.infinity,
                                  onPressed: () => _launchURL(bannerDetail.bannerRedirectLink),
                                )
                              ),
                            );
                          },
                        );
                      }).toList(),
                ),

                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                
                //Page Indicator
                if (controller.bannersList.isNotEmpty || pageBanners.isNotEmpty) 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < pageBanners.length; i++)
                      TCircularContainer(
                        width: TDeviceUtils.getScreenWidth(context) * .04,
                        height: TDeviceUtils.getScreenWidth(context) * .01,
                        backgroundColor: controller.carouselCurrentIndex.value == i
                            ? TColors.primary
                            : TColors.grey,
                        margin: const EdgeInsets.only(right: 10),
                      ),
                  ],
                ),
              ],
            );
          }

          return const SizedBox.shrink(); 

          // return showDefaultImage 
          //     ? RoundedCornerImage(
          //         isNetworkImage: false,
          //         padding: EdgeInsets.symmetric(
          //           horizontal: TDeviceUtils.getScreenWidth(context) * .04,
          //           vertical: TDeviceUtils.getScreenHeight() * .011,
          //         ),
          //         imageUrl: defaultImage ?? TImages.banner1,
          //         applyBoxShadow: false,
          //       )
          //     : const SizedBox.shrink(); 
        }),
        
      ],
    );
  }
}

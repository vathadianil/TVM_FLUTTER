import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/controllers/button_tabbar_controller.dart';
import 'package:tsavaari/common/widgets/appbar/button_tabbar.dart';
import 'package:tsavaari/common/widgets/appbar/t_appbar.dart';
import 'package:tsavaari/features/card_reacharge/controllers/metro_card_controller.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/card_history_shimmer.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/card_layout.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/card_layout_shimmer.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/card_topup_history.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/travel_history_card.dart';
import 'package:tsavaari/features/home/screens/widgets/banner_image_slider.dart';
import 'package:tsavaari/utils/constants/banner_page_type.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
// import 'package:tsavaari/features/card_reacharge/screens/widgets/add_or_edit_card_details.popup.dart';

class CardReachargeScreen extends StatelessWidget {
  const CardReachargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final cardHeight = screenWidth * .7;
    final cardController = Get.put(MetroCardController());
    final btnTabbarController = Get.put(ButtonTabbarController());
    final buttonTexts = [
      "Travel History",
      "Topup History",
    ];
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Card Recharge',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: TColors.white,
                )),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Obx(
          () => Column(
            children: [
              //--Metro Card
              if (cardController.isCardDetailsLoading.value)
                Column(
                  children: [
                    CardLayoutShimmer(cardHeight: cardHeight),
                    const SizedBox(
                      height: TSizes.spaceBtwSections * 2,
                    ),
                  ],
                ),
              if (!cardController.isCardDetailsLoading.value &&
                  cardController.cardDetailsByUser.isNotEmpty &&
                  cardController
                      .cardDetailsByUser.first.cardDetails!.isNotEmpty)
                CardLayout(
                  cardHeight: cardHeight,
                ),
              if (!cardController.isCardDetailsLoading.value &&
                  cardController.cardDetailsByUser.isEmpty)
                Center(
                  child: Column(
                    children: [
                      const Text('No Card Data Found'),
                      const SizedBox(
                        height: TSizes.spaceBtwSections * 2,
                      ),
                      //-- Display Google Ads Or Banners
                      BannerImageSlider(
                        autoPlay: true,
                        pageType: BannerPageType.rechargeBanner,
                      ),
                    ],
                  ),
                ),

              if (cardController.cardDetailsByUser.isNotEmpty)
                ButtonTabbar(
                  buttonTexts: buttonTexts,
                  onTap: (index) {
                    btnTabbarController.tabIndex.value = index;
                  },
                ),

              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              //--Travel history cards
              if (btnTabbarController.tabIndex.value == 0 &&
                  cardController.isCardTravelHistoryLoading.value)
                const CardHiistroyShimmer(),
              if (btnTabbarController.tabIndex.value == 0 &&
                  !cardController.isCardTravelHistoryLoading.value &&
                  cardController.cardTravelHistoryList.isNotEmpty &&
                  cardController
                      .cardTravelHistoryList[
                          cardController.carouselCurrentIndex.value]
                      .response!
                      .isNotEmpty)
                Obx(
                  () => ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cardController
                        .cardTravelHistoryList[
                            cardController.carouselCurrentIndex.value]
                        .response!
                        .length,
                    itemBuilder: (context, index) {
                      return TravelHistoryCard(
                        cardTravelData: cardController
                            .cardTravelHistoryList[
                                cardController.carouselCurrentIndex.value]
                            .response![index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: TSizes.spaceBtwItems,
                      );
                    },
                  ),
                ),
              if (btnTabbarController.tabIndex.value == 0 &&
                  cardController.cardTravelHistoryList.isNotEmpty &&
                  !cardController.isCardTravelHistoryLoading.value &&
                  cardController
                      .cardTravelHistoryList[
                          cardController.carouselCurrentIndex.value]
                      .response!
                      .isEmpty &&
                  !cardController.isCardTravelHistoryLoading.value)
                const Text('No Data Found'),

              //--Transaction history cards
              if (btnTabbarController.tabIndex.value == 1 &&
                  cardController.isCardPaymentDataLoading.value)
                const CardHiistroyShimmer(),
              if (btnTabbarController.tabIndex.value == 1 &&
                  cardController.cardPaymentListData.isNotEmpty &&
                  !cardController.isCardPaymentDataLoading.value &&
                  cardController
                          .cardPaymentListData[
                              cardController.carouselCurrentIndex.value]
                          .response !=
                      null &&
                  cardController
                      .cardPaymentListData[
                          cardController.carouselCurrentIndex.value]
                      .response!
                      .isNotEmpty)
                Obx(
                  () => ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CardTopupHistory(
                        cardPaymentTrxData: cardController
                            .cardPaymentListData[
                                cardController.carouselCurrentIndex.value]
                            .response![index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: TSizes.spaceBtwItems,
                      );
                    },
                    itemCount: cardController
                        .cardPaymentListData[
                            cardController.carouselCurrentIndex.value]
                        .response!
                        .length,
                  ),
                ),
              if (btnTabbarController.tabIndex.value == 1 &&
                  cardController.cardPaymentListData.isNotEmpty &&
                  !cardController.isCardPaymentDataLoading.value &&
                  cardController
                      .cardPaymentListData[
                          cardController.carouselCurrentIndex.value]
                      .response!
                      .isEmpty &&
                  !cardController.isCardPaymentDataLoading.value)
                const Text('No Data Found'),
            ],
          ),
        ),
      ),
    );
  }
}

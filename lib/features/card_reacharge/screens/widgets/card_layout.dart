import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/widgets/containers/t_circular_container.dart';
import 'package:tsavaari/common/widgets/containers/t_flip.dart';
import 'package:tsavaari/features/card_reacharge/controllers/metro_card_controller.dart';
import 'package:tsavaari/features/card_reacharge/controllers/one_direction_scroll_physics.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/card_back_view.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/card_front_view.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/tap_on_the_card_text.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class CardLayout extends StatelessWidget {
  const CardLayout({
    super.key,
    required this.cardHeight,
  });

  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final cardController = MetroCardController.instance;
    return Obx(
      () => Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              scrollPhysics: cardController.isNebulaCardValidating.value
                  ? const NeverScrollableScrollPhysics()
                  : cardController.carouselCurrentIndex.value == 0
                      ? const OneDirectionScrollPhysics()
                      : const AlwaysScrollableScrollPhysics(),
              enableInfiniteScroll:
                  cardController.cardDetailsByUser.first.cardDetails!.length !=
                      1,
              autoPlay: false,
              height: screenWidth * .2,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                cardController.updatePageIndicator(index);
              },
            ),
            items: cardController.cardDetailsByUser.first.cardDetails!
                .asMap()
                .entries
                .map(
                  (cardData) => TFlip(
                    foreGroudndWidget: CardFrontView(
                      index: cardData.key,
                      cardHeight: cardHeight,
                      cardHolderName: cardData.value.cardDesc ?? '',
                      cardNumber: cardData.value.cardNo ?? '',
                    ),
                    backGroundWidget: CardBackView(
                      index: cardData.key,
                      cardHeight: cardHeight,
                      cardNumber: cardData.value.cardNo ?? '',
                    ),
                  ),
                )
                .toList(),
          ),

          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          if (!cardController.isCardDetailsLoading.value &&
              cardController.cardDetailsByUser.first.cardDetails!.length != 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0;
                    i <
                        cardController
                            .cardDetailsByUser.first.cardDetails!.length;
                    i++)
                  Obx(
                    () => TCircularContainer(
                      width: TDeviceUtils.getScreenWidth(context) * .04,
                      height: TDeviceUtils.getScreenWidth(context) * .01,
                      backgroundColor:
                          cardController.carouselCurrentIndex.value == i
                              ? TColors.primary
                              : TColors.grey,
                      margin: const EdgeInsets.only(right: 10),
                    ),
                  ),
              ],
            ),

          //-- Tap on Card Text
          const TapOnTheCardText(),

          const Divider(),
        ],
      ),
    );
  }
}

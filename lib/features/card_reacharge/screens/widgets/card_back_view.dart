import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/card_reacharge/controllers/metro_card_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/card_recharge_status_stepper.dart';

class CardBackView extends StatelessWidget {
  const CardBackView(
      {super.key,
      required this.cardHeight,
      required this.cardNumber,
      required this.index});

  final double cardHeight;
  final String cardNumber;
  final int index;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final cardController = MetroCardController.instance;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: screenWidth * .025,
      ),
      padding: EdgeInsets.symmetric(
          vertical: screenWidth * .025, horizontal: screenWidth * .03),
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.md),
        color: isDark ? TColors.dark : TColors.light,
        boxShadow: [
          BoxShadow(
            blurRadius: TSizes.md,
            color: THelperFunctions.isDarkMode(context)
                ? TColors.accent
                : TColors.darkGrey,
          )
        ],
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: screenWidth * .04,
                  backgroundColor: TColors.white,
                  backgroundImage: const AssetImage(TImages.appLogo),
                ),
                Text(
                  cardNumber,
                  style: Theme.of(context).textTheme.bodyLarge!,
                ),
              ],
            ),
            SizedBox(
              height: cardHeight * .02,
            ),
            if (cardController.isLastRcgStatusLoading.value)
              ShimmerEffect(
                width: double.infinity,
                height: cardHeight * .25,
              ),
            if (!cardController.isLastRcgStatusLoading.value &&
                cardController.lastRcgStatusList.isNotEmpty &&
                cardController
                        .lastRcgStatusList[
                            cardController.carouselCurrentIndex.value]
                        .transactionCode !=
                    null)
              cardController.carouselCurrentIndex.value == index
                  ? CardRechargeStatusStepper(
                      cardHeight: cardHeight,
                      lastRechargeStatusData: cardController.lastRcgStatusList[
                          cardController.carouselCurrentIndex.value],
                    )
                  : const SizedBox(),
            if (!cardController.isLastRcgStatusLoading.value &&
                cardController.lastRcgStatusList.isEmpty)
              const Center(
                child: Text('No Data Found'),
              ),
          ],
        ),
      ),
    );
  }
}

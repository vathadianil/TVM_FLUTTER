import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/common/controllers/checkbox_controller.dart';
import 'package:tsavaari/features/card_reacharge/controllers/amounts_scroll_controller.dart';
import 'package:tsavaari/features/card_reacharge/controllers/metro_card_controller.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/add_or_edit_card_details.popup.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/delete_card_popup.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/topup_bottomsheet.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/bottom_sheet_pageview_controller.dart';
import 'package:tsavaari/features/reward_points/controllers/reward_points_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/card_recharge_utils.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';

class CardFrontView extends StatelessWidget {
  const CardFrontView(
      {super.key,
      required this.cardHeight,
      required this.cardHolderName,
      required this.cardNumber,
      required this.index});

  final double cardHeight;
  final String cardHolderName;
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
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.md),
        color: isDark ? TColors.dark : TColors.light,
        boxShadow: [
          BoxShadow(
            blurRadius: TSizes.md,
            color: isDark ? TColors.accent : TColors.darkGrey,
          )
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            //--Logo
            Positioned(
                top: constraints.maxWidth * .1,
                left: constraints.maxWidth * .1,
                child: CircleAvatar(
                  radius: constraints.maxWidth * .08,
                  backgroundColor: TColors.white,
                  backgroundImage: const AssetImage(TImages.appLogo),
                )),

            //--Edit and Delete Icons
            Positioned(
              top: constraints.maxWidth * .02,
              right: constraints.maxWidth * .05,
              child: Row(
                children: [
                  FloatingActionButton(
                    heroTag:
                        "edit-btn${CardRechargeUtils.generateRandomNumber(5)}",
                    onPressed: () {
                      cardController.cardHolderName.text = cardController
                              .cardDetailsByUser
                              .first
                              .cardDetails![
                                  cardController.carouselCurrentIndex.value]
                              .cardDesc ??
                          '';
                      cardController.cardNumber.text = cardController
                              .cardDetailsByUser
                              .first
                              .cardDetails![
                                  cardController.carouselCurrentIndex.value]
                              .cardNo ??
                          '';
                      Get.dialog(
                        barrierDismissible: false,
                        const AddOrEditCardDetailsPopup(
                          type: 'edit',
                        ),
                      );
                    },
                    mini: true,
                    shape: const CircleBorder(),
                    backgroundColor: TColors.white,
                    child: const Icon(
                      Iconsax.edit,
                      color: TColors.info,
                    ),
                  ),
                  FloatingActionButton(
                    heroTag:
                        "remove-btn${CardRechargeUtils.generateRandomNumber(5)}",
                    onPressed: () {
                      Get.dialog(const DeleteCardPopup());
                    },
                    mini: true,
                    shape: const CircleBorder(),
                    backgroundColor: TColors.white,
                    child: const Icon(
                      Iconsax.card_remove,
                      color: TColors.error,
                    ),
                  ),
                ],
              ),
            ),

            //--Card Number
            Positioned(
              top: constraints.maxHeight * .55,
              left: constraints.maxWidth * .05,
              child: Text(
                cardNumber,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),

            //-- Card Holder Name
            Positioned(
              top: constraints.maxHeight * .42,
              left: constraints.maxWidth * .05,
              child: SizedBox(
                width: constraints.maxWidth * .9,
                child: Text(
                  cardHolderName.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                  // maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            //--Reachage Button, Card Balance & Card Validity
            Obx(
              () => Positioned(
                top: constraints.maxHeight * .7,
                left: constraints.maxWidth * .05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (cardController.isNebulaCardValidating.value)
                      ShimmerEffect(
                        width: constraints.maxWidth * .9,
                        height: constraints.maxHeight * .25,
                      ),
                    if (!cardController.isNebulaCardValidating.value &&
                        cardController
                            .storeNebulaCardValidationDetails.isNotEmpty)
                      //--  Recharge button
                      Obx(
                        () => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                cardController.cardRechargeAmounts.isNotEmpty
                                    ? TColors.success
                                    : TColors.grey,
                            side: const BorderSide(color: TColors.white),
                            padding: const EdgeInsets.symmetric(
                              vertical: TSizes.xs,
                              horizontal: TSizes.md,
                            ),
                            elevation: TSizes.sm,
                          ),
                          onPressed: cardController
                                  .cardRechargeAmounts.isNotEmpty
                              ? () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) => TopupBottomSheet(
                                            cardData: cardController
                                                    .storeNebulaCardValidationDetails[
                                                cardController
                                                    .carouselCurrentIndex
                                                    .value],
                                          )).whenComplete(() {
                                    Get.delete<BottomSheetPageViewController>();
                                    Get.delete<CheckBoxController>();
                                    Get.delete<AmountsScrollController>();
                                    Get.delete<RewardPointsController>();
                                    cardController.resetRedemptionState();
                                  });
                                }
                              : null,
                          child: Text(
                            'Top up',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  color: TColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                    SizedBox(
                      width: constraints.maxWidth * .08,
                    ),
                    if (!cardController.isNebulaCardValidating.value &&
                        cardController
                            .storeNebulaCardValidationDetails.isNotEmpty)
                      SizedBox(
                        child: Row(
                          children: [
                            //-- Balance
                            Column(
                              children: [
                                Text(
                                  '\u{20B9} ${cardController.storeNebulaCardValidationDetails[cardController.carouselCurrentIndex.value].currentBalance ?? 0}/-',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  'Balance',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: constraints.maxWidth * .01,
                            ),
                            //-- Horizontal divider
                            Container(
                              height: constraints.maxHeight * .25,
                              decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                      color: TColors.darkGrey, width: 2),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: constraints.maxWidth * .01,
                            ),
                            //-- Validity
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  cardController
                                              .storeNebulaCardValidationDetails[
                                                  cardController
                                                      .carouselCurrentIndex
                                                      .value]
                                              .cardValidity !=
                                          null
                                      ? THelperFunctions.getFormattedDateString1(
                                          cardController
                                              .storeNebulaCardValidationDetails[
                                                  cardController
                                                      .carouselCurrentIndex
                                                      .value]
                                              .cardValidity!)
                                      : '',
                                  style: Theme.of(context).textTheme.bodyLarge!,
                                ),
                                Text(
                                  'Validity',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    if (!cardController.isNebulaCardValidating.value &&
                        cardController.storeNebulaCardValidationDetails.isEmpty)
                      const Text('No Data Found'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

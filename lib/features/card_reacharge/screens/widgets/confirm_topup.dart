import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/common/controllers/checkbox_controller.dart';
import 'package:tsavaari/features/card_reacharge/controllers/metro_card_controller.dart';
import 'package:tsavaari/features/card_reacharge/models/nebula_card_validation_model.dart';
// import 'package:tsavaari/features/card_reacharge/screens/widgets/reedem_points_container.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/proceed_to_pay_btn.dart';
// import 'package:tsavaari/features/reward_points/controllers/reward_points_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class ConfirmTopup extends StatelessWidget {
  const ConfirmTopup({
    super.key,
    required this.cardDetails,
  });
  final NebulaCardValidationModel cardDetails;
  @override
  Widget build(BuildContext context) {
    Get.put(CheckBoxController());
    // final rewardPointsController = RewardPointsController.instance;
    final cardController = MetroCardController.instance;
    final isDark = THelperFunctions.isDarkMode(context);

    // Trigger final amount calculation when building
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cardController.updateFinalRechargeAmount();
    });

    return ListView(
      shrinkWrap: true,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Iconsax.arrow_left)),
            const SizedBox(
              width: TSizes.md,
            ),
            Text('Topup Details',
                textScaler: TextScaleUtil.getScaledText(context),
                style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),

        // if (rewardPointsController.loyaltyProgramKey.value == 1)...[
        //   const SizedBox(
        //     height: TSizes.spaceBtwItems,
        //   ),
        //   const RedeemPointsContainer(),
        // ],

        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Card Current Balance',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              '${TTexts.rupeeSymbol}${cardDetails.currentBalance}/-',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        const Divider(),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Top Up Amount',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              '${TTexts.rupeeSymbol}${cardController.selectedTopupAmount.value}/-',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        const Divider(),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        //-- Redeem Points Section -
        Obx(() {
          return cardController.isRedeemed.value
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Redeemed Amount",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          '- ${TTexts.rupeeSymbol}${cardController.maxRedemptionAmount.value}/-',
                          // cardController.selectedTopupAmount.value != cardController.maxRedemptionAmount.value.toString()
                          //     ? '- ${TTexts.rupeeSymbol}${cardController.maxRedemptionAmount.value}/-'
                          //     : '${TTexts.rupeeSymbol}0/-',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    Text(
                      'Points redeemed for this order is ${cardController.pointsToRedeem} pts',
                      // cardController.selectedTopupAmount.value != cardController.maxRedemptionAmount.value.toString()
                      //     ? 'Points redeemed for this order is ${cardController.pointsToRedeem} pts'
                      //     : 'Redemption is not permitted for this amount.',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    // Final Recharge Amount
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Final Amount",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Row(
                          children: [
                            Text(
                              '${TTexts.rupeeSymbol}${cardController.finalRechargeAmount.value}/-',
                              // cardController.selectedTopupAmount.value != cardController.maxRedemptionAmount.value.toString()
                              //     ? '${TTexts.rupeeSymbol}${cardController.finalRechargeAmount.value}/-'
                              //     : '${TTexts.rupeeSymbol}${cardController.selectedTopupAmount.value}/-',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                  ],
                )
              : const SizedBox.shrink();
        }),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              THelperFunctions.getFormattedDateTime1(DateTime.now()),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        const Divider(),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        ListTile(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
          tileColor: TColors.info.withOpacity(.1),
          leading: const Icon(
            Iconsax.info_circle,
            color: TColors.primary,
          ),
          subtitle: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text:
                      'For the recharge amount to be reflected in your smart card, Please tap your smart card at',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: isDark ? TColors.accent : TColors.primary),
                ),
                TextSpan(
                  text: ' Entry Gates ',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? TColors.accent : TColors.primary),
                ),
                TextSpan(
                  text: 'or use prepaid option at',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: isDark ? TColors.accent : TColors.primary),
                ),
                TextSpan(
                  text: ' AVM/TVM ',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? TColors.accent : TColors.primary),
                ),
                TextSpan(
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: isDark ? TColors.accent : TColors.primary),
                    text:
                        'machines after 20 minutes of successful online recharge. In case smart card is not tapped with in 15 days of successful online recharge, the recharge amount will be automatically refunded to the respective account after 15 working days of the succesful online recharge'),
              ],
            ),
          ),
        ),
        CustomBtnWithTermsDialog(
            btnText: 'Proceed to Pay',
            onPressed: () {
              if ((int.parse(cardDetails.currentBalance!) +
                      int.parse(cardController.selectedTopupAmount.value)) <=
                  3000) {
                cardController.proceedToRecharge();
              } else {
                TLoaders.warningSnackBar(
                    title: 'Topup Limit Exceded',
                    message:
                        'Your current balance and top-up amount must not exceed the limit of 3,000. Please select a lower amount.');
              }
            }),
      ],
    );
  }
}

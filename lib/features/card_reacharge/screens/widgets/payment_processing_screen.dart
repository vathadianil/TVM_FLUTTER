import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/bottom_navigation/bottom_navigation_menu.dart';
import 'package:tsavaari/common/widgets/layout/max_width_container.dart';
import 'package:tsavaari/features/card_reacharge/controllers/payment_processing_controller.dart';
import 'package:tsavaari/features/reward_points/controllers/reward_points_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/payment_modes.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/loaders/animation_loader.dart';

class PaymentProcessingScreen extends StatelessWidget {
  const PaymentProcessingScreen({
    super.key,
    required this.isRechargeSuccess,
    required this.orderId,
    required this.amount,
    required this.date,
    this.message =
        'If any amount deducted will be refuned to your source account in 2-3 business days',
    this.retryRecharge = false,
    required this.cardNumber,
    required this.pgOrderId,
    required this.pgPaymentMode,
    required this.pgPaymentStatus,
    required this.isReedeemed,
    required this.finalRedeemedAmount,
    required this.isRedemptionEligibile,
    required this.pointsToRedeem,
    required this.quoteId,
  });

  final bool isRechargeSuccess;
  final bool retryRecharge;

  final String orderId;
  final String amount;
  final String date;
  final String message;
  final String cardNumber;
  final String pgOrderId;
  final String pgPaymentStatus;
  final String pgPaymentMode;
  final bool isReedeemed;
  final String finalRedeemedAmount; //Total amount after reedem
  final int isRedemptionEligibile;
  final int pointsToRedeem;
  final String quoteId;

  @override
  Widget build(BuildContext context) {
    final paymentProcessingController = Get.put(CardPaymentProcessingController(
      addValueAmount: amount,
      retryRecharge: retryRecharge,
      orderId: orderId,
      cardNumber: cardNumber,
      pgOrderId: pgOrderId,
      pgPaymentMode: pgPaymentMode,
      pgPaymentStatus: pgPaymentStatus,
      isRedemptionEligibile: isRedemptionEligibile,
      pointsToRedeem: pointsToRedeem,
      quoteId: quoteId,
      finalRedeemedAmount: finalRedeemedAmount,
    ));

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
              child: MaxWidthContaiiner(
                  child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isRechargeSuccess)
                  Column(
                    children: [
                      Text(
                        'Recharge Success',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: TColors.success),
                      ),
                      const TAnimationLoaderWidget(
                        isGifanimation: false,
                        animation: TImages.paymentSuccess,
                        text:
                            'Your Recharge is Succcessful. The balance may take up to 20mins to reflect on your card.',
                      ),
                    ],
                  )
                else if (!retryRecharge)
                  Column(
                    children: [
                      Text(
                        'Recharge Failed',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: TColors.error),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      TAnimationLoaderWidget(
                        isGifanimation: false,
                        animation: TImages.paymentFailed,
                        text: message,
                      ),
                    ],
                  )
                else
                  Obx(
                    () => Column(
                      children: [
                        if (paymentProcessingController
                                .isPaymentVerifing.value &&
                            !paymentProcessingController
                                .hasPaymentVerifyRetriesCompleted.value)
                          Text(
                            'Payment in Progress',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        if (paymentProcessingController
                                .isRechargeVerifing.value &&
                            !paymentProcessingController
                                .hasRechargeVerifyRetriesCompleted.value)
                          Text(
                            'Recharge in Progress',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),

                        if (paymentProcessingController
                                .hasPaymentVerifyRetriesCompleted.value &&
                            !paymentProcessingController
                                .hasVerifyPaymentSuccess.value)
                          Text(
                            'Payment Failed',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: TColors.error),
                          ),

                        if (paymentProcessingController
                                .hasRechargeVerifyRetriesCompleted.value &&
                            !paymentProcessingController
                                .hasVerifyRechargeSuccess.value)
                          Text(
                            'Recharge Failed',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: TColors.error),
                          ),

                        if (paymentProcessingController
                                .hasRechargeVerifyRetriesCompleted.value &&
                            paymentProcessingController
                                .hasVerifyRechargeSuccess.value)
                          Text(
                            'Recharge Success',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: TColors.error),
                          ),

                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),

                        //--Processing animation

                        if (paymentProcessingController
                                .isPaymentVerifing.value &&
                            !paymentProcessingController
                                .hasRechargeVerifyRetriesCompleted.value)
                          const TAnimationLoaderWidget(
                            isGifanimation: true,
                            animation: TImages.trainAnimation,
                            text: 'Payment in Progress. Please wait...',
                          ),

                        if (paymentProcessingController
                                .isRechargeVerifing.value &&
                            !paymentProcessingController
                                .hasRechargeVerifyRetriesCompleted.value)
                          const TAnimationLoaderWidget(
                            isGifanimation: true,
                            animation: TImages.trainAnimation,
                            text: 'Payment Successful. Recharge in Progress...',
                          ),

                        //-- Payment Success animation
                        if (paymentProcessingController
                                .hasRechargeVerifyRetriesCompleted.value &&
                            paymentProcessingController
                                .hasVerifyRechargeSuccess.value)
                          const TAnimationLoaderWidget(
                            isGifanimation: false,
                            animation: TImages.paymentSuccess,
                            text:
                                'Your Recharge is Succcessful. The balance may take up to 20mins to reflect on your card.',
                          ),

                        //-- Payment failed animation
                        if ((paymentProcessingController
                                    .hasPaymentVerifyRetriesCompleted.value &&
                                !paymentProcessingController
                                    .hasVerifyPaymentSuccess.value) ||
                            (paymentProcessingController
                                    .hasRechargeVerifyRetriesCompleted.value &&
                                !paymentProcessingController
                                    .hasVerifyRechargeSuccess.value))
                          TAnimationLoaderWidget(
                            isGifanimation: false,
                            animation: TImages.paymentFailed,
                            text: message,
                          )
                        else
                          const SizedBox(),
                      ],
                    ),
                  ),

                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Date:',
                    ),
                    Text(
                      date,
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Order Id:',
                    ),
                    Text(
                      orderId,
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  ],
                ),
                if (pgPaymentMode != '')
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                if (pgPaymentMode != '')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Payment Method:',
                      ),
                      Text(
                        PaymentModes.getPaymentMode(pgPaymentMode),
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                const Divider(),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recharge Amount:',
                    ),
                    Text(
                      '${TTexts.rupeeSymbol}$amount/-',
                      style: Theme.of(context).textTheme.headlineMedium,
                    )
                  ],
                ),

                //-- Redeem Points Section -
                if (isReedeemed) ...[
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Reedeemed Amount:',
                      ),
                      Text(
                        '${TTexts.rupeeSymbol}${(int.tryParse(amount) ?? 0) - (int.tryParse(finalRedeemedAmount) ?? 0)}/-', //ex: 10/-
                        style: Theme.of(context).textTheme.headlineMedium,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Final Amount:',
                      ),
                      Text(
                        '${TTexts.rupeeSymbol}$finalRedeemedAmount/-',
                        style: Theme.of(context).textTheme.headlineMedium,
                      )
                    ],
                  ),
                ],

                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                if (isRechargeSuccess || (!retryRecharge))
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace,
                        vertical: TSizes.defaultSpace / 2,
                      ),
                      side: const BorderSide(color: TColors.accent),
                    ),
                    onPressed: () {
                      Get.delete<RewardPointsController>();
                      Get.offAll(
                          () => const BottomNavigationMenu(requireAuth: false));
                    },
                    icon: const Icon(Iconsax.home),
                    label: const Text('Go Back to Home'),
                  )
                else
                  Obx(
                    () => Column(
                      children: [
                        if (paymentProcessingController
                                .hasPaymentVerifyRetriesCompleted.value ||
                            paymentProcessingController
                                .hasRechargeVerifyRetriesCompleted.value)
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: TSizes.defaultSpace,
                                vertical: TSizes.defaultSpace / 2,
                              ),
                              side: const BorderSide(color: TColors.accent),
                            ),
                            onPressed: () {
                              Get.offAll(() => const BottomNavigationMenu(
                                  requireAuth: false));
                              Get.delete<RewardPointsController>();
                            },
                            icon: const Icon(Iconsax.home),
                            label: const Text('Go Back to Home'),
                          )
                        else
                          Text(
                            'Do not close the app',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ))),
        ),
      ),
    );
  }
}

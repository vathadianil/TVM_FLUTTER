import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/bottom_navigation/bottom_navigation_menu.dart';
import 'package:tsavaari/common/widgets/layout/max_width_container.dart';
import 'package:tsavaari/features/qr/display_qr/models/create_refund_model.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/loaders/animation_loader.dart';

class RefundMessageScreen extends StatelessWidget {
  const RefundMessageScreen({super.key, required this.refundStatusData});

  final CreateRefundModel refundStatusData;

  @override
  Widget build(BuildContext context) {
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
                if (refundStatusData.refundStatus == 'SUCCESS')
                  Text(
                    'Refund Success',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: TColors.success),
                  ),

                if (refundStatusData.refundStatus == 'PENDING')
                  Text(
                    'Refund in Progress',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),

                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                //-- Refund Success animation
                if (refundStatusData.refundStatus == 'SUCCESS')
                  const TAnimationLoaderWidget(
                    isGifanimation: false,
                    animation: TImages.paymentSuccess,
                    text:
                        'Refund Succesful and the amount will be credited to your source account in 2-3 working days',
                  ),
                //--  Refund pending animation
                if (refundStatusData.refundStatus == 'PENDING')
                  const TAnimationLoaderWidget(
                    isGifanimation: false,
                    animation: TImages.paymentSuccess,
                    text:
                        'Refund in progress and the amount will be credited to your source account in 2-3 working days',
                  ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Date:',
                    ),
                    Text(
                      refundStatusData.createdAt != null
                          ? THelperFunctions.getFormattedDateTimeString2(
                              refundStatusData.createdAt!)
                          : '',
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
                      'Refund Id:',
                    ),
                    Text(
                      refundStatusData.refundId ?? '',
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
                      'Amount:',
                    ),
                    Text(
                      '${TTexts.rupeeSymbol}${refundStatusData.refundAmount!.toString()}/-',
                      style: Theme.of(context).textTheme.headlineMedium,
                    )
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.defaultSpace,
                      vertical: TSizes.defaultSpace / 2,
                    ),
                    side: const BorderSide(color: TColors.accent),
                  ),
                  onPressed: () {
                    Get.offAll(
                        () => const BottomNavigationMenu(requireAuth: false));
                  },
                  icon: const Icon(Iconsax.home),
                  label: const Text('Go Back to Home'),
                )
              ],
            ),
          ))),
        ),
      ),
    );
  }
}

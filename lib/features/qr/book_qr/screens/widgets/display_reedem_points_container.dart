import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/book_qr_controller.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/qr_shimmer_container.dart';
import 'package:tsavaari/features/reward_points/controllers/reward_points_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class DisplayRedeemPointsContainer extends StatelessWidget {
  const DisplayRedeemPointsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final BookQrController bookQrController = BookQrController.instance; 
    final RewardPointsController rewardPointsController = RewardPointsController.instance; 

    return Obx(
      () => Column(
        children: [
          if (bookQrController.isLoading.value && rewardPointsController.isLoadingPointsSummary.value)
            const QrShimmerContainer(),
          if (bookQrController.qrFareData.isNotEmpty &&
              !rewardPointsController.isLoadingPointsSummary.value &&
              !bookQrController.isLoading.value)
            Container(
              margin: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(TSizes.md),
                border: Border.all(
                  width: 1,
                  color: TColors.grey,
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(TSizes.md),
                leading: Container(
                  padding: const EdgeInsets.all(TSizes.iconSm),
                  decoration: BoxDecoration(
                    color: TColors.accent.withOpacity(.3),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Icon(
                    Iconsax.gift5,
                    color: TColors.secondary,
                  ),
                ),
                title: Text(
                  '${rewardPointsController.activePoints.toString()} pts',
                  textScaler: TextScaleUtil.getScaledText(context),
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: SizedBox(
                  width: rewardPointsController.activePoints.value < rewardPointsController.minRedemptionPoints.value
                      ? screenWidth * .5
                      : screenWidth * .4,
                  child: Text(
                    rewardPointsController.activePoints.value < rewardPointsController.minRedemptionPoints.value
                        ? 'A minimum of ${rewardPointsController.minRedemptionPoints.value} points is required to redeem.'
                        : 'Total redeem points',
                    maxLines: 2,
                    textScaler: TextScaleUtil.getScaledText(context),
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: TColors.darkGrey,
                        ),
                  ),
                ),
                trailing: rewardPointsController.activePoints.value >=
                            rewardPointsController.minRedemptionPoints.value 
                        // && bookQrController.qrFareData.first.finalFare! >
                        //     rewardPointsController.maxRedemptionAmount.value
                    ? GestureDetector(
                        onTap: bookQrController.isRedeemed.value
                            ? null
                            : () {
                                bookQrController.checkRedemptionEligibility();
                              },
                        child: Text(
                          bookQrController.isRedeemed.value
                              ? 'Redeemed'
                              : 'Redeem',
                          textScaler: TextScaleUtil.getScaledText(context),
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: bookQrController.isRedeemed.value
                                        ? TColors.darkGrey
                                        : TColors.warning,
                                  ),
                        ),
                      )
                    : null,
              ),
            ),
        ],
      ),
    );
  }
}      
                  
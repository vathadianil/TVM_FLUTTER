import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/features/card_reacharge/controllers/metro_card_controller.dart';
import 'package:tsavaari/features/reward_points/controllers/reward_points_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';

class RedeemPointsContainer extends StatelessWidget {
  const RedeemPointsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final cardController = Get.put(MetroCardController());
    final rewardPointsController = RewardPointsController.instance;

    return Obx(
      () {
        if (cardController.isRedemptionEligibilityLoading.value ||
            rewardPointsController.isLoadingPointsSummary.value) {
          return const ShimmerEffect(
            width: double.infinity,
            height: 100,
            radius: TSizes.md,
          );
        }

        return Container(
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
              width: rewardPointsController.activePoints <
                      rewardPointsController.minRedemptionPoints.value
                  ? screenWidth * .5
                  : screenWidth * .4,
              child: Text(
                rewardPointsController.activePoints <
                        rewardPointsController.minRedemptionPoints.value
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
            trailing: (rewardPointsController.activePoints >=
                        rewardPointsController.minRedemptionPoints.value)
                    // && int.tryParse(cardController.selectedTopupAmount.value)! >=
                    //     rewardPointsController.maxRedemptionAmount.value
                ? GestureDetector(
                    onTap: cardController.isRedeemed.value
                        ? null
                        : () {
                            cardController.checkCardRedemptionEligibility();
                          },
                    child: Text(
                      cardController.isRedeemed.value ? 'Redeemed' : 'Redeem',
                       textScaler: TextScaleUtil.getScaledText(context),
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: cardController.isRedeemed.value
                                ? TColors.darkGrey
                                : TColors.warning,
                          ),
                    ),
                  )
                : null,
          ),
        );
      },
    );
  }
}
      
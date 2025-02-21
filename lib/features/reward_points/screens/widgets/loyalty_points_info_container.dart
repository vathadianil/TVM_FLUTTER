import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/common/widgets/containers/t_circular_container.dart';
import 'package:tsavaari/features/reward_points/controllers/reward_points_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';

class LoyaltyPointsInfoContainer extends StatelessWidget {
  const LoyaltyPointsInfoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final RewardPointsController controller = RewardPointsController.instance;
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final isDark = THelperFunctions.isDarkMode(context);

    return Obx((){
        if (controller.isLoadingPointsSummary.value) {
          return ShimmerEffect(
            width: double.infinity, 
            height: TDeviceUtils.getScreenWidth(context) * .25);
        }
        
        return TCircularContainer(
          width: screenWidth,
          padding: TSizes.defaultSpace,
          applyBoxShadow: true,
          backgroundColor: isDark ? TColors.dark : TColors.white,
          boxShadowColor: isDark
              ? TColors.accent.withOpacity(.3)
              : TColors.accent,
          radius: TSizes.borderRadiusMd,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(TSizes.iconSm),
                    decoration: BoxDecoration(
                      color: TColors.accent.withOpacity(.3),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(
                      Iconsax.gift5,
                      color: TColors.primary,
                    ),
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Text(
                    'Total Points',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    ()=> Text(
                      controller.activePoints.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  // const SizedBox(
                  //   height: TSizes.xs,
                  // ),
                  // Text(
                  //   'Equals 20 INR',
                  //   style: Theme.of(context).textTheme.bodyMedium,
                  // ),
                ],
              ),
            ],
          ),
        );
      } 
    );
  }
}
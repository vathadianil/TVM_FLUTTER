import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tsavaari/common/widgets/containers/t_circular_container.dart';
import 'package:tsavaari/features/profile/controllers/profile_controller.dart';
import 'package:tsavaari/routes/routes.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final textScaler = TextScaleUtil.getScaledText(context);
    final controller = ProfileController.instance;
    
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.profilePage),
      child: TCircularContainer(
        width: screenWidth,
        applyBoxShadow: true,
        backgroundColor: dark ? TColors.dark : TColors.white,
        boxShadowColor:
            dark ? TColors.accent.withOpacity(.3) : TColors.accent,
        radius: TSizes.borderRadiusLg,
        padding: TSizes.sm,
        margin: const EdgeInsets.symmetric(
          vertical: TSizes.md,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              ()=> Lottie.asset(
                controller.rxGender.value == 'M'
                      ? TImages.maleAvatar
                      : TImages.femaleAvatar,
                  width: screenWidth * .2),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: TSizes.xs, 
                left: TSizes.sm,
              ),
              child: Obx(
                ()=> Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${controller.rxFirstName.value} ${controller.rxLastName.value}',
                      textScaler: textScaler,
                      style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w600),),
                    const SizedBox(height: TSizes.xs),
                    Text(
                      controller.rxMobileNo.value,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: TColors.darkGrey),
                      textScaler: textScaler,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      controller.rxEmailAddress.value,
                     style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: TColors.darkGrey),
                      textScaler: textScaler,
                      overflow: TextOverflow.ellipsis,
                    ),
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

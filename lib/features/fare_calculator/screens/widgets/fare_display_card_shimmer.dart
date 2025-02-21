import 'package:flutter/material.dart';

// import 'package:tsavaari/common/widgets/containers/t_ticket_shape_widget.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';

class FareDisplayCardShimmer extends StatelessWidget {
  const FareDisplayCardShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return PhysicalModel(
      color:
          isDark ? TColors.dark.withOpacity(.5) : TColors.grey.withOpacity(.01),
      shape: BoxShape.rectangle,
      elevation: TSizes.sm,
      shadowColor: isDark ? TColors.white.withOpacity(.2) : TColors.grey,
      borderRadius: BorderRadius.circular(TSizes.md),
      // child: TTicketShapeWidget(
      child: Container(
        decoration: BoxDecoration(
            color: isDark ? TColors.darkerGrey : TColors.white,
            borderRadius: BorderRadius.circular(TSizes.md)),
        padding: const EdgeInsets.all(
          TSizes.defaultSpace,
        ),
        child: Column(
          children: [
            ShimmerEffect(
              width: TDeviceUtils.getScreenWidth(context) / 1.4,
              height: 40,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            ShimmerEffect(
              width: TDeviceUtils.getScreenWidth(context) / 1.4,
              height: 20,
            ),
          ],
        ),
      ),
      // ),
    );
  }
}

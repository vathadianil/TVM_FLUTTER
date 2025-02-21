import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';

class CardLayoutShimmer extends StatelessWidget {
  const CardLayoutShimmer({
    super.key,
    required this.cardHeight,
  });

  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: screenWidth * .025,
      ),
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.md),
        boxShadow: [
          BoxShadow(
            blurRadius: TSizes.md,
            color: THelperFunctions.isDarkMode(context)
                ? TColors.accent
                : TColors.darkGrey,
          )
        ],
      ),
      child: Column(
        children: [
          ShimmerEffect(
            height: cardHeight,
            width: double.infinity,
            color: THelperFunctions.isDarkMode(context)
                ? TColors.dark
                : TColors.light,
          ),
        ],
      ),
    );
  }
}

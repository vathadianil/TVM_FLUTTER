import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';

class CardHiistroyShimmer extends StatelessWidget {
  const CardHiistroyShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ShimmerEffect(
          width: double.infinity,
          height: screenWidth * .3,
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: TSizes.spaceBtwItems,
        );
      },
      itemCount: 2,
    );
  }
}

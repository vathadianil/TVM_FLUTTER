import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';

class QrShimmerContainer extends StatelessWidget {
  const QrShimmerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.md),
        border: Border.all(
          width: 1,
          color: TColors.grey,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerEffect(
                width: TDeviceUtils.getScreenWidth(context) * .2,
                height: 30,
                radius: 30,
              ),
              ShimmerEffect(
                width: TDeviceUtils.getScreenWidth(context) * .2,
                height: 30,
                radius: 30,
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.defaultSpace / 2,
          ),
          const ShimmerEffect(
            width: double.infinity,
            height: 10,
            radius: 10,
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          const ShimmerEffect(
            width: double.infinity,
            height: 35,
            radius: 10,
          ),
        ],
      ),
    );
  }
}

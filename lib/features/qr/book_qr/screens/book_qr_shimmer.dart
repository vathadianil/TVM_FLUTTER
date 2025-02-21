import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';

class BookQrShimmer extends StatelessWidget {
  const BookQrShimmer({super.key});

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
                width: TDeviceUtils.getScreenWidth(context) * .3,
                height: 30,
                radius: 30,
              ),
              ShimmerEffect(
                width: TDeviceUtils.getScreenWidth(context) * .1,
                height: 30,
                radius: 30,
              ),
              ShimmerEffect(
                width: TDeviceUtils.getScreenWidth(context) * .3,
                height: 30,
                radius: 30,
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.defaultSpace,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerEffect(
                width: TDeviceUtils.getScreenWidth(context) * .1,
                height: 30,
                radius: 30,
              ),
              ShimmerEffect(
                width: TDeviceUtils.getScreenWidth(context) * .2,
                height: 30,
                radius: 30,
              ),
              ShimmerEffect(
                width: TDeviceUtils.getScreenWidth(context) * .4,
                height: 30,
                radius: 30,
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.defaultSpace,
          ),
          const ShimmerEffect(
            width: double.infinity,
            height: 50,
            radius: 10,
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          const ShimmerEffect(
            width: double.infinity,
            height: 50,
            radius: 10,
          ),
        ],
      ),
    );
  }
}

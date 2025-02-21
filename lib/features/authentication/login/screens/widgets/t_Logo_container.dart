import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class TLogoContainer extends StatelessWidget {
  const TLogoContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      left: TDeviceUtils.getScreenWidth(context) / 2,
      child: Container(
        decoration: BoxDecoration(
          color: TColors.white,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: TColors.white, width: TSizes.sm),
        ),
        child: const Image(
          image: AssetImage(TImages.appLogo),
          width: 150,
        ),
      ),
    );
  }
}

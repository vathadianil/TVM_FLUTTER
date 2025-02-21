import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class FloatingActionBtn extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;

  const FloatingActionBtn({
    super.key,
    this.backgroundColor = TColors.primary, 
    this.iconColor = TColors.white, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: TSizes.appBarHeight / 2),
      child: SizedBox(
        width: 36,
        height: 36,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              Get.back();
            },
            backgroundColor: backgroundColor,
            shape: const CircleBorder(),
            child: Icon(
              Iconsax.arrow_left,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class NeedHelpButton extends StatelessWidget {
  const NeedHelpButton({super.key, required this.onPressed});
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: TColors.white),
        minimumSize: Size(screenWidth * .3, screenWidth * .08),
        padding: const EdgeInsets.symmetric(
          horizontal: TSizes.sm,
          vertical: 0,
        ),
      ),
      child: Text(
        'Need Help ?',
        textScaler: TextScaleUtil.getScaledText(context, maxScale: 3),
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(color: TColors.white),
      ),
    );
  }
}

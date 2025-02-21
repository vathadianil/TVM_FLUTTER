import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class AddCard extends StatelessWidget {
  const AddCard({super.key, required this.onPressed});
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: isDark ? TColors.dark : TColors.white,
        side: BorderSide(
          color: isDark ? TColors.accent : TColors.primary,
        ),
        elevation: TSizes.sm,
        shadowColor: isDark ? TColors.accent : TColors.darkGrey,
        minimumSize: Size(screenWidth * .1, screenWidth * .05),
        padding: const EdgeInsets.symmetric(
          vertical: TSizes.xs,
          horizontal: TSizes.md,
        ),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            Iconsax.card_add,
            color: THelperFunctions.isDarkMode(context)
                ? TColors.accent
                : TColors.primary,
            size: screenWidth * .04,
          ),
          SizedBox(
            width: screenWidth * .02,
          ),
          Text(
            'Add Card',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}

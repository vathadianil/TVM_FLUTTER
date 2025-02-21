import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String content;
  final String date;
  final Color? backgroundColor;
  final Color? sideColor;

  const NotificationCard({
    super.key,
    required this.title,
    required this.content,
    required this.date,
    this.backgroundColor,
    this.sideColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final screenHeight = TDeviceUtils.getScreenHeight();

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: backgroundColor ??
                (isDark ? TColors.darkerGrey : TColors.primary.withOpacity(.1)),
            borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
          ),
          margin: const EdgeInsets.symmetric(
            vertical: TSizes.sm,
          ),
          padding: EdgeInsets.only(left: screenWidth * 0.01),
          child: Padding(
            padding: const EdgeInsets.all(TSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(title,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                    // Icon(
                    //   Icons.close,
                    //   color: AppColors.lightGreyColor,
                    //   size: SizeConfig.blockSizeHorizontal * 5,
                    // ),
                    CircleAvatar(
                      radius: screenWidth * .03,
                      backgroundColor: TColors.white,
                      backgroundImage: const AssetImage(TImages.appLogo),
                    ),
                  ],
                ),
                const SizedBox(
                  height: TSizes.sm,
                ),
                Text(
                  content,
                  style: Theme.of(context).textTheme.labelLarge,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: TSizes.sm,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    date,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: isDark ? TColors.accent : TColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Side color container
        Positioned(
          left: 0,
          top: screenHeight * 0.016,
          bottom: screenHeight * 0.016,
          child: Container(
            width: 5,
            decoration: BoxDecoration(
              color: sideColor ?? TColors.info,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(TSizes.borderRadiusLg),
                  bottomLeft: Radius.circular(TSizes.borderRadiusLg)),
            ),
          ),
        ),
      ],
    );
  }
}

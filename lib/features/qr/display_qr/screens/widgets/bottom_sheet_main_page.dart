import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/bottom_sheet_pageview_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class BottomSheetMainPage extends StatelessWidget {
  const BottomSheetMainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          TTexts.hereToHelp,
          textScaler: TextScaleUtil.getScaledText(context),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(
          height: screenWidth * .05,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: THelperFunctions.isDarkMode(context)
                  ? TColors.accent
                  : TColors.primary,
            ),
            borderRadius: BorderRadius.circular(
              TSizes.md,
            ),
          ),
          child: ListTile(
            onTap: () {
              BottomSheetPageViewController.instace
                  .changeDesitinationPage(context);
            },
            leading: Icon(
              Iconsax.location,
              color: THelperFunctions.isDarkMode(context)
                  ? TColors.accent
                  : TColors.primary,
            ),
            title: Text(
              TTexts.changeDest,
              textScaler: TextScaleUtil.getScaledText(context),
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: THelperFunctions.isDarkMode(context)
                      ? TColors.accent
                      : TColors.primary),
            ),
            subtitle: Text(
              TTexts.changeDestDesc,
              textScaler: TextScaleUtil.getScaledText(context, maxScale: 2.5),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
        SizedBox(
          height: screenWidth * .04,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: TColors.error),
            borderRadius: BorderRadius.circular(TSizes.md),
          ),
          child: ListTile(
            onTap: () {
              BottomSheetPageViewController.instace.refundPage(context);
            },
            leading: const Icon(
              Iconsax.ticket,
              color: TColors.error,
            ),
            title: Text(
              TTexts.cancelTicket,
              textScaler: TextScaleUtil.getScaledText(context),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: TColors.error),
            ),
            subtitle: Text(
              TTexts.cancelTicketDesc,
              textScaler: TextScaleUtil.getScaledText(context, maxScale: 2.5),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tsavaari/features/card_reacharge/controllers/metro_card_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class DeleteCardPopup extends StatelessWidget {
  const DeleteCardPopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = MetroCardController.instance;
    return Dialog(
      backgroundColor: isDark ? TColors.dark : TColors.white,
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Are you sure want to Delete the Card?'),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.error,
                    side: const BorderSide(color: TColors.error),
                    minimumSize: Size(screenWidth * .1, screenWidth * .06),
                    padding: const EdgeInsets.symmetric(
                      vertical: TSizes.xs,
                      horizontal: TSizes.lg,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No'),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(screenWidth * .1, screenWidth * .06),
                    padding: const EdgeInsets.symmetric(
                      vertical: TSizes.xs,
                      horizontal: TSizes.lg,
                    ),
                  ),
                  onPressed: () {
                    controller.deleteCardDetailsByUser();
                  },
                  child: const Text('Yes'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/book_qr_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class TicketCountSelection extends StatelessWidget {
  const TicketCountSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = BookQrController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Iconsax.people5,
              color: dark ? TColors.accent : TColors.primary,
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems / 2,
            ),
            Text(TTexts.passengers,
                textScaler: TextScaleUtil.getScaledText(context, maxScale: 3),
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
        Obx(
          () => Row(
            children: [
              ElevatedButton(
                onPressed: controller.passengerCount.value <= 1
                    ? null
                    : () {
                        controller.passengerCount.value--;
                      },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  minimumSize: Size(screenWidth * .08, screenWidth * .08),
                ),
                child: Icon(
                  Iconsax.minus,
                  size: screenWidth * .06,
                ),
              ),
              SizedBox(
                width: screenWidth * 0.03,
              ),
              Text(controller.passengerCount.value.toString(),
                  textScaler: TextScaleUtil.getScaledText(context, maxScale: 3),
                  style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(
                width: screenWidth * 0.03,
              ),
              ElevatedButton(
                onPressed: controller.passengerCount.value >= 6
                    ? () {
                        TLoaders.errorSnackBar(title: 'Maximum 6 Only', message: 'Max 6 passengers allowed');
                      }
                    : () {
                        controller.passengerCount.value++;
                      },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  minimumSize: Size(screenWidth * .08, screenWidth * .08),
                ),
                child: Icon(
                  Iconsax.add,
                  size: screenWidth * .06,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

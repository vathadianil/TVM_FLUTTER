import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class DatePickerHelper {
  static void showDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required ValueChanged<DateTime> onDateSelected,
    required void Function()? onPressedSave
  }) {
    final dark = THelperFunctions.isDarkMode(context);
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: screenWidth * 0.8,
        color: dark ? TColors.dark : TColors.white,
        child: Column(
          children: [
            Container(
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: Text(
                      'Cancel',
                      textScaler: TextScaleUtil.getScaledText(context),
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(
                              fontWeight: FontWeight.w600,
                              color: TColors.primary),
                    ),
                    onPressed: () => Get.back(),
                  ),
                  CupertinoButton(
                    onPressed: onPressedSave,
                    child: Text(
                      'Save',
                      textScaler: TextScaleUtil.getScaledText(context),
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(
                            fontWeight: FontWeight.w600,
                            color: TColors.primary),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                initialDateTime: initialDate,
                maximumDate: DateTime.now(),
                maximumYear: 2025,
                minimumYear: 1900,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: onDateSelected,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

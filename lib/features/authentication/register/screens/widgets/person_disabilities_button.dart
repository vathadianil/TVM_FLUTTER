import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/authentication/register/controllers/registration_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class PersonWithDisabilitiesSelectionButton extends StatelessWidget {
  const PersonWithDisabilitiesSelectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =  RegistrationController.instance;
    final screenWidth = TDeviceUtils.getScreenWidth(context);

    // Initialize default value to 'No' if not already set
    if (controller.selectedPersonWithDisabilities.value.isEmpty) {
      controller.setPersonWithDisabilities('No');
    }
    
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Are you Person with Disabilities', 
          textScaler: TextScaleUtil.getScaledText(Get.context!),
          style: Theme.of(Get.context!)
              .textTheme
              .labelLarge!
              .copyWith(
                  fontWeight: FontWeight.w500,
                  color: TColors.darkGrey)
        ),
        const SizedBox(height: TSizes.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => controller.setPersonWithDisabilities('Yes'),
              child: _selectionButton(
                  'Yes', controller.selectedPersonWithDisabilities.value == 'Yes'),
            ),
            SizedBox(width:  screenWidth * .05),
            GestureDetector(
              onTap: () => controller.setPersonWithDisabilities('No'),
              child: _selectionButton(
                  'No', controller.selectedPersonWithDisabilities.value == 'No'),
            ),
          ],
        ),
      ],
    ));
  }

  Widget _selectionButton(String label, bool isSelected) {
    final screenWidth = TDeviceUtils.getScreenWidth(Get.context!);
    return Container(
      height: screenWidth * .1,
      width: screenWidth * .3,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * .03),
      decoration: BoxDecoration(
        color: isSelected ? TColors.primary : TColors.grey,
        //border: Border.all(color: TColors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            label == 'Yes' ? Icons.accessible  : Icons.not_accessible_outlined,
            color: isSelected ? Colors.white : TColors.primary,
            size: screenWidth * .06,
          ),
          SizedBox(width: screenWidth  * .03),
          Text(
            label, 
            textScaler: TextScaleUtil.getScaledText(Get.context!),
            style: Theme.of(Get.context!)
                .textTheme
                .labelLarge!
                .copyWith(
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.black)
          ),
        ],
      ),
    );
  }
}
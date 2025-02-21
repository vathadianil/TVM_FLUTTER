import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/authentication/register/controllers/registration_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class GenderSelectionButton extends StatelessWidget {
  const GenderSelectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =  RegistrationController.instance;
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender', 
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
              onTap: () => controller.setGender('Male'),
              child: _genderButton('Male', controller.selectedGender.value == 'Male'),
            ),
            SizedBox(width:  screenWidth * .05),
            GestureDetector(
              onTap: () => controller.setGender('Female'),
              child: _genderButton('Female', controller.selectedGender.value == 'Female'),
            ),
          ],
        ),
      ],
    ));
  }

  Widget _genderButton(String label, bool isSelected) {
    final screenWidth = TDeviceUtils.getScreenWidth(Get.context!);
    return Container(
      height: screenWidth * .1,
      width: screenWidth * .3,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * .02),
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
            label == 'Male' ? Icons.man_outlined : Icons.woman_2_rounded,
            color: isSelected ? Colors.white : TColors.primary,
            size: screenWidth * .065,
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/components/date_picker_helper.dart.dart';
import 'package:tsavaari/features/authentication/register/controllers/registration_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class DateOfBirthField extends StatelessWidget {
  const DateOfBirthField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =  RegistrationController.instance;
    final textScaler = TextScaleUtil.getScaledText(context);
    final screenWidth = TDeviceUtils.getScreenWidth(Get.context!);
    
    return GestureDetector(
      onTap: () {
        DatePickerHelper.showDatePicker(
          context: Get.context!,
          initialDate: controller.selectedDate.value,
          onDateSelected: controller.setDate,
          onPressedSave: () {
            controller.dobController.text =
                "${controller.selectedDate.value.day.toString().padLeft(2, '0')}-${controller.selectedDate.value.month.toString().padLeft(2, '0')}-${controller.selectedDate.value.year}";
            Get.back();
          },
        );
      },
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            label: Text(
              'Date Of Birth',
              style: Theme.of(context).textTheme.bodyMedium,
              textScaler: textScaler,
            ),
            prefixIcon: const Icon(
              Icons.calendar_month_outlined,
              color: TColors.primary,
            ),
            suffixIcon: Icon(Icons.arrow_drop_down, size: screenWidth * .05),
          ),
          keyboardType: TextInputType.datetime,
          validator: (value) => value == null || value.isEmpty ? 'Please enter your date of birth' : null,
          controller: controller.dobController, 
        ),
      )
    );
  }

}
import 'package:flutter/material.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class CustomTextField extends StatelessWidget {
  final int? maxLines;
  final String? hintText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  
  const CustomTextField({
    super.key, 
    this.maxLines = 1, 
    this.hintText, 
    this.keyboardType, 
    this.maxLength,
    this.controller, 
    this.validator 
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = TDeviceUtils.getScreenHeight();
    final screenWidth = TDeviceUtils.getScreenWidth(context);

    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(fontWeight: FontWeight.w400),
        contentPadding: EdgeInsets.symmetric(
          vertical: screenHeight * .02,
          horizontal:screenWidth * .04,
        ),
        counterText: "", // Hides the length indicator
      ),
      style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.w400),
      validator: validator,
    );
  }
}

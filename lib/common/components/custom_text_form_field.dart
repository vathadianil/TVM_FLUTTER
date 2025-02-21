import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextInputType keyboardType;
  final TextStyle? textStyle;
  final BorderSide? enabledBorderSide;
  final BorderSide? focusedBorderSide;
  final Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final TextEditingController? controller;
  final Widget? suffixIcon; 
  final bool enabled; 
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.textStyle,
    this.enabledBorderSide,
    this.focusedBorderSide,
    this.onChanged,
    this.validator,
    this.maxLength,
    this.controller,
    this.suffixIcon,
    this.enabled = true, 
    this.inputFormatters, 
    this.maxLines = 1, 
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = TDeviceUtils.getScreenHeight();
    final screenWidth = TDeviceUtils.getScreenWidth(context);

    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        label: Text(
          labelText,
          style: Theme.of(context)
          .textTheme
          .labelLarge!
          .copyWith(fontWeight: FontWeight.w400),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: screenHeight * .02,
          horizontal:screenWidth * .04,
        ),
        counterText: "", // Hides the character counter text
        suffixIcon: suffixIcon,
      ),
      keyboardType: keyboardType,
      style: enabled
          ? textStyle ?? Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w400)
          : Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(
                  color: TColors.darkGrey,
                  fontWeight: FontWeight.w400), // Use disabled text style
      onChanged: onChanged,
      validator: validator,
      maxLength: maxLength,
      enabled: enabled,
      inputFormatters: inputFormatters,
    );
  }

}

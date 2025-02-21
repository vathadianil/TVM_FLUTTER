import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class CustomDropdown extends StatelessWidget {
  final String labelText;
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final void Function(String?)? onChanged;
  final TextStyle? labelStyle;
  final BorderSide? enabledBorderSide;
  final BorderSide? focusedBorderSide;
  final Color? iconColor;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;   
  final bool enabled; 
  final EdgeInsetsGeometry? contentPadding; 
  final bool isDense;

  const CustomDropdown({
    super.key,
    required this.labelText,
    required this.items,
    required this.value,
    required this.onChanged,
    this.labelStyle,
    this.enabledBorderSide,
    this.focusedBorderSide,
    this.iconColor,
    this.validator, 
    this.suffixIcon, 
    this.prefixIcon, 
    this.enabled = true, 
    this.contentPadding,
    this.isDense = false,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final textScaler = TextScaleUtil.getScaledText(context);
    final screenWidth = TDeviceUtils.getScreenWidth(context);

    final textColor = enabled 
        ? Theme.of(context).textTheme.bodyLarge!.color 
        : dark ? TColors.darkGrey : TColors.grey;

    
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        label: Text(
          labelText,
          textScaler: textScaler,
          style: labelStyle ?? 
                      Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.w400),
        ),
        enabled: enabled,
        contentPadding: contentPadding,
        counterText: "", // Hides the character counter text
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        isDense: isDense, 
      ),
      value: value,
      items: items,
      onChanged: onChanged,
      style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.w400,
            color: textColor,
          ),
      iconEnabledColor: dark ? TColors.accent : TColors.primary,
      iconSize: screenWidth * .05,
      validator: validator, 
    );
  }
}

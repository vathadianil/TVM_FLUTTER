import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class UnderLinedTextButton extends StatelessWidget {
  const UnderLinedTextButton(
      {super.key, required this.btnText, required this.onPressed});

  final String btnText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TextButton(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: dark ? TColors.accent : TColors.primary, width: 1),
          ),
        ),
        child: Text(
          btnText,
          textScaler: TextScaleUtil.getScaledText(context, maxScale: 2.5),
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: dark ? TColors.accent : TColors.primary,
              ),
        ),
      ),
    );
  }
}

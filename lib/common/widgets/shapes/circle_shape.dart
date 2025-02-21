import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class CircleShape extends StatelessWidget {
  const CircleShape({
    super.key,
    this.lightModeBorderColor = TColors.darkerGrey,
    this.darkModeBorderColor = TColors.light,
    this.fillColor = Colors.transparent,
    this.width = 15,
    this.height = 15,
    this.borderWidth = 1.5,
  });

  final Color lightModeBorderColor;
  final Color darkModeBorderColor;
  final Color fillColor;
  final double width;
  final double height;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: fillColor,
          border: Border.all(
              width: borderWidth,
              color: dark ? darkModeBorderColor : lightModeBorderColor),
          borderRadius: BorderRadius.circular(100)),
    );
  }
}

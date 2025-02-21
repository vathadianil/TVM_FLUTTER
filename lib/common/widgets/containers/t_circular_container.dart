import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class TCircularContainer extends StatelessWidget {
  const TCircularContainer({
    super.key,
    this.width = 400,
    this.height,
    this.radius = 400,
    this.padding = 0,
    this.margin = const EdgeInsets.all(0),
    this.child,
    this.backgroundColor = TColors.white,
    this.boxShadowColor,
    this.applyBoxShadow = false,
    this.blurRadius = TSizes.sm,
    this.spreadRadius = 0,
    this.boxShadow = const [],
  });
  final double? width;
  final double? height;
  final double? radius;
  final double? padding;
  final EdgeInsets? margin;
  final Widget? child;
  final Color? backgroundColor;
  final Color? boxShadowColor;
  final bool applyBoxShadow;
  final double blurRadius;
  final double spreadRadius;
  final List<BoxShadow> boxShadow;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.all(padding!),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius!),
        color: backgroundColor,
        boxShadow: applyBoxShadow
            ? (boxShadow.isEmpty)
                ? [
                    BoxShadow(
                      color: boxShadowColor != null
                          ? boxShadowColor!
                          : TColors.accent,
                      blurRadius: TSizes.sm,
                      spreadRadius: spreadRadius,
                      offset: const Offset(0, 0),
                    ),
                  ]
                : boxShadow
            : [],
      ),
      child: child,
    );
  }
}
    // BoxShadow(
    //               color: Colors.red,
    //               blurRadius: TSizes.sm,
    //               spreadRadius: spreadRadius,
    //               offset: Offset(0, 4),
    //             )
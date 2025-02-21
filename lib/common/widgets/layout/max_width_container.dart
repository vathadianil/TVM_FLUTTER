import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class MaxWidthContaiiner extends StatelessWidget {
  const MaxWidthContaiiner(
      {super.key,
      required this.child,
      this.maxWidth = TSizes.mediumScreenSize});
  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: child,
    );
  }
}

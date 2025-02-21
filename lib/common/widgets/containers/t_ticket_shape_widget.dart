import 'package:flutter/material.dart';
import 'package:tsavaari/common/widgets/containers/t_ticket_shape_clipper.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class TTicketShapeWidget extends StatelessWidget {
  const TTicketShapeWidget({
    super.key,
    this.child,
    this.backgroundColor = TColors.white,
  });

  final Widget? child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return PhysicalModel(
      color:
          isDark ? TColors.dark.withOpacity(.5) : TColors.grey.withOpacity(.01),
      shape: BoxShape.rectangle,
      elevation: TSizes.sm,
      shadowColor: isDark ? TColors.white.withOpacity(.2) : TColors.grey,
      borderRadius: BorderRadius.circular(TSizes.md),
      child: ClipPath(
        clipper: TicketShapeClipper(),
        child: Container(
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(TSizes.md)),
          padding: const EdgeInsets.all(
            TSizes.defaultSpace,
          ),
          child: child,
        ),
      ),
    );
  }
}

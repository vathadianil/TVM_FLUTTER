import 'package:flutter/material.dart';
import 'package:tsavaari/common/widgets/containers/t_ticket_shape_widget.dart';
import 'package:tsavaari/common/widgets/shapes/dashed_horizontal_line.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';

class MyOrdersShimmer extends StatelessWidget {
  const MyOrdersShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TTicketShapeWidget(
      backgroundColor:
          THelperFunctions.isDarkMode(context) ? TColors.dark : TColors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const ShimmerEffect(width: double.infinity, height: 50),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          const DashedHorizontalLine(
            color: TColors.darkGrey,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerEffect(
                width: TDeviceUtils.getScreenWidth(context) * .2,
                height: 50,
                radius: 10,
              ),
              ShimmerEffect(
                width: TDeviceUtils.getScreenWidth(context) * .2,
                height: 50,
                radius: 10,
              ),
              ShimmerEffect(
                width: TDeviceUtils.getScreenWidth(context) * .2,
                height: 50,
                radius: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

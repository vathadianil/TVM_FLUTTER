import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/common/widgets/button/custom_elevated_btn.dart';
import 'package:tsavaari/common/widgets/shapes/circle_shape.dart';
import 'package:tsavaari/common/widgets/shapes/dashed_horizontal_line.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/book_qr_controller.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/station_list_controller.dart';
import 'package:tsavaari/routes/routes.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class FareDisplayContainer extends StatelessWidget {
  const FareDisplayContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final stationListController = StationListController.instance;
    final controller = BookQrController.instance;
    final fromStation = THelperFunctions.getStationFromStationName(
        controller.fareCalculationData.first.routeDetails!.fromStationName!,
        stationListController.stationList);
    final toStation = THelperFunctions.getStationFromStationName(
        controller.fareCalculationData.first.routeDetails!.toStationName!,
        stationListController.stationList);
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    return PhysicalModel(
      color:
          isDark ? TColors.dark.withOpacity(.5) : TColors.grey.withOpacity(.01),
      shape: BoxShape.rectangle,
      elevation: TSizes.sm,
      shadowColor: isDark ? TColors.white.withOpacity(.2) : TColors.grey,
      borderRadius: BorderRadius.circular(TSizes.md),
      // child: TTicketShapeWidget(
      child: Container(
        decoration: BoxDecoration(
            color: isDark ? TColors.darkerGrey : TColors.white,
            borderRadius: BorderRadius.circular(TSizes.md)),
        padding: const EdgeInsets.all(
          TSizes.defaultSpace,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  fromStation.shortName ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: getColor(fromStation.corridorColor!)),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems / 2,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Iconsax.clock,
                          size: TSizes.iconSm,
                        ),
                        const SizedBox(width: TSizes.spaceBtwItems / 4),
                        Text(
                          '${controller.fareCalculationData.first.routeDetails!.time ?? ''} Min',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleShape(
                          width: 10,
                          height: 10,
                          fillColor: isDark ? TColors.darkGrey : TColors.white,
                          darkModeBorderColor: TColors.grey,
                          lightModeBorderColor: TColors.grey,
                        ),
                        SizedBox(
                          width: screenWidth * .04,
                          child: Divider(
                            endIndent: screenWidth * .01,
                            color: TColors.borderPrimary,
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * .2,
                          child: const Divider(
                            color: TColors.borderPrimary,
                          ),
                        ),
                        const Icon(
                          Iconsax.arrow_right_1,
                          color: TColors.borderPrimary,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Iconsax.location,
                          size: TSizes.iconSm,
                        ),
                        const SizedBox(
                          width: TSizes.spaceBtwItems / 4,
                        ),
                        Text(
                          '${controller.fareCalculationData.first.routeDetails!.distance ?? ''} Km',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems / 2,
                ),
                Text(
                  toStation.shortName ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: getColor(toStation.corridorColor!)),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            const DashedHorizontalLine(
              color: TColors.grey,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fare',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  '\u{20B9}${controller.fareCalculationData.first.routeDetails!.fare ?? ''}/-',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            CustomElevatedBtn(
              onPressed: () {
                controller.source.value =  controller.fareCalculationData.first
                            .routeDetails!.fromStationName!;
                controller.destination.value = controller.fareCalculationData.first
                            .routeDetails!.toStationName!;
                controller.getFare();
                Get.toNamed(Routes.bookQr);
              },
              child: const Text('Book Ticket'),
            )
          ],
        ),
      ),
      // ),
    );
  }

  Color getColor(String color) {
    if (color == 'Red') {
      return TColors.error;
    } else if (color == 'Blue') {
      return TColors.primary;
    } else if (color == 'Green') {
      return TColors.success;
    }
    return Colors.transparent;
  }
}

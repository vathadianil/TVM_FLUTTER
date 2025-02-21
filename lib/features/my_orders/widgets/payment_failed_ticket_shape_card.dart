import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tsavaari/common/controllers/button_tabbar_controller.dart';
import 'package:tsavaari/common/widgets/containers/t_ticket_shape_widget.dart';
import 'package:tsavaari/common/widgets/shapes/circle_shape.dart';
import 'package:tsavaari/common/widgets/shapes/dashed_horizontal_line.dart';
import 'package:tsavaari/features/my_orders/widgets/payment_failed_stepper.dart';
import 'package:tsavaari/features/my_orders/widgets/ticket_status.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/features/qr/display_qr/models/payment_failed_ticket_model.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class PaymentFailedTicketShapeCard extends StatelessWidget {
  const PaymentFailedTicketShapeCard(
      {super.key,
      required this.paymentFailedData,
      required this.onTap,
      required this.stationList});

  final PaymentFailedData paymentFailedData;
  final List<StationListModel> stationList;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final tabController = ButtonTabbarController.instance;
    final screenWidth = TDeviceUtils.getScreenWidth(context);

    return InkWell(
      onTap: onTap,
      child: TTicketShapeWidget(
        backgroundColor: isDark ? TColors.dark.withOpacity(.7) : TColors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: screenWidth * .7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (paymentFailedData.fromStationId != null)
                    Text(
                      THelperFunctions.getStationFromStationId(
                                  paymentFailedData.fromStationId!, stationList)
                              .shortName ??
                          '',
                      textScaler: TextScaleUtil.getScaledText(context),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  if (paymentFailedData.purchaseDatetime != null)
                    Text(
                      paymentFailedData.purchaseDatetime!.split(' ')[0],
                      textScaler:
                          TextScaleUtil.getScaledText(context, maxScale: 3),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  if (paymentFailedData.toStationId != null)
                    Text(
                      THelperFunctions.getStationFromStationId(
                                  paymentFailedData.toStationId!, stationList)
                              .shortName ??
                          '',
                      textScaler: TextScaleUtil.getScaledText(context),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.sm,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleShape(
                  width: TSizes.sm,
                  height: TSizes.sm,
                  darkModeBorderColor: TColors.accent,
                  lightModeBorderColor: TColors.primary,
                  fillColor: isDark ? TColors.accent : TColors.primary,
                ),
                SizedBox(
                    width: screenWidth * .25,
                    child: DashedHorizontalLine(
                      dashWidth: 4,
                      color: isDark ? TColors.accent : TColors.primary,
                    )),
                Icon(
                  Icons.train,
                  color: isDark ? TColors.accent : TColors.primary,
                ),
                SizedBox(
                    width: screenWidth * .25,
                    child: DashedHorizontalLine(
                      dashWidth: 4,
                      color: isDark ? TColors.accent : TColors.primary,
                    )),
                CircleShape(
                  width: TSizes.sm,
                  height: TSizes.sm,
                  darkModeBorderColor: TColors.accent,
                  lightModeBorderColor: TColors.primary,
                  fillColor: isDark ? TColors.accent : TColors.primary,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenWidth * .2,
                  child: Text(
                    THelperFunctions.getStationFromStationId(
                                paymentFailedData.fromStationId!, stationList)
                            .name ??
                        '',
                    textScaler:
                        TextScaleUtil.getScaledText(context, maxScale: 3),
                    style: Theme.of(context).textTheme.bodyLarge!,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: screenWidth * .1,
                ),
                if (paymentFailedData.purchaseDatetime != null)
                  Text(
                    paymentFailedData.purchaseDatetime!.split(' ')[1],
                    textScaler:
                        TextScaleUtil.getScaledText(context, maxScale: 3),
                    style: Theme.of(context).textTheme.labelSmall!,
                  ),
                SizedBox(
                  width: screenWidth * .1,
                ),
                SizedBox(
                  width: screenWidth * .18,
                  child: Text(
                    THelperFunctions.getStationFromStationId(
                                paymentFailedData.toStationId!, stationList)
                            .name ??
                        '',
                    textScaler:
                        TextScaleUtil.getScaledText(context, maxScale: 3),
                    style: Theme.of(context).textTheme.bodyLarge!,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    if (paymentFailedData.noOfTickets != null)
                      Text(
                        TTexts.passengers,
                        textScaler:
                            TextScaleUtil.getScaledText(context, maxScale: 3),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    if (paymentFailedData.noOfTickets != null)
                      Text(
                        '${paymentFailedData.noOfTickets} ${TTexts.adults}',
                        textScaler:
                            TextScaleUtil.getScaledText(context, maxScale: 3),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    OutlinedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => Wrap(
                            children: [
                              PaymentFailedStepper(
                                  paymentFailedData: paymentFailedData),
                            ],
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: TColors.white,
                        side: const BorderSide(
                          color: TColors.primary,
                        ),
                        elevation: TSizes.sm,
                        shadowColor: TColors.accent,
                        minimumSize: Size(screenWidth * .1, screenWidth * .05),
                        padding: const EdgeInsets.symmetric(
                          vertical: TSizes.xs,
                          horizontal: TSizes.md,
                        ),
                      ),
                      child: Text(
                        'View Details',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: TColors.primary,
                            ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      TTexts.totalFare,
                      textScaler:
                          TextScaleUtil.getScaledText(context, maxScale: 3),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    if (paymentFailedData.merchantTotalFareAfterGst != 'null')
                      Text(
                        '${paymentFailedData.merchantTotalFareAfterGst}/-',
                        textScaler:
                            TextScaleUtil.getScaledText(context, maxScale: 3),
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    else
                      Text(
                        '${paymentFailedData.refundAmount}/-',
                        textScaler:
                            TextScaleUtil.getScaledText(context, maxScale: 3),
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                  ],
                ),
                SizedBox(
                  width: screenWidth * .2,
                  child: LayoutBuilder(
                    builder: (context, constraints) => Stack(
                      children: [
                        QrImageView(
                          data: 'https://www.ltmetro.com',
                          version: QrVersions.auto,
                          eyeStyle: QrEyeStyle(
                            color: tabController.tabIndex.value == 1
                                ? TColors.darkGrey
                                : isDark
                                    ? TColors.light
                                    : TColors.dark,
                            eyeShape: QrEyeShape.square,
                          ),
                          dataModuleStyle: QrDataModuleStyle(
                            color: tabController.tabIndex.value == 1
                                ? TColors.darkGrey
                                : isDark
                                    ? TColors.light
                                    : TColors.dark,
                          ),
                        ),
                        TicketStatusChip(
                          left: 0,
                          bottom: (paymentFailedData.failureCode ==
                                      'payment_failed' ||
                                  paymentFailedData.failureCode ==
                                      'action_cancelled')
                              ? constraints.maxWidth * .3
                              : constraints.maxWidth * .35,
                          ticketStatus: (paymentFailedData.failureCode ==
                                      'payment_failed' ||
                                  paymentFailedData.failureCode ==
                                      'action_cancelled')
                              ? 'Payment Failed'
                              : 'Cancelled',
                          consttrains: constraints,
                          textColor: TColors.error,
                          borderColor: TColors.error,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tsavaari/common/controllers/button_tabbar_controller.dart';
import 'package:tsavaari/common/widgets/containers/t_ticket_shape_widget.dart';
import 'package:tsavaari/common/widgets/shapes/circle_shape.dart';
import 'package:tsavaari/common/widgets/shapes/dashed_horizontal_line.dart';
import 'package:tsavaari/features/my_orders/widgets/ticket_status.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/book_qr_controller.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/features/app_rating/rating_bottom_sheet.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/constants/ticket_status_codes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/routes/routes.dart';

class MyOrdersTicketShapeCard extends StatelessWidget {
  const MyOrdersTicketShapeCard(
      {super.key,
      required this.ticketData,
      required this.onTap,
      required this.stationList});

  final TicketHistory ticketData;
  final List<StationListModel> stationList;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final tabController = ButtonTabbarController.instance;
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final bookQrController = BookQrController.instance;

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
                  if (ticketData.fromStation != null)
                    Text(
                      THelperFunctions.getStationFromStationName(
                                  ticketData.fromStation!, stationList)
                              .shortName ??
                          '',
                      textScaler: TextScaleUtil.getScaledText(context),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  Text(
                    ticketData.purchaseDate!,
                    textScaler:
                        TextScaleUtil.getScaledText(context, maxScale: 3),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  if (ticketData.toStation != null)
                    Text(
                      THelperFunctions.getStationFromStationName(
                                  ticketData.toStation!, stationList)
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
                    ticketData.fromStation ?? '',
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
                Text(
                  ticketData.purchaseTime!,
                  textScaler: TextScaleUtil.getScaledText(context, maxScale: 3),
                  style: Theme.of(context).textTheme.labelSmall!,
                ),
                SizedBox(
                  width: screenWidth * .1,
                ),
                SizedBox(
                  width: screenWidth * .18,
                  child: Text(
                    ticketData.toStation ?? '',
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
                    Text(
                      TTexts.passengers,
                      textScaler:
                          TextScaleUtil.getScaledText(context, maxScale: 3),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),

                    Text(
                      '${ticketData.tickets![0].ticketType == TicketStatusCodes.ticketTypeRjtString ? (ticketData.tickets!.length / 2).toStringAsFixed(0) : ticketData.tickets!.length} ${TTexts.adults}',
                      textScaler:
                          TextScaleUtil.getScaledText(context, maxScale: 3),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    const SizedBox(
                      height: TSizes.sm,
                    ),

                    //--- App Rating Status & BottomSheet..
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            5,
                            (index) => GestureDetector(
                              onTap: ticketData.tickets?.first.ratings == null
                                  ? () {
                                      showModalBottomSheet(
                                        context: context,
                                        showDragHandle: false,
                                        isScrollControlled: true,
                                        isDismissible: false,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20.0),
                                          ),
                                        ),
                                        builder: (context) => RatingBottomSheet(
                                          orderId:
                                              ticketData.tickets!.first.orderID,
                                        ),
                                      );
                                    }
                                  : null,
                              child: Icon(
                                index <
                                        (ticketData.tickets?.first.ratings
                                                ?.rating ??
                                            0)
                                    ? Icons.star
                                    : Icons.star_border,
                                color: TColors.secondary,
                                size: screenWidth * 0.045,
                              ),
                            ),
                          ),
                        ),
                      ],
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
                    Text(
                      '${(double.parse(ticketData.tickets![0].finalCost!) * (ticketData.tickets!.length))}/-',
                      textScaler:
                          TextScaleUtil.getScaledText(context, maxScale: 3),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
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
                        if (ticketData.tickets![0].statusId ==
                            TicketStatusCodes.newTicket)
                          TicketStatusChip(
                            left: 0,
                            bottom: constraints.maxWidth * .4,
                            ticketStatus: 'New',
                            consttrains: constraints,
                          ),
                        if (ticketData.tickets![0].statusId ==
                            TicketStatusCodes.expired)
                          TicketStatusChip(
                            left: 0,
                            bottom: constraints.maxWidth * .4,
                            ticketStatus: 'Expired',
                            borderColor: TColors.error,
                            textColor: TColors.error,
                            consttrains: constraints,
                          ),
                        if (ticketData.tickets![0].statusId ==
                            TicketStatusCodes.entryUsed)
                          TicketStatusChip(
                            left: 0,
                            bottom: constraints.maxWidth * .4,
                            textColor: TColors.secondary,
                            borderColor: TColors.secondary,
                            backgroundColor: TColors.dark,
                            ticketStatus: 'In Transit',
                            consttrains: constraints,
                          ),
                        if (ticketData.tickets![0].statusId ==
                            TicketStatusCodes.refunded)
                          TicketStatusChip(
                            left: 0,
                            bottom: constraints.maxWidth * .4,
                            textColor: TColors.error,
                            borderColor: TColors.error,
                            ticketStatus: 'Refunded',
                            consttrains: constraints,
                          ),
                        if (ticketData.tickets![0].statusId ==
                            TicketStatusCodes.changeDestination)
                          TicketStatusChip(
                            left: 0,
                            bottom: constraints.maxWidth * .4,
                            textColor: TColors.warning,
                            borderColor: TColors.warning,
                            ticketStatus: 'Change Dt',
                            consttrains: constraints,
                          ),
                        if (ticketData.tickets![0].statusId ==
                            TicketStatusCodes.exitUsed)
                          TicketStatusChip(
                            left: 0,
                            bottom: constraints.maxWidth * .4,
                            ticketStatus: 'Completed',
                            consttrains: constraints,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (ticketData.tickets![0].statusId == TicketStatusCodes.exitUsed)
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: TColors.primary,
                  side: BorderSide(
                    color: isDark ? TColors.accent : TColors.secondary,
                  ),
                  elevation: TSizes.sm,
                  shadowColor: isDark ? TColors.accent : TColors.darkGrey,
                  minimumSize: Size(screenWidth * .1, screenWidth * .05),
                  padding: const EdgeInsets.symmetric(
                    vertical: TSizes.sm,
                    horizontal: TSizes.md,
                  ),
                ),
                onPressed: () {
                  if (ticketData.fromStation != null &&
                      ticketData.toStation != null) {
                    bookQrController.source.value =
                        ticketData.fromStation ?? '';
                    bookQrController.destination.value =
                        ticketData.toStation ?? '';

                    // Trigger fare calculation
                    bookQrController.getFare();
                    Get.toNamed(Routes.bookQr);
                  }
                },
                child: Text(
                  'Re-Book Ticket',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: TColors.white,
                      ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tsavaari/common/widgets/containers/t_circular_container.dart';
import 'package:tsavaari/features/app_rating/rating_bottom_sheet.dart';
import 'package:tsavaari/features/my_orders/widgets/ticket_status.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/display_qr_controller.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/carbon_emission_message.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/passenger_count.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/platform_info_container.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/qr_main_stepper.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/ticket_expiry.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/ticket_status.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/ticket_status_codes.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class QrTicketContentContainer extends StatelessWidget {
  const QrTicketContentContainer({
    super.key,
    required this.tickets,
    required this.stationList,
    required this.ltmrhlPurchaseId,
  });
  final List<TicketsListModel> tickets;
  final List<StationListModel> stationList;
  final String ltmrhlPurchaseId;

  @override
  Widget build(BuildContext context) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final displayQrController = DisplayQrController.instance;
    final isSjtSinglePassenger = (tickets[0].ticketTypeId ==
                TicketStatusCodes.ticketTypeSjt ||
            tickets[0].ticketType == TicketStatusCodes.ticketTypeSjtString ||
            tickets[0].ticketType == TicketStatusCodes.ticketTypeRjtString ||
            tickets[0].oldTicketStatusId ==
                TicketStatusCodes.changeDestination.toString())
        ? tickets.length == 1
            ? true
            : false
        : false;

    final isRjtSinglePassenger =
        tickets[0].ticketTypeId == TicketStatusCodes.ticketTypeRjt
            ? tickets.length == 1
                ? true
                : false
            : false;
    bool getEntryAndInTransitTicketStatus() {
      if (tickets[displayQrController.carouselCurrentIndex.value]
                  .ticketStatus ==
              TicketStatusCodes.newTicketString ||
          tickets[displayQrController.carouselCurrentIndex.value]
                  .ticketTypeId ==
              TicketStatusCodes.newTicket ||
          tickets[displayQrController.carouselCurrentIndex.value]
                  .ticketStatus ==
              TicketStatusCodes.entryUsedString ||
          tickets[displayQrController.carouselCurrentIndex.value]
                  .ticketTypeId ==
              TicketStatusCodes.entryUsed ||
          tickets[displayQrController.carouselCurrentIndex.value]
                  .oldTicketStatusId ==
              TicketStatusCodes.changeDestination.toString()) {
        return true;
      }
      return false;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //-- Ticket Count
            Obx(
              () => PassengerCount(
                totalTicketCount: tickets.length,
                currentValue:
                    displayQrController.carouselCurrentIndex.value + 1,
              ),
            ),

            //--Ticket Status
            Obx(() => Row(
                  children: [
                    if (getEntryAndInTransitTicketStatus())
                      TicketStatus(
                        ticketStatus: tickets[displayQrController
                                    .carouselCurrentIndex.value]
                                .ticketStatus ??
                            '',
                      ),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    if (tickets[displayQrController.carouselCurrentIndex.value]
                            .purchaseDatetime !=
                        null)
                      OutlinedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) =>
                                Wrap(children: [QrStepper(tickets: tickets)]),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: TColors.white,
                          side: const BorderSide(
                            color: TColors.primary,
                          ),
                          elevation: TSizes.sm,
                          shadowColor: TColors.accent,
                          minimumSize:
                              Size(screenWidth * .1, screenWidth * .05),
                          padding: const EdgeInsets.symmetric(
                            vertical: TSizes.xs,
                            horizontal: TSizes.md,
                          ),
                        ),
                        child: Text(
                          'View Details',
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: TColors.primary,
                                  ),
                        ),
                      ),
                  ],
                )),
          ],
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
                  onTap: tickets.first.ratings == null
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
                              orderId: ltmrhlPurchaseId,
                            ),
                          );
                        }
                      : null,
                  child: Icon(
                    index < (tickets.first.ratings?.rating ?? 0)
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

        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        //--Platfomr info-------------
        if (tickets[displayQrController.carouselCurrentIndex.value]
                    .platFormNo !=
                null &&
            (tickets[displayQrController.carouselCurrentIndex.value].statusId ==
                    TicketStatusCodes.newTicket ||
                tickets[displayQrController.carouselCurrentIndex.value]
                        .ticketStatus ==
                    TicketStatusCodes.newTicketString ||
                tickets[displayQrController.carouselCurrentIndex.value]
                        .statusId ==
                    TicketStatusCodes.entryUsed))
          PlatformInfoContainer(
            tickets: tickets,
            stationList: stationList,
          ),

        //-- QR Image
        // if ((tickets[displayQrController.carouselCurrentIndex.value].statusId ==
        //         TicketStatusCodes.newTicket ||
        //     tickets[displayQrController.carouselCurrentIndex.value]
        //             .ticketStatus ==
        //         TicketStatusCodes.newTicketString ||
        //     tickets[displayQrController.carouselCurrentIndex.value].statusId ==
        //         TicketStatusCodes.entryUsed ||
        //     tickets[displayQrController.carouselCurrentIndex.value]
        //             .oldTicketStatusId ==
        //         TicketStatusCodes.changeDestination.toString()))
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: false,
            initialPage: displayQrController.carouselCurrentIndex.value,
            enableInfiniteScroll:
                (!isSjtSinglePassenger && !isRjtSinglePassenger),
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              displayQrController.updatePageIndicator(index, tickets.length);
            },
          ),
          items: tickets
              .map(
                (ticket) => Center(
                  child: SizedBox(
                    width: screenWidth * .4,
                    child: LayoutBuilder(
                      builder: (context, constraints) => Stack(
                        children: [
                          QrImageView(
                            data: ticket.ticketContent!,
                            version: QrVersions.auto,
                            dataModuleStyle: QrDataModuleStyle(
                              dataModuleShape: QrDataModuleShape.square,
                              color: (ticket.statusId !=
                                          TicketStatusCodes.newTicket &&
                                      ticket.ticketStatus !=
                                          TicketStatusCodes.newTicketString &&
                                      ticket.statusId !=
                                          TicketStatusCodes.entryUsed &&
                                      ticket.oldTicketStatusId !=
                                          TicketStatusCodes.changeDestination
                                              .toString())
                                  ? TColors.darkGrey
                                  : TColors.black,
                            ),
                            eyeStyle: QrEyeStyle(
                              eyeShape: QrEyeShape.square,
                              color: (ticket.statusId !=
                                          TicketStatusCodes.newTicket &&
                                      ticket.ticketStatus !=
                                          TicketStatusCodes.newTicketString &&
                                      ticket.statusId !=
                                          TicketStatusCodes.entryUsed &&
                                      ticket.oldTicketStatusId !=
                                          TicketStatusCodes.changeDestination
                                              .toString())
                                  ? TColors.darkGrey
                                  : TColors.black,
                            ),
                          ),
                          if (ticket.statusId == TicketStatusCodes.refunded)
                            TicketStatusChip(
                              left: 0,
                              bottom: constraints.maxWidth * .4,
                              textColor: TColors.error,
                              borderColor: TColors.error,
                              ticketStatus: 'Refunded',
                              consttrains: constraints,
                              padding: const EdgeInsets.symmetric(
                                vertical: TSizes.sm,
                              ),
                            ),
                          if (ticket.statusId ==
                              TicketStatusCodes.changeDestination)
                            TicketStatusChip(
                              left: 0,
                              bottom: constraints.maxWidth * .4,
                              textColor: TColors.warning,
                              borderColor: TColors.warning,
                              ticketStatus: 'Change Destination',
                              consttrains: constraints,
                              padding: const EdgeInsets.symmetric(
                                vertical: TSizes.sm,
                              ),
                            ),
                          if (ticket.statusId == TicketStatusCodes.exitUsed)
                            TicketStatusChip(
                              left: 0,
                              bottom: constraints.maxWidth * .4,
                              ticketStatus: 'Completed',
                              consttrains: constraints,
                              padding: const EdgeInsets.symmetric(
                                vertical: TSizes.sm,
                              ),
                            ),
                          if (ticket.statusId == TicketStatusCodes.expired)
                            TicketStatusChip(
                              left: 0,
                              bottom: constraints.maxWidth * .4,
                              textColor: TColors.error,
                              borderColor: TColors.error,
                              ticketStatus: 'Expired',
                              consttrains: constraints,
                              padding: const EdgeInsets.symmetric(
                                vertical: TSizes.sm,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        if (!isSjtSinglePassenger && !isRjtSinglePassenger)
          const SizedBox(
            height: TSizes.spaceBtwItems / 2,
          ),

        //-- Carousel dots
        if (!isSjtSinglePassenger && !isRjtSinglePassenger)
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < tickets.length; i++)
                  TCircularContainer(
                    width: screenWidth * 0.03,
                    height: screenWidth * 0.03,
                    backgroundColor:
                        displayQrController.carouselCurrentIndex.value == i
                            ? TColors.primary
                            : TColors.grey,
                    margin: EdgeInsets.only(right: screenWidth * 0.02),
                  ),
              ],
            ),
          ),
        if (!isSjtSinglePassenger && !isRjtSinglePassenger)
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
        Container(
          width: screenWidth * .6,
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
          decoration: BoxDecoration(
            color: TColors.primary.withOpacity(.1),
            borderRadius: BorderRadius.circular(screenWidth * .02),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.info_circle,
                size: screenWidth * 0.04,
                color: TColors.primary,
              ),
              SizedBox(
                width: screenWidth * 0.01,
              ),
              Text(
                'Scan QR at Entry/Exit gates',
                textScaler: TextScaleUtil.getScaledText(context, maxScale: 3),
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: TColors.primary),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        //--Ticket id
        Obx(
          () => Text(
            'TKID ${tickets[displayQrController.carouselCurrentIndex.value].ticketId}',
            softWrap: true,
            textScaler: TextScaleUtil.getScaledText(context, maxScale: 3),
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: TColors.black),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        //Ticket Expiry
        if (tickets[0].ticketExpiryTime != null)
          TicketExpiry(
            dateTime: tickets[0].ticketExpiryTime != null
                ? THelperFunctions.getFormattedDateTimeString(
                    tickets[0].ticketExpiryTime!)
                : '',
          ),

        if (!isSjtSinglePassenger && !isRjtSinglePassenger)
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
        const Divider(),

        //--Carbon emission message
        CarbonEmissionMessage(message: tickets[0].carbonEmissionMsg ?? ''),
      ],
    );
  }
}

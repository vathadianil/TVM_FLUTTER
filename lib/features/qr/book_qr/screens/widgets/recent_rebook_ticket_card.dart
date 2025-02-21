import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/widgets/containers/t_ticket_shape_widget.dart';
import 'package:tsavaari/common/widgets/shapes/circle_shape.dart';
import 'package:tsavaari/common/widgets/shapes/dashed_horizontal_line.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/book_qr_controller.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/qr_shimmer_container.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/features/my_orders/controllers/orders_controller.dart';

class RecentRebookTicketCard extends StatelessWidget {
  const RecentRebookTicketCard({
    super.key,
    required this.stationList,
    this.ticketData,
  });

  final List<StationListModel> stationList;
  final TicketHistory? ticketData;

  @override
  Widget build(BuildContext context) {
    final ordersController = OrdersController.instance;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
      child: Obx(() {
        if (ordersController.isLoading.value) {
          return const QrShimmerContainer();
        }

        if (ordersController.activeTickets.isEmpty || 
            ordersController.activeTickets.first.ticketHistory == null ||
            !BookQrController.instance.showRecentTicketCard.value) {
          return const SizedBox();
        }

        return _buildTicketCard(context);
      }),
    );
  }

  Widget _buildTicketCard(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final bookQrController = BookQrController.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Ticket',
          textScaler: TextScaleUtil.getScaledText(context, maxScale: 3),
          style: Theme.of(context).textTheme.bodyLarge!,
        ),

        const SizedBox(height: TSizes.sm),

        TTicketShapeWidget(
          backgroundColor: isDark ? TColors.dark.withOpacity(.7) : TColors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: screenWidth * .7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (ticketData?.fromStation != null)
                      Text(
                        THelperFunctions.getStationFromStationName(
                          ticketData!.fromStation!,
                          stationList
                        ).shortName ?? '',
                        textScaler: TextScaleUtil.getScaledText(context),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    Text(
                      ticketData?.purchaseDate ?? '',
                      textScaler: TextScaleUtil.getScaledText(context, maxScale: 3),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    if (ticketData?.toStation != null)
                      Text(
                        THelperFunctions.getStationFromStationName(
                          ticketData!.toStation!,
                          stationList
                        ).shortName ?? '',
                        textScaler: TextScaleUtil.getScaledText(context),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                  ],
                ),
              ),

              const SizedBox(height: TSizes.sm),

              _buildTrainRoute(context, screenWidth, isDark),

              _buildStationDetails(context, screenWidth),

              const SizedBox(height: TSizes.spaceBtwItems),

              _buildRebookButton(context, screenWidth, isDark, bookQrController),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrainRoute(BuildContext context, double screenWidth, bool isDark) {
    return Row(
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
          ),
        ),
        Icon(
          Icons.train,
          color: isDark ? TColors.accent : TColors.primary,
        ),
        SizedBox(
          width: screenWidth * .25,
          child: DashedHorizontalLine(
            dashWidth: 4,
            color: isDark ? TColors.accent : TColors.primary,
          ),
        ),
        CircleShape(
          width: TSizes.sm,
          height: TSizes.sm,
          darkModeBorderColor: TColors.accent,
          lightModeBorderColor: TColors.primary,
          fillColor: isDark ? TColors.accent : TColors.primary,
        ),
      ],
    );
  }

  Widget _buildStationDetails(BuildContext context, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: screenWidth * .2,
          child: Text(
            ticketData?.fromStation ?? '',
            textScaler: TextScaleUtil.getScaledText(context, maxScale: 3),
            style: Theme.of(context).textTheme.bodyLarge!,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: screenWidth * .1),
        Text(
          ticketData?.purchaseTime ?? '',
          textScaler: TextScaleUtil.getScaledText(context, maxScale: 3),
          style: Theme.of(context).textTheme.labelSmall!,
        ),
        SizedBox(width: screenWidth * .1),
        SizedBox(
          width: screenWidth * .18,
          child: Text(
            ticketData?.toStation ?? '',
            textScaler: TextScaleUtil.getScaledText(context, maxScale: 3),
            style: Theme.of(context).textTheme.bodyLarge!,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildRebookButton(BuildContext context, double screenWidth, bool isDark, BookQrController bookQrController) {
    return OutlinedButton(
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
        if (ticketData?.fromStation != null && ticketData?.toStation != null) {
          bookQrController.source.value = ticketData!.fromStation!;
          bookQrController.destination.value = ticketData!.toStation!;

          // Hide the Card
          bookQrController.showRecentTicketCard.value = false;
          bookQrController.getFare();
        }
      },
      child: Text(
        'Re-Book Ticket',
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
          color: TColors.white,
        ),
      ),
    );
  }
}
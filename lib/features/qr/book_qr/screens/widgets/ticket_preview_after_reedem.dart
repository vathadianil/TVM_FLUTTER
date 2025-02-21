import 'package:flutter/material.dart';
import 'package:tsavaari/common/widgets/containers/t_ticket_shape_widget.dart';
import 'package:tsavaari/common/widgets/shapes/circle_shape.dart';
import 'package:tsavaari/common/widgets/shapes/dashed_horizontal_line.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/book_qr_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class TicketPreviewAfterReedem extends StatelessWidget {
  TicketPreviewAfterReedem({super.key});

  final bookQrController = BookQrController.instance;

  @override
  Widget build(BuildContext context) {
    return _buildTicketCard(context);
  }

  Widget _buildTicketCard(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final screenWidth = TDeviceUtils.getScreenWidth(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ticket Preview',
          textScaler: TextScaleUtil.getScaledText(context, maxScale: 3),
          style: Theme.of(context).textTheme.bodyLarge!,
        ),

        const SizedBox(height: TSizes.sm),

        TTicketShapeWidget(
          backgroundColor: isDark ? TColors.accent : TColors.accent,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
               _buildStationDetails(context, screenWidth),

              const SizedBox(height: TSizes.sm),

              _buildTrainRoute(context, screenWidth, isDark),

              const SizedBox(height: TSizes.sm),

              _buildTripAndPassengersDetails(context, screenWidth)
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
          darkModeBorderColor: TColors.primary,
          lightModeBorderColor: TColors.primary,
          fillColor: isDark ? TColors.primary : TColors.primary,
        ),
        SizedBox(
          width: screenWidth * .25,
          child: DashedHorizontalLine(
            dashWidth: 4,
            color: isDark ? TColors.primary : TColors.primary,
          ),
        ),
        Icon(
          Icons.train,
          color: isDark ? TColors.primary : TColors.primary,
        ),
        SizedBox(
          width: screenWidth * .25,
          child: DashedHorizontalLine(
            dashWidth: 4,
            color: isDark ? TColors.primary : TColors.primary,
          ),
        ),
        CircleShape(
          width: TSizes.sm,
          height: TSizes.sm,
          darkModeBorderColor: TColors.primary,
          lightModeBorderColor: TColors.primary,
          fillColor: isDark ? TColors.primary : TColors.primary,
        ),
      ],
    );
  }

  Widget _buildStationDetails(BuildContext context, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: screenWidth * .24,
          child: Text(
            bookQrController.source.value,
            textScaler: TextScaleUtil.getScaledText(context, maxScale: 3),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: TColors.black
                ),
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      
        SizedBox(
          width: screenWidth * .24,
          child: Text(
            bookQrController.destination.value ,
            textScaler: TextScaleUtil.getScaledText(context, maxScale: 3),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: TColors.black
                ),
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildTripAndPassengersDetails(BuildContext context, double screenWidth) {
    return SizedBox(
      width: screenWidth * .7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "Ticket Type",
                textScaler:
                    TextScaleUtil.getScaledText(context),
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: TColors.black
                ),
              ),
              Text(
                bookQrController.ticketType.value
                ? TTexts.roundTrip
                : TTexts.oneWay,
                textScaler:
                    TextScaleUtil.getScaledText(context, maxScale: 3),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: TColors.black
                ),
              ),
            ],
          ),
          
          Column(
            children: [
              Text(
                TTexts.passengers,
                textScaler:
                    TextScaleUtil.getScaledText(context),
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: TColors.black
                ),
              ),
              Text(
                '${bookQrController.passengerCount} ${TTexts.adults}',
                textScaler:
                    TextScaleUtil.getScaledText(context, maxScale: 3),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: TColors.black
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

 
}
import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/ticket_status_codes.dart';

class TicketStatus extends StatelessWidget {
  const TicketStatus({
    super.key,
    required this.ticketStatus,
  });

  final String ticketStatus;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: TSizes.md, vertical: TSizes.sm / 2),
          decoration: BoxDecoration(
            color: ticketStatus == TicketStatusCodes.newTicketString
                ? TColors.success
                : TColors.secondary,
            borderRadius: BorderRadius.circular(TSizes.lg),
          ),
          child: Text(
            ticketStatus == TicketStatusCodes.entryUsedString
                ? 'In Transit'
                : ticketStatus,
            textAlign: TextAlign.center,
            textScaler: TextScaleUtil.getScaledText(context, maxScale: 3),
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: ticketStatus == TicketStatusCodes.newTicketString
                    ? TColors.white
                    : TColors.dark),
          ),
        ),
      ],
    );
  }
}

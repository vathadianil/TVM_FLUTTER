import 'package:flutter/material.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/display_qr_controller.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/change_destination_stepper.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/exit_or_expired_stepper.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/refund_stepper.dart';
import 'package:tsavaari/utils/constants/ticket_status_codes.dart';

class QrStepper extends StatelessWidget {
  const QrStepper({
    super.key,
    required this.tickets,
  });

  final List<TicketsListModel> tickets;

  @override
  Widget build(BuildContext context) {
    final displayQrController = DisplayQrController.instance;

    return tickets[displayQrController.carouselCurrentIndex.value]
                .purchaseDatetime !=
            null
        ? Column(
            children: [
              if (tickets[displayQrController.carouselCurrentIndex.value]
                      .statusId ==
                  TicketStatusCodes.refunded)
                RefundStepper(tickets: tickets),
              if (tickets[displayQrController.carouselCurrentIndex.value]
                      .statusId ==
                  TicketStatusCodes.changeDestination)
                ChangeDestinationStepper(tickets: tickets),
              if (tickets[displayQrController.carouselCurrentIndex.value]
                          .statusId !=
                      TicketStatusCodes.changeDestination &&
                  tickets[displayQrController.carouselCurrentIndex.value]
                          .statusId !=
                      TicketStatusCodes.refunded)
                ExitOrExpiredStepper(tickets: tickets)
            ],
          )
        : const SizedBox();
  }
}

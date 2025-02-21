import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/display_qr_controller.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/custom_qr_step.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/order_id_and_amount_container.dart';
import 'package:tsavaari/utils/constants/colors.dart';

class RefundStepper extends StatelessWidget {
  const RefundStepper({super.key, required this.tickets});
  final List<TicketsListModel> tickets;

  @override
  Widget build(BuildContext context) {
    final displayQrController = DisplayQrController.instance;
    return Stepper(
      physics: const NeverScrollableScrollPhysics(),
      connectorColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return TColors.primary;
        }
        return TColors.grey;
      }),
      controlsBuilder: (context, details) {
        if (details.stepIndex == 0) {
          return OrderIdAmountContainer(tickets: tickets);
        } else {
          return const Row(
            children: [],
          );
        }
      },
      stepIconBuilder: (stepIndex, stepState) {
        if (stepState == StepState.complete) {
          return const Icon(
            Iconsax.tick_circle,
            color: TColors.white,
          );
        } else {
          return const Icon(
            Iconsax.clock,
            color: TColors.white,
          );
        }
      },
      steps: [
        //-- Purchase Step
        CustonQrStep.step(
          displayQrController,
          context,
          'Purchase Time',
          tickets[displayQrController.carouselCurrentIndex.value]
                  .purchaseDatetime ??
              '',
          isActive: tickets[displayQrController.carouselCurrentIndex.value]
                  .purchaseDatetime !=
              null,
        ),

        //-- Refuned
        CustonQrStep.step(
          displayQrController,
          context,
          'Refund',
          tickets[displayQrController.carouselCurrentIndex.value]
                  .cancellationTime ??
              '',
          isActive: tickets[displayQrController.carouselCurrentIndex.value]
                  .cancellationTime !=
              null,
        ),
      ],
    );
  }
}

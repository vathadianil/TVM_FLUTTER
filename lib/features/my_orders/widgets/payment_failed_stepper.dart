import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/display_qr_controller.dart';
import 'package:tsavaari/features/qr/display_qr/models/payment_failed_ticket_model.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/custom_qr_step.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class PaymentFailedStepper extends StatelessWidget {
  const PaymentFailedStepper({super.key, required this.paymentFailedData});
  final PaymentFailedData paymentFailedData;

  @override
  Widget build(BuildContext context) {
    final displayQrController = Get.put(DisplayQrController());
    final screenWidth = TDeviceUtils.getScreenWidth(context);
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
          return Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Price',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const SizedBox(
                        width: TSizes.md,
                      ),
                      if (paymentFailedData.merchantTotalFareAfterGst != 'null')
                        Text(
                            '${TTexts.rupeeSymbol}${paymentFailedData.merchantTotalFareAfterGst}/-',
                            style: Theme.of(context).textTheme.bodyLarge)
                      else
                        Text(
                            '${TTexts.rupeeSymbol}${paymentFailedData.refundAmount}/-',
                            style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                  if (paymentFailedData.orderId != null ||
                      paymentFailedData.merchantOrderId != null)
                    const SizedBox(
                      height: TSizes.sm,
                    ),
                  if (paymentFailedData.orderId != null ||
                      paymentFailedData.merchantOrderId != null)
                    Text('Metro Order Id',
                        style: Theme.of(context).textTheme.bodyLarge),
                  if (paymentFailedData.orderId != null ||
                      paymentFailedData.merchantOrderId != null)
                    SizedBox(
                      width: screenWidth * .5,
                      child: Text(
                        paymentFailedData.orderId ??
                            paymentFailedData.merchantOrderId ??
                            '',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  if (paymentFailedData.paymentTxnId != null)
                    const SizedBox(
                      height: TSizes.sm,
                    ),
                  if (paymentFailedData.paymentTxnId != null)
                    Text('PG Transaction Id',
                        style: Theme.of(context).textTheme.bodyLarge),
                  if (paymentFailedData.paymentTxnId != null)
                    SizedBox(
                      width: screenWidth * .5,
                      child: Text(
                        paymentFailedData.paymentTxnId ?? '',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  if (paymentFailedData.orderId != null ||
                      paymentFailedData.merchantOrderId != null)
                    const SizedBox(
                      height: TSizes.sm,
                    ),
                  if (paymentFailedData.bankReference != null)
                    Text('Bank Reference Number',
                        style: Theme.of(context).textTheme.bodyLarge),
                  if (paymentFailedData.bankReference != null)
                    SizedBox(
                      width: screenWidth * .5,
                      child: Text(
                        paymentFailedData.paymentTxnId ?? '',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  if (paymentFailedData.paymentMethod != null)
                    const SizedBox(
                      height: TSizes.sm,
                    ),
                  if (paymentFailedData.paymentMethod != null)
                    Text.rich(TextSpan(children: [
                      TextSpan(
                        text: 'Paid via ',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      TextSpan(
                        text: '${paymentFailedData.paymentMethod}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ])),
                ],
              )
            ],
          );
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
          paymentFailedData.failureCode == 'payment_failed' ||
                  paymentFailedData.failureCode == 'action_cancelled'
              ? 'Trx Initiated At'
              : 'Purchase Time',
          paymentFailedData.purchaseDatetime ??
              paymentFailedData.travelDateTime ??
              '',
          isActive: true,
          adoptThemefontColor: true,
        ),

        //-- Payment Failed
        if (paymentFailedData.failureCode == 'payment_failed' ||
            paymentFailedData.failureCode == 'action_cancelled')
          CustonQrStep.step(
            displayQrController,
            context,
            'Payment Failed',
            paymentFailedData.failureReason ?? '',
            isActive: paymentFailedData.failureReason != null,
            adoptThemefontColor: true,
          ),

        //Refund Initiated
        if (paymentFailedData.failureCode != 'payment_failed' &&
            paymentFailedData.refundId != null)
          CustonQrStep.step(
            displayQrController,
            context,
            'Refund Initiated',
            '${paymentFailedData.createdAt}\n\nMetro Refund Id \n${paymentFailedData.refundId}\n\nPG Refund Trx Id \n${paymentFailedData.qrPgRefundId}',
            isActive: paymentFailedData.createdAt != null,
            adoptThemefontColor: true,
          ),

        //-- Refuned result
        if (paymentFailedData.failureCode != 'payment_failed' &&
            paymentFailedData.refundStatus != null)
          CustonQrStep.step(
            displayQrController,
            context,
            paymentFailedData.refundStatus ?? '',
            '${paymentFailedData.updateDateTime}\n${paymentFailedData.statusDescription}',
            isActive: paymentFailedData.refundStatus != 'PENDING',
            adoptThemefontColor: true,
          ),
      ],
    );
  }
}

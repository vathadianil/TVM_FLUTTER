import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/features/card_reacharge/models/card_trx_details_model.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/display_qr_controller.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/custom_qr_step.dart';
import 'package:tsavaari/utils/constants/card_reacharge_status_codes.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class CardPaymentStatusStepper extends StatelessWidget {
  const CardPaymentStatusStepper({super.key, required this.cardPaymentTrxData});
  final CardTrxListModel cardPaymentTrxData;

  @override
  Widget build(BuildContext context) {
    var data = [];
    if (cardPaymentTrxData.transactionStatus ==
        CardRechargeStatusCodes.requestSent) {
      data.assignAll(
          CardRechargeStatusCodes.watingForPaymentConfirmationStatus);
    } else if (cardPaymentTrxData.transactionStatus ==
        CardRechargeStatusCodes.requestSentFailed) {
      data.assignAll(CardRechargeStatusCodes.paymentFailedStatus);
    } else if (cardPaymentTrxData.transactionStatus ==
        CardRechargeStatusCodes.responseReceived) {
      data.assignAll(CardRechargeStatusCodes.paymentSuccessStatus);
    } else if ((cardPaymentTrxData.transactionStatus ==
            CardRechargeStatusCodes.rechargeInProgress1) ||
        (cardPaymentTrxData.transactionStatus ==
            CardRechargeStatusCodes.rechargeInProgress2) ||
        (cardPaymentTrxData.transactionStatus ==
            CardRechargeStatusCodes.rechargeInProgress3)) {
      data.assignAll(CardRechargeStatusCodes.rechageInProgressStatus);
    } else if ((cardPaymentTrxData.transactionStatus ==
        CardRechargeStatusCodes.pendingAtStation)) {
      data.assignAll(CardRechargeStatusCodes.pendingAtStationStatus);
    } else if ((cardPaymentTrxData.transactionStatus ==
        CardRechargeStatusCodes.failureAtStation)) {
      data.assignAll(CardRechargeStatusCodes.fialedAtStationStatus);
    } else if (cardPaymentTrxData.transactionStatus ==
        CardRechargeStatusCodes.balanceAdded) {
      data.assignAll(CardRechargeStatusCodes.balanceAddedStatus);
    } else if (cardPaymentTrxData.transactionStatus ==
        CardRechargeStatusCodes.markedForRefund) {
      data.assignAll(CardRechargeStatusCodes.markedForRefundStatus);
    } else if (cardPaymentTrxData.transactionStatus ==
        CardRechargeStatusCodes.refundSuccess) {
      data.assignAll(CardRechargeStatusCodes.refundSuccessStatus);
    } else if (cardPaymentTrxData.transactionStatus ==
        CardRechargeStatusCodes.refundFailed) {
      data.assignAll(CardRechargeStatusCodes.refundFailedStatus);
    }

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
                      if (cardPaymentTrxData.addedValue != null)
                        Text(
                          'Recharge Amount',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      if (cardPaymentTrxData.addedValue != null)
                        const SizedBox(
                          width: TSizes.md,
                        ),
                      if (cardPaymentTrxData.addedValue != null)
                        Text(
                            '${TTexts.rupeeSymbol}${cardPaymentTrxData.addedValue}/-',
                            style: Theme.of(context).textTheme.bodyLarge)
                    ],
                  ),
                  if (cardPaymentTrxData.pgOrderId != null)
                    const SizedBox(
                      height: TSizes.sm,
                    ),
                  if (cardPaymentTrxData.pgOrderId != null)
                    Text('Metro Order Id',
                        style: Theme.of(context).textTheme.bodyLarge),
                  if (cardPaymentTrxData.pgOrderId != null)
                    SizedBox(
                      width: screenWidth * .5,
                      child: Text(
                        cardPaymentTrxData.pgOrderId ?? '',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  if (cardPaymentTrxData.pgTxnId != null)
                    const SizedBox(
                      height: TSizes.sm,
                    ),
                  if (cardPaymentTrxData.pgTxnId != null)
                    Text('PG Transaction Id',
                        style: Theme.of(context).textTheme.bodyLarge),
                  if (cardPaymentTrxData.pgTxnId != null)
                    SizedBox(
                      width: screenWidth * .5,
                      child: Text(
                        cardPaymentTrxData.pgTxnId ?? '',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  if (cardPaymentTrxData.pgBankRefNum != null)
                    const SizedBox(
                      height: TSizes.sm,
                    ),
                  if (cardPaymentTrxData.pgBankRefNum != null)
                    Text('Bank Reference Number',
                        style: Theme.of(context).textTheme.bodyLarge),
                  if (cardPaymentTrxData.pgBankRefNum != null)
                    SizedBox(
                      width: screenWidth * .5,
                      child: Text(
                        cardPaymentTrxData.pgBankRefNum ?? '',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  if (cardPaymentTrxData.paymentMethod != null)
                    const SizedBox(
                      height: TSizes.sm,
                    ),
                  if (cardPaymentTrxData.paymentMethod != null)
                    Text.rich(TextSpan(children: [
                      TextSpan(
                        text: 'Paid via ',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      TextSpan(
                        text: '${cardPaymentTrxData.paymentMethod}',
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
          'Transaction Date Time',
          cardPaymentTrxData.transactionDateTime != ''
              ? THelperFunctions.getFormattedDateTimeString1(
                  cardPaymentTrxData.transactionDateTime!,
                )
              : '',
          isActive: true,
          adoptThemefontColor: true,
        ),

        CustonQrStep.step(
          displayQrController,
          context,
          data[1].statusInfo.replaceAll('\n', ' ') ?? '',
          '',
          isActive: data[1].color == TColors.success,
          adoptThemefontColor: true,
        ),

        CustonQrStep.step(
          displayQrController,
          context,
          data[2].statusInfo.replaceAll('\n', ' ') ?? '',
          '',
          isActive: data[2].color == TColors.success,
          adoptThemefontColor: true,
        ),
      ],
    );
  }
}

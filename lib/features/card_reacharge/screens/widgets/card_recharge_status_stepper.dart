import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/common/widgets/containers/t_circular_container.dart';
import 'package:tsavaari/features/card_reacharge/models/last_recharge_status_model.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/card_reacharge_status_codes.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class CardRechargeStatusStepper extends StatelessWidget {
  const CardRechargeStatusStepper(
      {super.key,
      required this.lastRechargeStatusData,
      required this.cardHeight});

  final LastRechargeStatusModel lastRechargeStatusData;
  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    var data = [];

    if (lastRechargeStatusData.transactionCode ==
        CardRechargeStatusCodes.requestSent) {
      data.assignAll(
          CardRechargeStatusCodes.watingForPaymentConfirmationStatus);
    } else if (lastRechargeStatusData.transactionCode ==
        CardRechargeStatusCodes.requestSentFailed) {
      data.assignAll(CardRechargeStatusCodes.paymentFailedStatus);
    } else if (lastRechargeStatusData.transactionCode ==
        CardRechargeStatusCodes.responseReceived) {
      data.assignAll(CardRechargeStatusCodes.paymentSuccessStatus);
    } else if ((lastRechargeStatusData.transactionCode ==
            CardRechargeStatusCodes.rechargeInProgress1) ||
        (lastRechargeStatusData.transactionCode ==
            CardRechargeStatusCodes.rechargeInProgress2) ||
        (lastRechargeStatusData.transactionCode ==
            CardRechargeStatusCodes.rechargeInProgress3)) {
      data.assignAll(CardRechargeStatusCodes.rechageInProgressStatus);
    } else if ((lastRechargeStatusData.transactionCode ==
        CardRechargeStatusCodes.pendingAtStation)) {
      data.assignAll(CardRechargeStatusCodes.pendingAtStationStatus);
    } else if ((lastRechargeStatusData.transactionCode ==
        CardRechargeStatusCodes.failureAtStation)) {
      data.assignAll(CardRechargeStatusCodes.fialedAtStationStatus);
    } else if (lastRechargeStatusData.transactionCode ==
        CardRechargeStatusCodes.balanceAdded) {
      data.assignAll(CardRechargeStatusCodes.balanceAddedStatus);
    } else if (lastRechargeStatusData.transactionCode ==
        CardRechargeStatusCodes.markedForRefund) {
      data.assignAll(CardRechargeStatusCodes.markedForRefundStatus);
    } else if (lastRechargeStatusData.transactionCode ==
        CardRechargeStatusCodes.refundSuccess) {
      data.assignAll(CardRechargeStatusCodes.refundSuccessStatus);
    } else if (lastRechargeStatusData.transactionCode ==
        CardRechargeStatusCodes.refundFailed) {
      data.assignAll(CardRechargeStatusCodes.refundFailedStatus);
    }

    final tooltipMessage = CardRechargeStatusCodes.getDescirption(
        lastRechargeStatusData.transactionCode ?? '');

    final screenWidth = TDeviceUtils.getScreenWidth(context);

    return Column(
      children: [
        SizedBox(
          height: cardHeight * .23,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: data[index].color,
                        ),
                        child: Icon(
                          data[index].icon,
                          color: TColors.white,
                          size: screenWidth * .05,
                        ),
                      ),
                      SizedBox(
                        height: screenWidth * .01,
                      ),
                      Text(
                        data[index].statusInfo,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  if (index != data.length - 1)
                    SizedBox(
                      width: screenWidth * .04,
                      height: screenWidth * .003,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: data[index].color),
                      ),
                    ),
                ],
              );
            },
            itemCount: data.length,
          ),
        ),
        SizedBox(
          height: cardHeight * .02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Order Id: ',
                        style: Theme.of(context).textTheme.labelSmall),
                    Text(lastRechargeStatusData.merchantTransactionID ?? '',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
                Row(
                  children: [
                    Text('Date: ',
                        style: Theme.of(context).textTheme.labelSmall),
                    Text(
                        lastRechargeStatusData.transactionDate != ''
                            ? THelperFunctions.getFormattedDateTimeString1(
                                lastRechargeStatusData.transactionDate ?? '')
                            : '',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
                Row(
                  children: [
                    Text('Amount: ',
                        style: Theme.of(context).textTheme.labelSmall),
                    Text(
                        '${TTexts.rupeeSymbol}${lastRechargeStatusData.addedValue ?? ''}/-',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ],
            ),
            if (tooltipMessage != '')
              Tooltip(
                showDuration: const Duration(seconds: 10),
                triggerMode: TooltipTriggerMode.tap,
                margin: const EdgeInsets.symmetric(
                  horizontal: TSizes.md,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: TSizes.sm,
                  horizontal: TSizes.md,
                ),
                decoration: BoxDecoration(
                    color: TColors.secondary,
                    borderRadius: BorderRadius.circular(TSizes.sm),
                    boxShadow: const [
                      BoxShadow(color: TColors.secondary, blurRadius: TSizes.sm)
                    ]),
                message: tooltipMessage,
                textStyle: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: TColors.dark),
                child: TCircularContainer(
                  width: screenWidth * .07,
                  height: screenWidth * .07,
                  applyBoxShadow: true,
                  backgroundColor: dark ? TColors.dark : TColors.white,
                  boxShadowColor:
                      dark ? TColors.accent.withOpacity(.3) : TColors.accent,
                  radius: screenWidth * .1,
                  child: Icon(
                    Iconsax.info_circle,
                    color: dark ? TColors.accent : TColors.primary,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

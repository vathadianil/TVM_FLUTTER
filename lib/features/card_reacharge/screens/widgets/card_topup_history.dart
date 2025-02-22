import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/features/card_reacharge/models/card_trx_details_model.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/card_payment_details_stepper.dart';
import 'package:tsavaari/utils/constants/card_reacharge_status_codes.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class CardTopupHistory extends StatelessWidget {
  const CardTopupHistory({
    super.key,
    required this.cardPaymentTrxData,
  });

  final CardTrxListModel cardPaymentTrxData;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    IconData icon = Iconsax.repeat_circle;
    Color color = TColors.secondary;
    String status = 'Pending';
    if (cardPaymentTrxData.transactionStatus ==
        CardRechargeStatusCodes.requestSent) {
      icon = Iconsax.repeat_circle;
      color = TColors.secondary;
      status = 'Pending';
    } else if (cardPaymentTrxData.transactionStatus ==
        CardRechargeStatusCodes.requestSentFailed) {
      icon = Iconsax.close_circle;
      color = TColors.error;
      status = 'Recharge\nSuspended';
    } else if (cardPaymentTrxData.transactionStatus ==
        CardRechargeStatusCodes.responseReceived) {
      icon = Iconsax.tick_circle;
      color = TColors.success;
      status = 'Success';
    } else if ((cardPaymentTrxData.transactionStatus ==
            CardRechargeStatusCodes.rechargeInProgress1) ||
        (cardPaymentTrxData.transactionStatus ==
            CardRechargeStatusCodes.rechargeInProgress2) ||
        (cardPaymentTrxData.transactionStatus ==
            CardRechargeStatusCodes.rechargeInProgress3)) {
      icon = Iconsax.tick_circle;
      color = TColors.success;
      status = 'Success';
    } else if ((cardPaymentTrxData.transactionStatus ==
            CardRechargeStatusCodes.pendingAtStation) ||
        (cardPaymentTrxData.transactionStatus ==
            CardRechargeStatusCodes.failureAtStation)) {
      icon = Iconsax.tick_circle;
      color = TColors.success;
      status = 'Success';
    } else if (cardPaymentTrxData.transactionStatus ==
        CardRechargeStatusCodes.balanceAdded) {
      icon = Iconsax.tick_circle;
      color = TColors.success;
      status = 'Success';
    } else if (cardPaymentTrxData.transactionStatus ==
        CardRechargeStatusCodes.markedForRefund) {
      icon = Iconsax.tick_circle;
      color = TColors.success;
      status = 'Refund\nInitiated';
    } else if (cardPaymentTrxData.transactionStatus ==
        CardRechargeStatusCodes.refundSuccess) {
      icon = Iconsax.tick_circle;
      color = TColors.success;
      status = 'Refunded';
    } else if (cardPaymentTrxData.transactionStatus ==
        CardRechargeStatusCodes.refundFailed) {
      icon = Iconsax.tick_circle;
      color = TColors.success;
      status = 'Refund\nFailed';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.sm,
        vertical: TSizes.md,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.md),
        color: isDark ? TColors.dark : TColors.light,
        border: Border.all(
          width: 1,
          color: isDark ? TColors.darkerGrey : TColors.grey,
        ),
      ),
      child: Row(
        children: [
          Column(
            children: [
              //-- Indication Icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: TColors.grey,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
              const SizedBox(
                height: TSizes.sm,
              ),
              //-- Amount
              Text('+${cardPaymentTrxData.addedValue}/-',
                  style: Theme.of(context).textTheme.titleLarge),
              Text(
                status,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
          const SizedBox(
            width: TSizes.md,
          ),
          //-- Order Id and Date
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Id:',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: TSizes.sm,
                  ),
                  SizedBox(
                    width: TDeviceUtils.getScreenWidth(context) * .1,
                    child: Text(
                      cardPaymentTrxData.merchantTransactionID ?? '',
                      style: Theme.of(context).textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.sm,
                  ),
                  Row(
                    children: [
                      Text(
                        'Date : ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(
                        width: TDeviceUtils.getScreenWidth(context) * .25,
                        child: Text(
                          cardPaymentTrxData.transactionDateTime != ''
                              ? THelperFunctions.getFormattedDateTimeString1(
                                  cardPaymentTrxData.transactionDateTime!,
                                )
                              : '',
                          style: Theme.of(context).textTheme.bodyLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: TDeviceUtils.getScreenWidth(context) * .00001,
                child: OutlinedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => Wrap(children: [
                        CardPaymentStatusStepper(
                            cardPaymentTrxData: cardPaymentTrxData)
                      ]),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: TColors.white,
                    side: const BorderSide(
                      color: TColors.primary,
                    ),
                    elevation: TSizes.sm,
                    shadowColor: TColors.accent,
                    // minimumSize: Size(TDeviceUtils.getScreenWidth(context) * .1,
                    //     TDeviceUtils.getScreenWidth(context) * .05),
                    padding: const EdgeInsets.symmetric(
                      vertical: TSizes.xs,
                      horizontal: TSizes.md,
                    ),
                  ),
                  child: Text(
                    'View Details',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: TColors.primary,
                        ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

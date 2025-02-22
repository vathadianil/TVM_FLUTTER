import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/book_qr_controller.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';

class DisplayFare extends StatelessWidget {
  const DisplayFare({super.key});

  @override
  Widget build(BuildContext context) {
    final bookQrController = BookQrController.instance;

    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(
          top: TSizes.defaultSpace / 2,
          left: TSizes.defaultSpace,
          right: TSizes.defaultSpace,
        ),
        child: Column(
          children: [
            // Check if qrFareData is empty
            if (bookQrController.qrFareData.isEmpty)
              Center(
                child: Text(
                  'Fare data is not available',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              )
            else if (!bookQrController.isLoading.value)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ticket Fare Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ticket Fare",
                        textScaler:
                            TextScaleUtil.getScaledText(context, maxScale: 1),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Row(
                        children: [
                          Text(
                            '${bookQrController.passengerCount.value} X ${bookQrController.qrFareData.first.finalFare.toString()} = ',
                            textScaler: TextScaleUtil.getScaledText(context,
                                maxScale: 1),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwItems / 2,
                          ),
                          Text(
                            '${bookQrController.passengerCount.value * bookQrController.qrFareData.first.finalFare!}/-',
                            textScaler: TextScaleUtil.getScaledText(context,
                                maxScale: 1),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    '${TTexts.perTicket} ${bookQrController.qrFareData.first.finalFare}/- (${bookQrController.ticketType.value ? TTexts.roundTrip : TTexts.oneWay})',
                    textScaler:
                        TextScaleUtil.getScaledText(context, maxScale: 1),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),

                  // Redeem Points Section - Only display if points redeemed.
                  if (bookQrController.isRedeemed.value &&
                      bookQrController.loyaltyProgramKey.value == 1) ...[
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Redeemed Amount",
                          textScaler: TextScaleUtil.getScaledText(context),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          // bookQrController.qrFareData.first.finalFare! > bookQrController.maxRedemptionAmount.value
                          //     ? '- ${bookQrController.maxRedemptionAmount.value}/-'
                          //     : '0/-',
                          '- ${bookQrController.maxRedemptionAmount.value}/-',
                          textScaler: TextScaleUtil.getScaledText(context),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    Text(
                      'Points redeemed for this order is ${bookQrController.pointsToRedeem} pts',
                      // bookQrController.qrFareData.first.finalFare! > bookQrController.maxRedemptionAmount.value
                      //     ? 'Points redeemed for this order is ${bookQrController.pointsToRedeem} pts'
                      //     : 'Redemption is not permitted for this fare.',
                      textScaler:
                          TextScaleUtil.getScaledText(context, maxScale: 2.5),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],

                  const Divider(),

                  // Final total fare
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        TTexts.totalFare,
                        textScaler:
                            TextScaleUtil.getScaledText(context, maxScale: 1),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Row(
                        children: [
                          Text(
                            '${_getFinalFare()}/-',
                            // BookQrController.instance.qrFareData.first.finalFare! > bookQrController.maxRedemptionAmount.value
                            //             && bookQrController.loyaltyProgramKey.value == 1
                            //     ? '${_getFinalFare()}/-'
                            //     : '${BookQrController.instance.passengerCount.value * BookQrController.instance.qrFareData.first.finalFare!}/-',
                            textScaler: TextScaleUtil.getScaledText(context,
                                maxScale: 1),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // Helper function to calculate final fare after redeeming points
  String _getFinalFare() {
    final bookQrController = BookQrController.instance;

    // Get base fare
    final baseFare = bookQrController.passengerCount.value *
        bookQrController.qrFareData.first.finalFare!;

    // If points are redeemed, deduct the redeemed amount (e.g., 10)
    final finalFare = bookQrController.isRedeemed.value &&
            bookQrController.loyaltyProgramKey.value == 1 &&
            baseFare >= bookQrController.maxRedemptionAmount.value
        ? baseFare - bookQrController.maxRedemptionAmount.value
        : baseFare;

    return finalFare.toString();
  }
}

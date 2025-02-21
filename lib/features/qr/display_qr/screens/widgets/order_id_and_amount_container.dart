import 'package:flutter/material.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/display_qr_controller.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class OrderIdAmountContainer extends StatelessWidget {
  const OrderIdAmountContainer({super.key, required this.tickets});
  final List<TicketsListModel> tickets;
  @override
  Widget build(BuildContext context) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final displayQrController = DisplayQrController.instance;
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
                Text(
                  '${TTexts.rupeeSymbol}${tickets[displayQrController.carouselCurrentIndex.value].finalCost}/-',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.sm,
            ),
            Text(
              'Metro Order Id',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(
              width: screenWidth * .5,
              child: Text(
                tickets[displayQrController.carouselCurrentIndex.value]
                            .orderID !=
                        null
                    ? tickets[displayQrController.carouselCurrentIndex.value]
                        .orderID!
                        .substring(14, 37)
                    : '',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            if (tickets[displayQrController.carouselCurrentIndex.value]
                    .paymentTxnId !=
                null)
              const SizedBox(
                height: TSizes.sm,
              ),
            if (tickets[displayQrController.carouselCurrentIndex.value]
                    .paymentTxnId !=
                null)
              Text(
                'PG Transaction Id',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            if (tickets[displayQrController.carouselCurrentIndex.value]
                    .paymentTxnId !=
                null)
              SizedBox(
                width: screenWidth * .5,
                child: Text(
                  tickets[displayQrController.carouselCurrentIndex.value]
                          .paymentTxnId ??
                      '',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            if (tickets[displayQrController.carouselCurrentIndex.value]
                    .paymentTxnId !=
                null)
              const SizedBox(
                height: TSizes.sm,
              ),
            if (tickets[displayQrController.carouselCurrentIndex.value]
                    .bankReference !=
                null)
              Text(
                'Bank Reference Number',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            if (tickets[displayQrController.carouselCurrentIndex.value]
                    .bankReference !=
                null)
              SizedBox(
                width: screenWidth * .5,
                child: Text(
                  tickets[displayQrController.carouselCurrentIndex.value]
                          .bankReference ??
                      '',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            if (tickets[displayQrController.carouselCurrentIndex.value]
                    .paymentMethod !=
                null)
              const SizedBox(
                height: TSizes.sm,
              ),
            if (tickets[displayQrController.carouselCurrentIndex.value]
                    .paymentMethod !=
                null)
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: 'Paid via ',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                TextSpan(
                  text:
                      '${tickets[displayQrController.carouselCurrentIndex.value].paymentMethod}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ])),
            if (tickets[displayQrController.carouselCurrentIndex.value]
                    .relateTicketId !=
                null)
              const SizedBox(
                height: TSizes.sm,
              ),
            if (tickets[displayQrController.carouselCurrentIndex.value]
                    .relateTicketId !=
                null)
              Text(
                'Related Ticket Id',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            if (tickets[displayQrController.carouselCurrentIndex.value]
                    .relateTicketId !=
                null)
              SizedBox(
                width: screenWidth * .5,
                child: Text(
                  tickets[displayQrController.carouselCurrentIndex.value]
                          .relateTicketId ??
                      '',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
          ],
        )
      ],
    );
  }
}

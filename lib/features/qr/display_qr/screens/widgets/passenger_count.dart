import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';

class PassengerCount extends StatelessWidget {
  const PassengerCount({
    super.key,
    required this.totalTicketCount,
    required this.currentValue,
  });
  final int totalTicketCount;
  final int currentValue;
  @override
  Widget build(BuildContext context) {
    final textScaler = TextScaleUtil.getScaledText(context, maxScale: 3);
    return Row(
      children: [
        Text(TTexts.tickets,
            textScaler: textScaler,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: TColors.dark,
                )),
        const SizedBox(
          width: TSizes.sm,
        ),
        Text(
          '$currentValue/$totalTicketCount',
          textScaler: textScaler,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: TColors.dark,
              ),
        ),
      ],
    );
  }
}

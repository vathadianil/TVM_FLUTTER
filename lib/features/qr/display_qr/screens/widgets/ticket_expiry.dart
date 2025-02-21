import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';

class TicketExpiry extends StatelessWidget {
  const TicketExpiry({
    super.key,
    required this.dateTime,
  });

  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          TTexts.validUpto,
          textScaler: TextScaleUtil.getScaledText(context, maxScale: 3),
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: TColors.black),
        ),
        const SizedBox(
          width: TSizes.defaultSpace / 2,
        ),
        Text(
          dateTime,
          textScaler: TextScaleUtil.getScaledText(context, maxScale: 3),
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: TColors.black, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

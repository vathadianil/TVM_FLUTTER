import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/text_size.dart';

class CarbonEmissionMessage extends StatelessWidget {
  const CarbonEmissionMessage({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            message,
            textScaler: TextScaleUtil.getScaledText(context, maxScale: 3),
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: TColors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

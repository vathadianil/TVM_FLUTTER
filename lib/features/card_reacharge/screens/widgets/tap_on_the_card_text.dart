import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class TapOnTheCardText extends StatelessWidget {
  const TapOnTheCardText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Iconsax.info_circle,
          size: TSizes.md,
        ),
        const SizedBox(
          width: TSizes.xs,
        ),
        Text(
          'Tap on the card to see Last Recharge info',
          style: Theme.of(context).textTheme.labelSmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

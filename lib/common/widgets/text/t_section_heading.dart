import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';

class TSectionHeading extends StatelessWidget {
  const TSectionHeading({
    super.key,
    this.textColor,
    this.showActionBtn = true,
    required this.title,
    this.buttonTitle = 'View All',
    this.onPressed,
    this.onTap,
    this.padding = const EdgeInsets.only(left: TSizes.defaultSpace),
  });

  final Color? textColor;
  final bool showActionBtn;
  final String title, buttonTitle;
  final void Function()? onPressed;
  final VoidCallback? onTap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  textScaler:
                      TextScaleUtil.getScaledText(context, maxScale: 2.5),
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(color: textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (showActionBtn)
                  TextButton(
                    onPressed: onPressed,
                    child: Text(buttonTitle),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

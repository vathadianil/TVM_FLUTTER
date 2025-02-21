import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class MenuTileWidget extends StatelessWidget {
  const MenuTileWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  final String title;
  final String icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final screenWidth = TDeviceUtils.getScreenWidth(context);

    return ListTile(
      visualDensity: VisualDensity.compact,
      onTap: onTap,
      minLeadingWidth: 0,
      leading: SvgPicture.asset(
        icon,
        color: dark ? TColors.accent : TColors.primary,
        height: screenWidth * .05,
      ),
      title: Text(
        title,
        textScaler: TextScaleUtil.getScaledText(context),
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(fontWeight: FontWeight.w400),
      ),
      trailing: title != "Log out"
          ? Icon(
              Icons.arrow_forward_ios_rounded,
              color: TColors.darkGrey,
              size: screenWidth * .04,
            )
          : const SizedBox(),
    );
  }
}

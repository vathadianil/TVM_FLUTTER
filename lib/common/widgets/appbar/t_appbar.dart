import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/features/home/screens/widgets/header_section_container.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    super.key,
    this.title,
    required this.showBackArrow,
    this.actions,
    this.leadingOnPressed,
    this.leadingIcon,
    this.showLogo = true,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final bool showLogo;

  @override
  Widget build(BuildContext context) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    
    return HeaderSectionContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: TColors.primary,
          ),
          automaticallyImplyLeading: false,
          leadingWidth: screenWidth * .08,
          leading: showBackArrow
              ? IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Iconsax.arrow_left,
                    color: TColors.white,
                  ))
              : leadingIcon != null
                  ? IconButton(
                      onPressed: leadingOnPressed, icon: Icon(leadingIcon, color: TColors.white,))
                  : null,
          //title: title,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showLogo)
                Image(
                  width: screenWidth * .065,
                  image: const AssetImage(TImages.appLogo),
                ),
              if (showLogo && title != null) const SizedBox(width: TSizes.sm),
              if (title != null) title!
            ],
          ),
          actions: actions,
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(TDeviceUtils.getAppBarHeight() * 1.4);
}

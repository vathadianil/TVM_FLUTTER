import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

//If you want to add background color to tabs you have wrap them in material widget
//to do that we need [PreferredSizeWidget] and that's what we are creating here

class TTabbar extends StatelessWidget implements PreferredSizeWidget {
  const TTabbar({
    super.key,
    required this.tabs,
    this.controller,
    this.showBorder = true,
  });
  final List<Widget> tabs;
  final TabController? controller;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return TabBar(
      isScrollable: true,
      indicatorColor: TColors.primary,
      labelColor: dark ? TColors.white : TColors.primary,
      unselectedLabelColor: TColors.darkGrey,
      tabs: tabs,
      dividerHeight: .3,
      tabAlignment: TabAlignment.center,
      controller: controller,
      enableFeedback: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}

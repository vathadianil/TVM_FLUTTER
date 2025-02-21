import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({
    super.key,
    required this.onPressed,
    this.iconColor,
    this.notificationCount = 0,
  });

  final VoidCallback onPressed;
  final Color? iconColor;
  final int notificationCount;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = TDeviceUtils.getScreenWidth(context);
    final double iconSize = screenWidth * 0.03;
    final double badgeSize = iconSize * .8;
    return Container(
      alignment: Alignment.center,
      width: screenWidth * .1,
      height: screenWidth * .1,
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: onPressed,
              icon: Icon(
                Iconsax.notification,
                color: iconColor ?? TColors.white,
                size: iconSize,
              ),
            ),
            // Notification Badge

            if (notificationCount > 0)
              Positioned(
                top: constraints.maxHeight * 0.03,
                right: constraints.maxWidth * 0.03,
                child: Container(
                  width: badgeSize,
                  height: badgeSize,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(badgeSize / 2),
                  ),
                  child: Center(
                    child: Text(
                      notificationCount.toString(),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: TColors.white,
                            fontSize: badgeSize * 0.5,
                          ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

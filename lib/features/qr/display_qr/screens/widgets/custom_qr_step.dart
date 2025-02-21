import 'package:flutter/material.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/display_qr_controller.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class CustonQrStep {
  static Step step(DisplayQrController displayQrController,
      BuildContext context, String title, String subTitle,
      {bool isActive = false, String info = '', adoptThemefontColor = false}) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    return Step(
      isActive: isActive,
      state: isActive ? StepState.complete : StepState.disabled,
      title: SizedBox(
        width: screenWidth * .5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (info != '')
              Text(
                info,
                style: adoptThemefontColor
                    ? Theme.of(context).textTheme.bodyLarge
                    : Theme.of(context).textTheme.bodyLarge,
              ),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: adoptThemefontColor
                  ? Theme.of(context).textTheme.bodyLarge
                  : Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
      subtitle: subTitle != ''
          ? Text(
              subTitle,
              style: adoptThemefontColor
                  ? Theme.of(context).textTheme.labelSmall
                  : Theme.of(context).textTheme.labelSmall,
            )
          : null,
      content: const SizedBox.shrink(),
    );
  }
}

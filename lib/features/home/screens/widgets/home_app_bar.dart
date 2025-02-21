// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/widgets/appbar/t_appbar.dart';
// import 'package:tsavaari/common/widgets/notifications/notification_icon.dart';
// import 'package:tsavaari/features/notifications/controllers/notifications_controller.dart';
import 'package:tsavaari/features/profile/controllers/profile_controller.dart';
// import 'package:tsavaari/routes/routes.dart';
// import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
// import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:tsavaari/utils/popups/full_screen_loader.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textScaler = TextScaleUtil.getScaledText(context, maxScale: 1);
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final profileController = Get.put(ProfileController());
    // final notificationController = Get.put(NotificationController());

    // Future<String> _downloadFile(String url, String filename) async {
    //   final response = await http.get(Uri.parse(url));
    //   final directory = await getApplicationDocumentsDirectory();
    //   final file = File('${directory.path}/$filename');
    //   await file.writeAsBytes(response.bodyBytes);
    //   return file.path;
    // }

    return SizedBox(
      height: screenWidth * .085,
      // height: screenWidth <= TSizes.smallSceenSize
      // ? screenWidth * .35
      // : screenWidth <= TSizes.mediumScreenSize
      //     ? screenWidth * .3
      //     : screenWidth <= TSizes.largeScreenSize
      //         ? screenWidth * .2
      //         : screenWidth * .18, // For larger screens
      child: TAppBar(
        showBackArrow: false,
        showLogo: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              width: screenWidth * .03,
              image: const AssetImage(TImages.appLogo),
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => SizedBox(
                      width: screenWidth * .45,
                      child: Text(
                        'Hi, ${profileController.rxFirstName.value}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textScaler: textScaler,
                        style: Theme.of(context).textTheme.headlineSmall!.apply(
                              color: TColors.white,
                            ),
                      ),
                    )),
                SizedBox(
                  width: screenWidth * .45,
                  child: Text(TTexts.homeAppbarTitle,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .apply(color: TColors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textScaler:
                          TextScaleUtil.getScaledText(context, maxScale: 2)),
                ),
              ],
            ),
          ],
        ),
        // actions: [
        //   // InkWell(
        //   //   onTap: () async {
        //   //     TFullScreenLoader.openLoadingDialog(
        //   //       isGifanimation: false,
        //   //       'Loading...',
        //   //       TImages.paymentInProgress,
        //   //     );
        //   //     final path = await _downloadFile(
        //   //         ApiEndPoint.splashImageUrl, 'splash_image.png');
        //   //     await Share.shareXFiles([XFile(path)],
        //   //         text: '${TTexts.shareApp}\n${TTexts.plaStoreLink}');
        //   //     TFullScreenLoader.stopLoading();
        //   //   },
        //   //   child: Column(
        //   //     mainAxisAlignment: MainAxisAlignment.center,
        //   //     children: [
        //   //       Icon(
        //   //         Icons.share,
        //   //         color: TColors.white,
        //   //         size: screenWidth * .02,
        //   //       ),
        //   //       Text(
        //   //         TTexts.share,
        //   //         textScaler: TextScaleUtil.getScaledText(context, maxScale: 1),
        //   //         style: Theme.of(context)
        //   //             .textTheme
        //   //             .labelSmall!
        //   //             .copyWith(color: TColors.white),
        //   //       )
        //   //     ],
        //   //   ),
        //   // ),
        //   // Obx(() => NotificationIcon(
        //   //       notificationCount:
        //   //           notificationController.firebaseNotificationCount.value,
        //   //       // notificationCount:
        //   //       //     notificationController.notificationsList.length.toString(),
        //   //       onPressed: () {
        //   //         Get.toNamed(Routes.notificationsPage);
        //   //         // Reset count when notifications icon is clicked
        //   //         notificationController.resetNotificationCount();
        //   //       },
        //   //     )),
        // ],
      ),
    );
  }
}

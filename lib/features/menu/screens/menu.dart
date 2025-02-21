import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:tsavaari/common/widgets/appbar/t_appbar.dart';
import 'package:tsavaari/common/widgets/containers/t_circular_container.dart';
import 'package:tsavaari/features/authentication/login/controllers/login_controller.dart';
import 'package:tsavaari/features/home/screens/widgets/social_media_popup.dart';
import 'package:tsavaari/features/menu/controllers/menu_controller.dart';
import 'package:tsavaari/features/menu/screens/widgets/content_web_page.dart';
import 'package:tsavaari/features/menu/screens/widgets/menu_tile.dart';
import 'package:tsavaari/features/menu/screens/widgets/user_info_card.dart';
import 'package:tsavaari/features/reward_points/controllers/reward_points_controller.dart';
import 'package:tsavaari/routes/routes.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';
import 'package:tsavaari/utils/popups/loaders.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    Get.put(LoginController());
    final rewardPointsController = Get.put(RewardPointsController());
    //final controller = Get.put(MenuContentController());

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: false,
        title: Text(
          'Profile',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: TColors.white),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              LoginController.instance.logout();
            },
            icon: const Icon(
              Iconsax.logout,
              color: TColors.white,
            ),
            label: Text(
              'Logout',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: TColors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (rewardPointsController.isLoadingPointsSummary.value) {
            return const Center(
              child: CircularProgressIndicator(), 
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal:TSizes.md,
                  vertical: TSizes.sm,),
              child: Column(
                children: [
                  const UserInfoWidget(),
                  const SizedBox(height: TSizes.sm),
                  TCircularContainer(
                    width: screenWidth,
                    applyBoxShadow: true,
                    backgroundColor: dark ? TColors.dark : TColors.white,
                    boxShadowColor:
                        dark ? TColors.accent.withOpacity(.3) : TColors.accent,
                    radius: TSizes.borderRadiusLg,
                    child: Column(children: [
                      if (rewardPointsController.loyaltyProgramKey.value == 1)
                      MenuTileWidget(
                        icon: TImages.drawerBalance,
                        title: TTexts.rewardPointsTitle,
                        onTap: () => Get.toNamed(Routes.rewardPoints),
                      ),
                      // MenuTileWidget(
                      //   icon: TImages.drawerBalance,
                      //   title: 'View Balance /Recharge',
                      //   onTap: () => Get.toNamed(Routes.cardReacharge),
                      // ),
                      MenuTileWidget(
                        icon: TImages.drawerProfile,
                        title: 'My Profile',
                        onTap: () => Get.toNamed(Routes.profilePage),
                      ),
                      // MenuTileWidget(
                      //   icon: TImages.drawerCalc,
                      //   title: 'Fare Calculation',
                      //   onTap: () => Get.toNamed(Routes.fareCalculator),
                      // ),
                      MenuTileWidget(
                        icon: TImages.drawerMedia,
                        title: 'Media',
                        onTap: () {
                          Get.dialog(const Dialog(
                            child: SocialMediaPopup(),
                          ));
                          printStorageValues();
                        },
                      ),
                      MenuTileWidget(
                        icon: TImages.youtubeBlueIcon,
                        title: 'Channel',
                        onTap: () async {
                          final Uri url = Uri.parse(
                              'https://www.youtube.com/@ltmetrorailhyd');
                          try {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          } catch (e) {
                            print('Error launching URL: $e');
                          }
                        },
                      ),
                    ]),
                  ),
                  const SizedBox(height: TSizes.md,),
                  TCircularContainer(
                    width: screenWidth,
                    applyBoxShadow: true,
                    backgroundColor: dark ? TColors.dark : TColors.white,
                    boxShadowColor:
                        dark ? TColors.accent.withOpacity(.3) : TColors.accent,
                    radius: TSizes.borderRadiusLg,
                    child: Column(children: [
                      MenuTileWidget(
                        icon: TImages.drawerBell,
                        title: 'Notifications',
                        onTap: () => Get.toNamed(Routes.notificationsPage),
                      ),
                      MenuTileWidget(
                        icon: TImages.drawerFeedback,
                        title: 'Feedback',
                        onTap: () => Get.toNamed(Routes.feedbackPage),
                      ),
                      MenuTileWidget(
                        icon: TImages.drawerTerms,
                        title: 'Emergency SOS',
                        onTap: () => _handleSOSAppLaunch(context),
                      ),

                    ]),
                  ),
                  // SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
                  // TCircularContainer(
                  //   width: screenWidth,
                  //   applyBoxShadow: true,
                  //   backgroundColor: dark ? TColors.dark : TColors.white,
                  //   boxShadowColor:
                  //       dark ? TColors.accent.withOpacity(.3) : TColors.accent,
                  //   radius: TSizes.borderRadiusLg,
                  //   child: Obx(() {
                  //     //Loader
                  //     if (controller.isLoading.value) {
                  //       return const ShimmerEffect(
                  //           width: double.infinity, height: 180);
                  //     }

                  //     //No data found
                  //     if (controller.contentList.isEmpty) {
                  //       return Container();
                  //     }

                  //     return Column(
                  //       children: controller.contentList.map((content) {
                  //         return MenuTileWidget(
                  //             icon: TImages.drawerTerms,
                  //             title: content.contentTitle ?? '',
                  //             onTap: () {
                  //               if (content.contentPageUrl != null &&
                  //                   content.contentPageUrl!.isNotEmpty) {
                  //                 Get.to(
                  //                   () => ContentWebViewPage(
                  //                     url: content.contentPageUrl!,
                  //                     title: content.contentTitle ?? '',
                  //                   ),
                  //                 );
                  //               } else {
                  //                 TLoaders.warningSnackBar(
                  //                     title: 'Oh Snap!',
                  //                     message: "No link available");
                  //               }
                  //             });
                  //       }).toList(),
                  //     );
                  //   }),
                  // ),
                  const SizedBox(height: TSizes.md,),
                  TCircularContainer(
                    width: screenWidth,
                    applyBoxShadow: true,
                    backgroundColor: dark ? TColors.dark : TColors.white,
                    boxShadowColor:
                        dark ? TColors.accent.withOpacity(.3) : TColors.accent,
                    radius: TSizes.borderRadiusLg,
                    child: MenuTileWidget(
                      onTap: () {
                        LoginController.instance.logout();
                      },
                      title: "Log out",
                      icon: TImages.drawerLogout,
                    ),
                  ),
                  const SizedBox(height: TSizes.xl),
                ],
              ),
            ),
          );
        
        }),
      ),
    );
  }

  Future<void> _handleSOSAppLaunch(BuildContext context) async {
    const packageName = 'com.tswomensafety.tsafe'; // Package name of the app

    // Check if the app is installed
    bool isInstalled = false;
    try {
      // Fetch details of installed app using package name
      AppInfo? app = await InstalledApps.getAppInfo(packageName);
      isInstalled = app != null;
    } catch (e) {
      isInstalled = false;
    }

    if (isInstalled) {
      // Launch the installed app
      InstalledApps.startApp(packageName);
    } else {
      // Open Play Store if the app is not installed
      final Uri url = Uri.parse(
        'https://play.google.com/store/apps/details?id=$packageName',
      );
      try {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } catch (e) {
        print('Error launching URL: $e');
      }
    }
  }


  void printStorageValues() {
    final box = GetStorage();
    final keys = box.getKeys();

    if (keys.isEmpty) {
      print("Storage is empty.");
    } else {
      for (var key in keys) {
        print('Key: $key, Value: ${box.read(key)}');
      }
    }
  }
}
 
        
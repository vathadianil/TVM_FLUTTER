import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/popups/full_screen_loader.dart';
import 'package:tsavaari/utils/popups/loaders.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaPopup extends StatelessWidget {
  const SocialMediaPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = TDeviceUtils.getScreenHeight();
    final screenWidth = TDeviceUtils.getScreenWidth(context);

    launchURL(String staticUrl, {mode = 'web'}) async {
      try {
        TFullScreenLoader.openLoadingDialog(
            'Opening Website', TImages.trainAnimation);
        final Uri url = Uri.parse(staticUrl);
        if (mode == 'web') {
          await launchUrl(url);
        } else {
          await launchUrl(
            url,
            mode: LaunchMode.externalApplication,
          );
        }
      } catch (e) {
        TLoaders.errorSnackBar(
            title: 'Error Occured', message: 'Could not launch website');
      } finally {
        TFullScreenLoader.stopLoading();
      }
    }

    return Container(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      decoration: BoxDecoration(
        color:
            THelperFunctions.isDarkMode(context) ? TColors.dark : TColors.white,
        borderRadius: BorderRadius.circular(TSizes.md),
      ),
      child: SizedBox(
        height: screenHeight / 2,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Thanks',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                Text(
                  'for traveling with us',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                Text(
                  'For more information follow us on',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections / 4,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          launchURL(
                            ApiEndPoint.facebookUrl,
                            mode: 'app',
                          );
                        },
                        child: Image.asset(
                          width: screenWidth * .15,
                          TImages.facebook,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          launchURL(
                            ApiEndPoint.twitterUrl,
                            mode: 'app',
                          );
                        },
                        child: Image.asset(
                          width: screenWidth * .10,
                          TImages.twitter,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          launchURL(
                            ApiEndPoint.instagramUrl,
                            mode: 'app',
                          );
                        },
                        child: Image.asset(
                          width: screenWidth * .15,
                          TImages.instagram,
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          launchURL(
                            ApiEndPoint.youtubeUrl,
                            mode: 'app',
                          );
                        },
                        child: Image.asset(
                          width: screenWidth * .15,
                          TImages.youtube,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          launchURL(
                            ApiEndPoint.linkedInUrl,
                            mode: 'app',
                          );
                        },
                        child: Image.asset(
                          width: screenWidth * .15,
                          TImages.linkedin,
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     launchURL(
                      //       ApiEndPoint.googlePlusUrl,
                      //       mode: 'app',
                      //     );
                      //   },
                      //   child: Image.asset(
                      //     width: screenWidth * .15,
                      //     TImages.googlePlus,
                      //   ),
                      // ),
                      // InkWell(
                      //   onTap: () {
                      //     launchURL(
                      //       ApiEndPoint.blogUrl,
                      //     );
                      //   },
                      //   child: Image.asset(
                      //     width: screenWidth * .15,
                      //     TImages.blog,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Iconsax.close_circle),
                color: TColors.darkGrey,
              ),
            )
          ],
        ),
      ),
    );
  }
}

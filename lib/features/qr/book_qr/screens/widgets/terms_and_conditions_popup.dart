import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/common/widgets/button/underlined_text_button.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/popups/full_screen_loader.dart';
import 'package:tsavaari/utils/popups/loaders.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsandConditionsPopup extends StatelessWidget {
  const TermsandConditionsPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    launchURL() async {
      try {
        TFullScreenLoader.openLoadingDialog(
            'Opening Website', TImages.trainAnimation);
        final Uri url = Uri.parse(ApiEndPoint.hydMetroWebsiteUrl);
        await launchUrl(url);
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
        height: TDeviceUtils.getScreenHeight() * .6,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Iconsax.book,
                          color: isDark ? TColors.accent : TColors.primary,
                        ),
                        const SizedBox(
                          width: TSizes.sm,
                        ),
                        Text(
                          TTexts.termsConditions,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color:
                                    isDark ? TColors.accent : TColors.primary,
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Iconsax.close_circle),
                    color: TColors.darkGrey,
                  ),
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              const Text(TTexts.termsAndConditionsText),
              UnderLinedTextButton(
                btnText: TTexts.webSiteText,
                onPressed: () {
                  launchURL();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

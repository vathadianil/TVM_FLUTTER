import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tsavaari/common/widgets/appbar/t_appbar.dart';
import 'package:tsavaari/common/widgets/layout/max_width_container.dart';
import 'package:tsavaari/features/reward_points/screens/widgets/loyalty_points_history.dart';
import 'package:tsavaari/features/reward_points/screens/widgets/loyalty_points_info_container.dart';
import 'package:tsavaari/routes/routes.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class RewardPointsScreen extends StatelessWidget {
  const RewardPointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          TTexts.rewardPointsTitle,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: TColors.white),
          textScaler: TextScaleUtil.getScaledText(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: SafeArea(
          child: Center(
            child: MaxWidthContaiiner(
              child: Column(
                children: [
                  //---Loyalty Points Info Container
                  const LoyaltyPointsInfoContainer(),
                  
                  SizedBox(
                    height: screenWidth * .05,
                  ),
      
                  Row(
                    children: [
                      //---Book Ticket Container..
                      Expanded(
                        child: SizedBox(
                          height: screenWidth * .45,
                          child: Container(
                            padding: const EdgeInsets.all(TSizes.md),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: THelperFunctions.isDarkMode(context)
                                    ? TColors.accent
                                    : TColors.primary,
                              ),
                              borderRadius: BorderRadius.circular(
                                TSizes.md,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // SizedBox(
                                //   width: screenWidth * .3,
                                //   child: Text(
                                //     'Earn by Booking Qr Tickets',
                                //     maxLines: 2,
                                //     overflow: TextOverflow.ellipsis,
                                //     style: Theme.of(context).textTheme.labelSmall,
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: screenWidth * .05,
                                // ),
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1, color: TColors.grey),
                                    borderRadius:
                                        BorderRadius.circular(TSizes.borderRadiusMd),
                                  ),
                                  width: screenWidth * .2,
                                  child: QrImageView(
                                    data: 'https://www.ltmetro.com',
                                    size: screenWidth * .2,
                                    embeddedImage: const AssetImage(
                                      TImages.appLogo,
                                    ),
                                    backgroundColor: TColors.white,
                                    embeddedImageStyle: QrEmbeddedImageStyle(
                                      size: Size(
                                        screenWidth * .08,
                                        screenWidth * .08,
                                      ),
                                    ),
                                  ),
                                ),
                              
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: TColors.primary,
                                    side: BorderSide(
                                      color: isDark
                                          ? TColors.accent
                                          : TColors.secondary,
                                    ),
                                    elevation: TSizes.sm,
                                    shadowColor:
                                        isDark ? TColors.accent : TColors.darkGrey,
                                    minimumSize:
                                        Size(screenWidth * .1, screenWidth * .05),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: TSizes.sm,
                                      horizontal: TSizes.md,
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.toNamed(Routes.bookQr);
                                  },
                                  child: Text(
                                    'Book Ticket',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                          color: TColors.white,
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: screenWidth * .05,
                      ),
                      
                      //---Card Recharge Container..
                      Expanded(
                        child: SizedBox(
                          height: screenWidth * .45,
                          child: Container(
                            padding: const EdgeInsets.all(TSizes.md),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: THelperFunctions.isDarkMode(context)
                                    ? TColors.accent
                                    : TColors.primary,
                              ),
                              borderRadius: BorderRadius.circular(
                                TSizes.md,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // SizedBox(
                                //   width: screenWidth * .2,
                                //   child: Text(
                                //     'Earn more by Recharging your Metro card',
                                //     overflow: TextOverflow.ellipsis,
                                //     maxLines: 2,
                                //     style: Theme.of(context).textTheme.labelSmall,
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: screenWidth * .05,
                                // ),
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1, color: TColors.grey),
                                    borderRadius:
                                        BorderRadius.circular(TSizes.borderRadiusMd),
                                  ),
                                  child: Image(
                                    fit: BoxFit.fill,
                                    width: screenWidth * .25,
                                    image: const AssetImage(
                                      TImages.metroCardFrontside,
                                    ),
                                  ),
                                ),
                          
                                SizedBox(
                                  height: screenWidth * .05,
                                ),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: TColors.primary,
                                    side: BorderSide(
                                      color: isDark
                                          ? TColors.accent
                                          : TColors.secondary,
                                    ),
                                    elevation: TSizes.sm,
                                    shadowColor:
                                        isDark ? TColors.accent : TColors.darkGrey,
                                    minimumSize:
                                        Size(screenWidth * .1, screenWidth * .05),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: TSizes.sm,
                                      horizontal: TSizes.md,
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.toNamed(Routes.cardReacharge);
                                  },
                                  child: Text(
                                    'Topup',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                          color: TColors.white,
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ), 
                  
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  //---Loyalty History..
                  const LoyaltyPointsHistory(),
                ],
              ),
            ),
          ),
      
        ),
      ),
    );
  }

  
}

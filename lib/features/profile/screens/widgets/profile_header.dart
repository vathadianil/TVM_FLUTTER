import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/features/profile/controllers/profile_controller.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader({super.key});
  final profileController = ProfileController.instance;

  @override
  Widget build(BuildContext context) {
    return _buildHeader(context);
  }

  Widget _buildHeader(BuildContext context) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final screenHeight = TDeviceUtils.getScreenHeight();

    return Stack(
      children: [
        Container(
          height: screenHeight * .1,
          width: screenWidth,
          decoration: BoxDecoration(
            color: TColors.primary,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(
                screenWidth,
                screenHeight * .14,
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(top: screenHeight * .02),
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildProfileImage(context),
                //_buildCameraIcon(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage(context) {
    return Container(
      width: TDeviceUtils.getScreenWidth(context) * .4,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(color: TColors.primary, blurRadius: TSizes.md)
        ],
        color: const Color.fromARGB(255, 243, 241, 246),
        border: Border.all(color: TColors.accent, width: 3),
      ),
      child: Padding(
          padding: const EdgeInsets.all(TSizes.spaceBtwItems),
          child: Obx(
            () => Lottie.asset(
                profileController.selectedGender.value == 'Male'
                    ? TImages.maleAvatar
                    : TImages.femaleAvatar,
                width: TDeviceUtils.getScreenWidth(context) * .4),
          )),
    );
  }

  // Widget _buildCameraIcon(BuildContext context) {
  //   return Positioned(
  //     bottom: 0,
  //     right: 0,
  //     child: GestureDetector(
  //       onTap: () {
  //         const ImageSourceModalSheet().showImageSourceModalSheet(context); // Open dialog to choose camera or gallery
  //       },
  //       child: SvgPicture.asset(
  //         TImages.cameraIconBordered,
  //         height: SizeConfig.blockSizeHorizontal * 10,
  //       ),
  //     ),
  //   );
  // }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/authentication/otp/controllers/otp_controller.dart';
import 'package:tsavaari/features/authentication/otp/screens/widgets/otp_input_field.dart';
import 'package:tsavaari/features/authentication/otp/screens/widgets/submit_button.dart';
import 'package:tsavaari/features/station_facilities/screens/widgets/floating_action_btn.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class OtpInputScreen extends StatelessWidget {
  const OtpInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final otpController = Get.put(OtpController());

    return Scaffold(
      backgroundColor: TColors.primary,
      floatingActionButton: const FloatingActionBtn(
        backgroundColor: TColors.white,
        iconColor: TColors.dark,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: _buildUI(otpController),
    );
  }

  Widget _buildUI(OtpController otpController) {
    return Column(
      children: [
        const SizedBox(height: TSizes.spaceBtwSections * 3),
        _buildOtpSvg(),
        const SizedBox(height: TSizes.spaceBtwSections),
        _buildInstructionText(otpController),
        const SizedBox(height: TSizes.spaceBtwSections),
        _buildOtpFormContainer(otpController),
      ],
    );
  }

  Widget _buildOtpSvg() {
    final screenWidth = TDeviceUtils.getScreenWidth(Get.context!);
    return SvgPicture.asset(
      TImages.otpImage,
      height: screenWidth * 0.05,
    );
  }

  Widget _buildInstructionText(OtpController otpController) {
    return Text(
        'Please enter the OTP sent to your\nmobile number ending with ${maskMobileNumber(otpController.mobileNo)}',
        textAlign: TextAlign.center,
        textScaler: TextScaleUtil.getScaledText(Get.context!),
        style: Theme.of(Get.context!)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.w500, color: TColors.white));
  }

  Widget _buildOtpFormContainer(OtpController otpController) {
    final dark = THelperFunctions.isDarkMode(Get.context!);
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: dark ? TColors.dark : TColors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(TSizes.borderRadiusXL * 2.5),
          ),
        ),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(TSizes.lg),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: TSizes.spaceBtwSections * 2),
                OtpInputField(otpController: otpController),
                const SizedBox(height: TSizes.spaceBtwSections),
                _buildResendSection(otpController),
                const SizedBox(height: TSizes.spaceBtwSections),
                const OTPSubmitButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResendSection(OtpController otpController) {
    return Column(
      children: [
        Text(
          "Didn't receive an OTP ?",
          style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: TColors.darkGrey,
              ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Obx(() {
          // Display either the timer or the "Resend OTP" button
          if (otpController.isResendButtonDisabled.value) {
            final minutes = (otpController.resendTimer.value ~/ 60)
                .toString()
                .padLeft(2, '0');
            final seconds = (otpController.resendTimer.value % 60)
                .toString()
                .padLeft(2, '0');
            return Text(
              'Resend OTP in $minutes:$seconds',
              style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: TColors.grey,
                  ),
            );
          } else {
            return GestureDetector(
              onTap: () => otpController.resendOTP(),
              child: Text(
                'Resend OTP',
                style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: TColors.success, // Active color
                    ),
              ),
            );
          }
        }),
      ],
    );
  }

  String maskMobileNumber(String mobileNumber) {
    if (mobileNumber.length >= 3) {
      return '***${mobileNumber.substring(mobileNumber.length - 3)}';
    } else {
      return mobileNumber; // Return as-is if the number is too short
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/widgets/button/custom_elevated_btn.dart';
import 'package:tsavaari/features/authentication/otp/controllers/otp_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';

class OTPSubmitButton extends StatelessWidget {
  const OTPSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =  OtpController.instance;
    final textScaler = TextScaleUtil.getScaledText(context);

    return Obx(() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.xl),
        child: CustomElevatedBtn(
          onPressed: () => controller.verifyOTP(),
          child: controller.isLoading.value
            ? Transform.scale(
                scale: .5,
                child:
                    const CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(
                          TColors.primary),
                ),
              )
            : Text(
                'Submit',
                textScaler: textScaler,
              ),
        ),
      )
    );
  }
}
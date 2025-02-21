import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/widgets/button/custom_elevated_btn.dart';
import 'package:tsavaari/features/authentication/register/controllers/registration_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/text_size.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =  RegistrationController.instance;
    final textScaler = TextScaleUtil.getScaledText(context);

    return Obx(() {
      return SizedBox(
        width: double.infinity,
        child: CustomElevatedBtn(
          onPressed: controller.isLoading.value
              ? null
              : () => controller.onTapRegister(),
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
                  'Register',
                  textScaler: textScaler,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(
                          color: TColors.white,
                          fontWeight: FontWeight.bold),
                ),
        ),
      );
    });
  }
}
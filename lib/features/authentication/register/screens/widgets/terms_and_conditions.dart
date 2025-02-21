import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/widgets/button/underlined_text_button.dart';
import 'package:tsavaari/features/authentication/register/controllers/registration_controller.dart';
import 'package:tsavaari/features/authentication/register/screens/widgets/sign_up_terms_condition_popup.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =  RegistrationController.instance;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(
          () => Transform.scale(
            scale: 0.7, 
            alignment: Alignment.centerLeft,
            child: Switch(
              value: controller.agreedToTerms.value,
              // onChanged: controller.toggleAgreement,
              onChanged: (bool value) {
                if (value) {
                  Get.dialog(const Dialog(
                    child: SignUpTermsandConditionsPopup(),
                  ));
                } else {
                  controller.agreedToTerms.value = false;
                }
              },
              activeColor: TColors.primary,
              activeTrackColor: TColors.accent,
              inactiveThumbColor: TColors.grey,
              inactiveTrackColor: TColors.lightGrey,
            ),
          ),
        ),
        // Obx(() => Checkbox(
        //       checkColor: AppColors.whiteColor,
        //       activeColor: TColors.primary,
        //       value: controller.agreedToTerms.value,
        //       onChanged: controller.toggleAgreement,
        //     )),
        Text("Agree With", 
          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
          style: Theme.of(context).textTheme.labelSmall,
        ),
        // GestureDetector(
        //   onTap: () {
        //     // Navigate to Terms & Conditions
        //   },
        //   child: Text(
        //     "Terms & Conditions",
        //     textScaler: TextScaleUtil.getScaledText(context, maxScale: 2.5),
        //     style: Theme.of(context).textTheme.labelSmall!.copyWith(
        //         fontWeight: FontWeight.bold,
        //         color: dark ? TColors.accent : TColors.primary),
        //   )
        // ),
        UnderLinedTextButton(
          btnText: TTexts.termsConditions,
          onPressed: () {
            Get.dialog(const Dialog(
              child: SignUpTermsandConditionsPopup(),
            ));
          },
        ),
      
      ],
    );
  }
}


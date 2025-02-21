import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/widgets/button/custom_elevated_btn.dart';
// import 'package:tsavaari/common/widgets/layout/max_width_container.dart';
import 'package:tsavaari/features/authentication/login/controllers/login_controller.dart';
import 'package:tsavaari/features/authentication/login/screens/widgets/form_divider.dart';
import 'package:tsavaari/features/authentication/login/screens/widgets/redirect_to_signup.dart';
import 'package:tsavaari/features/home/screens/widgets/banner_image_slider.dart';
import 'package:tsavaari/utils/constants/banner_page_type.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';

import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/validators/validation.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final textScaler = TextScaleUtil.getScaledText(context);
    final screenHeight = TDeviceUtils.getScreenHeight();
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    return Scaffold(
      body: SizedBox(
        height: screenHeight,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: TSizes.appBarHeight,
                      left: TSizes.defaultSpace,
                      right: TSizes.defaultSpace,
                    ),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // -- Logo
                          Image(
                            width: screenWidth * .1,
                            image: const AssetImage(TImages.appLogoSignIn),
                          ),

                          const SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),
                          //--Heading

                          Text(
                            TTexts.loginTitle,
                            style: Theme.of(context).textTheme.headlineLarge,
                            textScaler: TextScaler.linear(
                                ScaleSize.textScaleFactor(context)),
                          ),

                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),

                          Text(
                            TTexts.loginSubTitle,
                            style: Theme.of(context).textTheme.bodyMedium,
                            textScaler: textScaler,
                          ),

                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          //--Login Form

                          TextFormField(
                            keyboardType: TextInputType.phone,
                            onChanged: controller.onMobileNumberChanged,
                            maxLength: 10,
                            validator: TValidator.validatePhoneNumber,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              label: Text(
                                TTexts.phoneNo,
                                style: Theme.of(context).textTheme.bodyMedium,
                                textScaler: textScaler,
                              ),
                              prefixIcon: const Icon(
                                Icons.call,
                                color: TColors.primary,
                              ),
                              counterText:
                                  "", // Hides the character counter text
                            ),
                          ),

                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          Obx(() {
                            return SizedBox(
                              width: double.infinity,
                              child: CustomElevatedBtn(
                                onPressed: controller.isLoading.value
                                    ? null
                                    : controller.login,
                                child: controller.isLoading.value
                                    ? Transform.scale(
                                        scale: .5,
                                        child: const CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  TColors.primary),
                                        ),
                                      )
                                    : Text(
                                        TTexts.signIn,
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
                          }),

                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),

                          const FormDivider(dividerText: TTexts.dividerText),

                          //Sign Up Redirect
                          const RedirectToSignUp(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  //-- Display Google Ads Or Banners
                  // BannerImageSlider(
                  //   autoPlay: true,
                  //   pageType: BannerPageType.loginPage,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

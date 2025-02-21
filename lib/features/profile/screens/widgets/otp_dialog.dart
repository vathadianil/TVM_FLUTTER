import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:tsavaari/common/widgets/button/custom_elevated_btn.dart';
import 'package:tsavaari/features/profile/controllers/profile_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class OTPConfirmationDialog extends StatelessWidget {
  const OTPConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void showUpdateProfileOtpDialog(BuildContext context, String? responseOTP) {
    final profileController = ProfileController.instance;
    
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), 
          ),
          child: Padding(
            padding: const EdgeInsets.all(TSizes.xl), 
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Enter OTP',
                ),
                const SizedBox(height: TSizes.md), 
                ProfileOtpInputField(responseOTP: responseOTP),
                const SizedBox(height: TSizes.lg), 
                CustomElevatedBtn(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: TSizes.xl / 2),
                    child: Text(
                      'Submit', 
                    ),
                  ),
                  
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    
                    if (profileController.validateOtp()) {
                      // Check if entered OTP matches response OTP
                      if (responseOTP != null && profileController.otpCode.value == responseOTP) {
                        profileController.updateUserRecord();
                      } else {
                        Get.snackbar(
                          'Enter valid OTP',
                          'Incorrect OTP. Please try again.',
                          backgroundColor: TColors.error,
                          colorText: TColors.white,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}


class ProfileOtpInputField extends StatelessWidget {
  final String? responseOTP;

  const ProfileOtpInputField({
    super.key,
    required this.responseOTP,
  });

  @override
  Widget build(BuildContext context) {
    final profileController = ProfileController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    final screenWidth = TDeviceUtils.getScreenWidth(context);


    return Form(
      key: profileController.otpFormKey, 
      child: Pinput(
        length: 6,
        closeKeyboardWhenCompleted: true,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        defaultPinTheme: PinTheme(
          height: screenWidth * 0.12, 
          width: screenWidth * 0.12, 
          textStyle: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), 
            color: dark ? TColors.dark : TColors.white,
            boxShadow: [
              BoxShadow(
                color: dark ? TColors.accent.withOpacity(.3) : TColors.accent,
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(3, 2), 
              ),
            ],
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the OTP';
          } else if (value.length != 6) {
            return 'OTP should be 6 digits';
          }
          return null; 
        },
      
         onChanged: (value) {
          profileController.updateOtpCode(value);
        },
        onSubmitted: (value) {
          if (profileController.validateOtp()) {
            // Check if entered OTP matches response OTP on submission
            if (responseOTP != null && value != responseOTP) {
              // Show error message for incorrect OTP
              Get.snackbar(
                'Enter valid OTP',
                'Incorrect OTP. Please try again.',
                backgroundColor: TColors.error,
                colorText: TColors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          }
        },
        // onSubmitted: (value) {
        //   profileController.validateOtp();
        // },
        errorTextStyle: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(
                  color: TColors.error,
                  fontWeight: FontWeight.w600),
        // Customize the error theme
        errorPinTheme: PinTheme(
          height: screenWidth * 0.12, 
          width: screenWidth * 0.12, 
          textStyle: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(
                  color:  TColors.error,
                  fontWeight: FontWeight.bold),
          
          
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), 
            color: dark ? TColors.dark : TColors.white,
            border: Border.all(color:  TColors.error), 
          ),
        ),
      ),
    );
  }

}


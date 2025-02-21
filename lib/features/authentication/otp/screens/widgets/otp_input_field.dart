import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:tsavaari/features/authentication/otp/controllers/otp_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class OtpInputField extends StatelessWidget {
  final OtpController otpController;

  const OtpInputField({
    super.key,
    required this.otpController,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final screenWidth = TDeviceUtils.getScreenWidth(context);

    return Form(
      key: otpController.formKey,
      child: Pinput(
        length: 6,
        //obscureText: true,
        closeKeyboardWhenCompleted: true,
        //obscuringCharacter: "*",
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        defaultPinTheme: PinTheme(
          height: screenWidth * 0.05,
          width: screenWidth * 0.05,
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
          otpController.updateOtpCode(value);
        },

        // Add an onSubmitted callback if you want to handle submission
        onSubmitted: (value) {
          otpController.validateOtp();
        },
        // submittedPinTheme: PinTheme(
        //   height: SizeConfig.blockSizeVertical * 6,
        //   width: SizeConfig.blockSizeHorizontal * 15,
        //   textStyle: TextStyle(
        //     fontSize: SizeConfig.blockSizeHorizontal * 6,
        //     color: const Color.fromARGB(255, 41, 124, 44), // Change text color for error state
        //     fontWeight: FontWeight.w600,
        //   ),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(12),
        //     color: AppColors.whiteColor,
        //     border: Border.all(color: const Color.fromARGB(255, 41, 124, 44),), // Border color for error
        //   ),
        // ),

        errorTextStyle: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: TColors.error, fontWeight: FontWeight.w600),
        // Customize the error theme
        errorPinTheme: PinTheme(
          height: screenWidth * 0.12,
          width: screenWidth * 0.12,
          textStyle: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: TColors.error, fontWeight: FontWeight.bold),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: dark ? TColors.dark : TColors.white,
            border: Border.all(color: TColors.error),
          ),
        ),
      ),
    );
  }
}



// class OtpInputField extends StatelessWidget {
//   final OtpController otpController;

//   const OtpInputField({
//     super.key, 
//     required this.otpController,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);
//     SizeConfig.init(context);

//     return Form(
//       key: otpController.formKey, 
//       child: Obx(() => PinFieldAutoFill(
//         decoration: BoxLooseDecoration(
//           radius: const Radius.circular(TSizes.borderRadiusLg),
//           strokeColorBuilder: FixedColorBuilder(
//             dark ? TColors.accent.withOpacity(.3) : TColors.accent,
//           ),
//           bgColorBuilder: FixedColorBuilder(
//             dark ? TColors.dark : TColors.white,
//           ),
//         ),
//         currentCode: otpController.otpCode.value,
//         codeLength: 6,
//         autoFocus: true,
//         cursor: Cursor(
//           width: 2,
//           height: 24,
//           color: TColors.primary,
//           enabled: true
//         ),
//         onCodeSubmitted: (code) {
//           otpController.updateOtpCode(code);
//           otpController.validateOtp();
//         },
//         onCodeChanged: (code) {
//           if (code != null) {
//             otpController.updateOtpCode(code);
//           }
//         },
//       )),
//     );
//   }
// }
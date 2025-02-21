import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tsavaari/bottom_navigation/bottom_navigation_menu.dart';
import 'package:tsavaari/data/repositories/authentication/authenticaion_repository.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/helpers/network_manager.dart';
import 'package:tsavaari/utils/local_storage/storage_utility.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class OtpController extends GetxController {
  static OtpController get instance => Get.find();
  
  // Reactive variables
  final deviceStorage = GetStorage();
  RxString otpCode = ''.obs;
  RxBool isOtpValid = false.obs;
  RxBool isLoading = false.obs;

  // Timer-related variables
  RxBool isResendButtonDisabled = true.obs;
  RxInt resendTimer = 180.obs; // 3 minutes timer in seconds
  Timer? _timer;


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final mobileNo = TLocalStorage().readData('mobileNo') ?? '';

  @override
  void onInit() {
    super.onInit();
    startResendTimer();
  }

  // Method to validate OTP
  bool validateOtp() {
    isOtpValid.value = formKey.currentState?.validate() ?? false;
    return isOtpValid.value;
  }

  // Method to get OTP value
  String? getOtp() => otpCode.value;

  // Method to update OTP code from the UI
  void updateOtpCode(String? value) {
    otpCode.value = value ?? '';
  }

  // Start the 3 minutes countdown timer
  void startResendTimer() {
    isResendButtonDisabled.value = true;  // Disable the resend button
    resendTimer.value = 180;  // Reset the timer to 3 minutes
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        isResendButtonDisabled.value = false;  // Enable the resend button
        timer.cancel();
      }
    });
  }


  Future<void> verifyOTP() async {
    try {
      //Loading
      isLoading.value = true;  

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //Stop Loading
        TLoaders.customToast(message: 'No Internet Connection');
        isLoading.value = false;
        return;
      }

      //Form Validation
      if (!formKey.currentState!.validate()) {
        //Stop Loading
        isLoading.value = false;
        return;
      }
      
      final payload = {
        "Mobile_No": mobileNo,
        "otp_request": otpCode.value
      };

      final otpData = await AuthenticationRepository.instance.verifyOTP(payload);

      //Stop Loading
      isLoading.value = false;

      if (otpData.status == "success" || otpData.userverified == 'Yes') {

        // Save L&T token in local storage
        await TLocalStorage().saveData('token', otpData.token);
        
        // Save JWT token in local storage
        await TLocalStorage().saveData('tappUserToken', otpData.tappUserToken);

        Get.offAll(() => const BottomNavigationMenu(requireAuth: false));

        TLoaders.successSnackBar(title: 'Welcome to TSavaari', message: "Enjoy a smooth and hassle-free journey with us!");

      } else {
        throw otpData.message.toString();
      }

    } catch (error) {
      //Stop Loading
      isLoading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: error.toString());
    } finally {
      //Remove loader
      isLoading.value = false;
    }
  }

  Future<void> resendOTP() async {
    if (isResendButtonDisabled.value) return;

    try {
      //Loading
      isLoading.value = true;  

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //Stop Loading
        TLoaders.customToast(message: 'No Internet Connection');
        isLoading.value = false;
        return;
      }

      ///Form Validation
      // if (!formKey.currentState!.validate()) {
      //   //Stop Loading
      //   isLoading.value = false;
      //   return;
      // }
      
      final payload = {
        "Mobile_No": mobileNo,
      };

      final resendOtpData = await AuthenticationRepository.instance.resendOTP(payload);

      //Stop Loading
      isLoading.value = false;

      if (resendOtpData.status == "success") {
        THelperFunctions.showSnackBar('OTP has been resent successfully!');
        startResendTimer();  // Restart the resend timer
      } else {
        throw resendOtpData.message.toString();
      }

    } catch (error) {
      //Stop Loading
      isLoading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: error.toString());
    } finally {
      //Remove loader
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();  // Cancel the timer if the controller is closed
    super.onClose();
  }


}
// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:sms_autofill/sms_autofill.dart';
// import 'package:tsavaari/bottom_navigation/bottom_navigation_menu.dart';
// import 'package:tsavaari/data/repositories/authentication/authenticaion_repository.dart';
// import 'package:tsavaari/utils/helpers/helper_functions.dart';
// import 'package:tsavaari/utils/helpers/network_manager.dart';
// import 'package:tsavaari/utils/local_storage/storage_utility.dart';
// import 'package:tsavaari/utils/popups/loaders.dart';

// class OtpController extends GetxController with CodeAutoFill {
//   static OtpController get instance => Get.find();
  
//   // Reactive variables
//   final deviceStorage = GetStorage();
//   RxString otpCode = ''.obs;
//   RxBool isOtpValid = false.obs;
//   RxBool isLoading = false.obs;

//   // Timer-related variables
//   RxBool isResendButtonDisabled = true.obs;
//   RxInt resendTimer = 180.obs; // 3 minutes timer in seconds
//   Timer? _timer;

//   //Variables for SMS auto-fill
//   String? appSignature;
//   final autoFillOtp = true.obs;
//   final _smsAutoFill = SmsAutoFill();

//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final mobileNo = TLocalStorage().readData('mobileNo') ?? '';

//   @override
//   void codeUpdated() {
//     // This is called when SMS code is received
//     print("Code updated: $code");
//     if (code != null && code!.isNotEmpty) {
//       otpCode.value = code!;
//       formKey.currentState?.validate();
//     }
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     startResendTimer();
//     _listenForCode();
//   }


//   Future<void> _listenForCode() async {
//     try {
//       // Request SMS permission
//       final status = await Permission.sms.request();
//       if (!status.isGranted) {
//         print("SMS permission denied");
//         return;
//       }

//       // Get app signature
//       final appSignature = await SmsAutoFill().getAppSignature;
//       print("App Signature: $appSignature");

//       // Listen for SMS code
//       listenForCode();
      
//     } catch (e) {
//       print("Error in _listenForCode: $e");
//     }
//   }

//   // Method to validate OTP
//   bool validateOtp() {
//     isOtpValid.value = formKey.currentState?.validate() ?? false;
//     return isOtpValid.value;
//   }

//   // Method to get OTP value
//   String? getOtp() => otpCode.value;

//   // Method to update OTP code from the UI
//   void updateOtpCode(String? value) {
//     otpCode.value = value ?? '';
//   }

//   // Start the 3 minutes countdown timer
//   void startResendTimer() {
//     isResendButtonDisabled.value = true;  // Disable the resend button
//     resendTimer.value = 180;  // Reset the timer to 3 minutes
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (resendTimer.value > 0) {
//         resendTimer.value--;
//       } else {
//         isResendButtonDisabled.value = false;  // Enable the resend button
//         timer.cancel();
//       }
//     });
//   }


//   Future<void> verifyOTP() async {
//     try {
//       //Loading
//       isLoading.value = true;  

//       //Check Internet Connectivity
//       final isConnected = await NetworkManager.instance.isConnected();
//       if (!isConnected) {
//         //Stop Loading
//         TLoaders.customToast(message: 'No Internet Connection');
//         isLoading.value = false;
//         return;
//       }

//       //Form Validation
//       if (!formKey.currentState!.validate()) {
//         //Stop Loading
//         isLoading.value = false;
//         return;
//       }
      
//       final payload = {
//         "Mobile_No": mobileNo,
//         "otp_request": otpCode.value
//       };

//       final otpData = await AuthenticationRepository.instance.verifyOTP(payload);

//       //Stop Loading
//       isLoading.value = false;

//       if (otpData.status == "success" || otpData.userverified == 'Yes') {

//         // Save L&T token in local storage
//         await TLocalStorage().saveData('token', otpData.token);
        
//         // Save JWT token in local storage
//         await TLocalStorage().saveData('tappUserToken', otpData.tappUserToken);

//         Get.offAll(() => const BottomNavigationMenu(requireAuth: false));

//         TLoaders.successSnackBar(title: 'Welcome to TSavaari', message: "Enjoy a smooth and hassle-free journey with us!");

//       } else {
//         throw otpData.message.toString();
//       }

//     } catch (error) {
//       //Stop Loading
//       isLoading.value = false;
//       TLoaders.errorSnackBar(title: 'Oh Snap!', message: error.toString());
//     } finally {
//       //Remove loader
//       isLoading.value = false;
//     }
//   }

//   Future<void> resendOTP() async {
//     if (isResendButtonDisabled.value) return;

//     try {
//       //Loading
//       isLoading.value = true;  

//       //Check Internet Connectivity
//       final isConnected = await NetworkManager.instance.isConnected();
//       if (!isConnected) {
//         //Stop Loading
//         TLoaders.customToast(message: 'No Internet Connection');
//         isLoading.value = false;
//         return;
//       }

//       ///Form Validation
//       // if (!formKey.currentState!.validate()) {
//       //   //Stop Loading
//       //   isLoading.value = false;
//       //   return;
//       // }
      
//       final payload = {
//         "Mobile_No": mobileNo,
//       };

//       final resendOtpData = await AuthenticationRepository.instance.resendOTP(payload);

//       //Stop Loading
//       isLoading.value = false;

//       if (resendOtpData.status == "success") {
//         THelperFunctions.showSnackBar('OTP has been resent successfully!');
//         startResendTimer();  // Restart the resend timer
//       } else {
//         throw resendOtpData.message.toString();
//       }

//     } catch (error) {
//       //Stop Loading
//       isLoading.value = false;
//       TLoaders.errorSnackBar(title: 'Oh Snap!', message: error.toString());
//     } finally {
//       //Remove loader
//       isLoading.value = false;
//     }
//   }

//   @override
//   void onClose() {
//     cancel(); // Cancel SMS listener
//     _timer?.cancel();  // Cancel the timer if the controller is closed
//     _smsAutoFill.unregisterListener();
//     super.onClose();
//   }


// }

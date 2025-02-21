import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/data/repositories/authentication/authenticaion_repository.dart';
import 'package:tsavaari/features/authentication/register/screens/registration.dart';
import 'package:tsavaari/routes/routes.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/helpers/network_manager.dart';
import 'package:tsavaari/utils/local_storage/storage_utility.dart';
import 'package:tsavaari/utils/popups/full_screen_loader.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  //Variables
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxString mobileNumber = ''.obs;
  RxBool isLoading = false.obs;

  void onMobileNumberChanged(String value) {
    mobileNumber.value = value;
  }

  
  Future<void> login() async {
    try {
      //Loading
      isLoading.value = true;
      // TFullScreenLoader.openLoadingDialog(
      //     'Logging you in', TImages.trainAnimation);

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
        //TFullScreenLoader.stopLoading();
        isLoading.value = false;
        return;
      }

      final payload = {
        "Mobile_No": mobileNumber.value,
      };

      //Login user using mobile authentication
      final loginResponse = await AuthenticationRepository.instance.login(payload);

      //Stop Loading
      //TFullScreenLoader.stopLoading();
      isLoading.value = false;
      
      if (loginResponse.status == "success" &&
                loginResponse.userinfo!.mobileOtp != null) {
        
       // Save user data in local storage
        await TLocalStorage().saveData('uid', loginResponse.userinfo!.uid);
        await TLocalStorage().saveData('firstName', loginResponse.userinfo!.firstName);
        await TLocalStorage().saveData('lastName', loginResponse.userinfo!.lastName);
        await TLocalStorage().saveData('mobileNo', loginResponse.userinfo!.mobileNo);
        await TLocalStorage().saveData('emailAddress', loginResponse.userinfo!.emailAddress);
        await TLocalStorage().saveData('dateOfBirth', loginResponse.userinfo!.dateOfBirth);
        await TLocalStorage().saveData('gender', loginResponse.userinfo!.gender);
        await TLocalStorage().saveData('occupation', loginResponse.userinfo!.occupation);
        await TLocalStorage().saveData('personWithDisability', loginResponse.userinfo!.personWithDisability);
        
        Get.toNamed(Routes.otpPage);
        TLoaders.successSnackBar(title: 'Process Successful', message: "Please check OTP");

      } else {
        throw loginResponse.message.toString();
      }

    } catch (error) {
      //Stop Loading
      //TFullScreenLoader.stopLoading();
      isLoading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: error.toString());
    }
  }

  Future<void> logout() async {
    try {
      //Loading
      TFullScreenLoader.openLoadingDialog(
        'Logging you out',
        TImages.trainAnimation,
      );
      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //Stop Loading
        TFullScreenLoader.stopLoading();
        TLoaders.customToast(message: 'No Internet Connection');
        return;
      }

      final mobileNo = TLocalStorage().readData('mobileNo') ?? '';
      final uid = TLocalStorage().readData('uid') ?? '';


      final payload = {
        "Mobile_No": mobileNo,
      };
       
      final logoutResponse = await AuthenticationRepository.instance.logout(
        payload: payload,
        uid: uid
      );

      //Stop Loading
      TFullScreenLoader.stopLoading();
      // isLoading.value = false;
      
      if (logoutResponse.status == "success" ) {
        
        //remove token
        await TLocalStorage().clearAll();

        //Redirect
        AuthenticationRepository.instance.screenRedirect();

      } else {
        throw logoutResponse.message.toString();
      }

    } catch (error) {
      //Stop Loading
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: error.toString());
    }
  }

  void navigateToRegisterPage() {
    Get.offAll(() => RegistrationPage());
  }
}

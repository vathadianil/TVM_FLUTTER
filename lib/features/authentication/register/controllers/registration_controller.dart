import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tsavaari/data/repositories/authentication/authenticaion_repository.dart';
import 'package:tsavaari/features/authentication/login/screens/login.dart';
import 'package:tsavaari/routes/routes.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/helpers/network_manager.dart';
import 'package:tsavaari/utils/local_storage/storage_utility.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class RegistrationController extends GetxController {
  static RegistrationController get instance => Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController dobController = TextEditingController();
  TextEditingController otherOccupationController = TextEditingController();
  
  final deviceStorage = GetStorage();
  RxString fullName = ''.obs;
  RxString mobileNumber = ''.obs;
  RxString emailId = ''.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString selectedGender = ''.obs;
  RxString selectedPersonWithDisabilities = ''.obs;
  RxString selectedOccupation = ''.obs;
  RxBool agreedToTerms = false.obs;
  RxBool isLoading = false.obs;
  

  Future<void> registerUser() async {
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

      // Convert gender to 'M' or 'F'
      String genderCode = selectedGender.value == 'Male' ? 'M' : 'F';

      String occupation = selectedOccupation.value == 'Others'
        ? otherOccupationController.text
        : selectedOccupation.value;

      final payload = {
        "First_Name": fullName.value.split(' ').first,
        "Last_Name": fullName.value.split(' ').length > 1 ? fullName.value.split(' ').last : '',
        "Gender": genderCode,
        "Date_of_birth": "${selectedDate.value.year}-${selectedDate.value.month.toString().padLeft(2, '0')}-${selectedDate.value.day.toString().padLeft(2, '0')}", // Include the selected date of birth"${selectedDate.value.year}-${selectedDate.value.month.toString().padLeft(2, '0')}-${selectedDate.value.day.toString().padLeft(2, '0')}", // Include the selected date of birth
        "Mobile_No": mobileNumber.value,
        "Email_Address": emailId.value,
        "Occupation": occupation,
        "Person_with_disability": selectedPersonWithDisabilities.value
      };

      //Register user using mobile authentication
      final registrationData = await AuthenticationRepository.instance.register(payload);

      //Stop Loading
      isLoading.value = false;

      if (registrationData.status == "success" &&
                registrationData.userinfo!.mobileOtp!.isNotEmpty) {
       
        // Save user data in local storage
        await TLocalStorage().saveData('uid', registrationData.userinfo!.uid);
        await TLocalStorage().saveData('firstName', registrationData.userinfo!.firstName);
        await TLocalStorage().saveData('lastName', registrationData.userinfo!.lastName);
        await TLocalStorage().saveData('mobileNo', registrationData.userinfo!.mobileNo);
        await TLocalStorage().saveData('emailAddress', registrationData.userinfo!.emailAddress);
        await TLocalStorage().saveData('dateOfBirth', registrationData.userinfo!.dateOfBirth);
        await TLocalStorage().saveData('gender', registrationData.userinfo!.gender);
        await TLocalStorage().saveData('occupation', registrationData.userinfo!.occupation);
        await TLocalStorage().saveData('personWithDisability', registrationData.userinfo!.personWithDisability);
        
        Get.toNamed(Routes.otpPage);
        TLoaders.successSnackBar(title: 'Process Successful', message: "Please check OTP");
      } else {
        throw registrationData.message.toString();
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

  void setDate(DateTime newDate) {
    selectedDate.value = newDate;
  }
  
  void setGender(String gender) {
    selectedGender.value = gender;
  }

  void setPersonWithDisabilities(String value) {
    selectedPersonWithDisabilities.value = value;
  }

  void toggleAgreement(bool? value) {
    agreedToTerms.value = value ?? false;
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  // Validation methods..
  String? validateFullName(String? value) {
    return value == null || value.trim().isEmpty
        ? 'Please enter your full name'
        : null;
  }

  void onTapRegister() {
    if (validateForm()) {
      if (selectedGender.value.isEmpty) {
        THelperFunctions.showSnackBar('Please select your gender');
      } else if (!agreedToTerms.value) {
        THelperFunctions.showSnackBar('You must agree to the Terms & Conditions');
      } else {
        registerUser();
      }
    }
  }


  void navigateToLoginPage() {
    Get.offAll(() => const LoginScreen());
  }


}

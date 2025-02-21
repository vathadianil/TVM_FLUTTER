import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/data/repositories/user/user_repository.dart';
import 'package:tsavaari/features/profile/screens/widgets/otp_dialog.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/helpers/network_manager.dart';
import 'package:tsavaari/utils/local_storage/storage_utility.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find(); 

  //Variables
  final formKey = GlobalKey<FormState>();
  final userRepository = Get.put(UserRepository());
  final fullNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final emailController = TextEditingController();
  Rx<DateTime> selectedDate = DateTime.now().obs;
  final dobController = TextEditingController();
  RxString selectedGender = ''.obs;
  RxString selectedPersonWithDisabilities = ''.obs;
  RxString selectedOccupation = ''.obs;
  final otherOccupationController = TextEditingController();
  RxBool isLoading = false.obs;

  // Manage form editing state
  RxBool isEditable = false.obs;
  //RxBool isMobileNumberEditable = false.obs;

  // Add variables to store original values
  RxString originalMobileNumber = ''.obs;
  RxString originalFullName = ''.obs;
  RxString originalEmail = ''.obs;
  late String originalDob;
  late String originalGenderValue;
  late String originalPersonWithDisabilitiesValue;
  late String originalOccupationValue;


  // Create RxString variables for reactive updates
  final uid = TLocalStorage().readData('uid') ?? '';
  final tappUserToken = TLocalStorage().readData('tappUserToken') ?? '';
  final RxString rxFirstName = ''.obs;
  final RxString rxLastName = ''.obs;
  final RxString rxMobileNo = ''.obs;
  final RxString rxEmailAddress = ''.obs;
  final RxString rxDateOfBirth = ''.obs;
  final RxString rxGender = ''.obs;
  final RxString rxPersonWithDisabilities = ''.obs;
  final RxString rxOccupation = ''.obs;

  final otpFormKey = GlobalKey<FormState>();
  RxString otpCode = ''.obs;
  RxBool isOtpValid = false.obs;


  @override
  void onInit() {
    super.onInit();
    _initializeRxVariables();
    _populateUserData();
  }

  // Method to validate OTP
  bool validateOtp() {
    isOtpValid.value = otpFormKey.currentState?.validate() ?? false;
    return isOtpValid.value;
  }

  // Method to get OTP value
  String? getOtp() => otpCode.value;

  // Method to update OTP code from the UI
  void updateOtpCode(String? value) {
    otpCode.value = value ?? '';
  }

  void _initializeRxVariables() {
    rxFirstName.value = TLocalStorage().readData('firstName') ?? '';
    rxLastName.value = TLocalStorage().readData('lastName') ?? '';
    rxMobileNo.value = TLocalStorage().readData('mobileNo') ?? '';
    rxEmailAddress.value = TLocalStorage().readData('emailAddress') ?? '';
    rxDateOfBirth.value = TLocalStorage().readData('dateOfBirth') ?? '';
    rxGender.value = TLocalStorage().readData('gender') ?? '';
    rxPersonWithDisabilities.value = TLocalStorage().readData('personWithDisability') ?? 'No';
    rxOccupation.value =  TLocalStorage().readData('occupation') ?? '';
  }


  void _populateUserData() {
    fullNameController.text = '${rxFirstName.value} ${rxLastName.value}';
    mobileNumberController.text = rxMobileNo.value;
    emailController.text = rxEmailAddress.value;

    if (rxDateOfBirth.value.isNotEmpty) {
      try {
        final parsedDate = DateTime.parse(rxDateOfBirth.value);
        dobController.text = '${parsedDate.day.toString().padLeft(2, '0')}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.year}';
        selectedDate.value = parsedDate;
      } catch (e) {
        dobController.text = rxDateOfBirth.value;
      }
    }

    selectedGender.value = (rxGender.value == 'M' ? 'Male' : rxGender.value == 'F' ? 'Female' : 'Male');
    selectedPersonWithDisabilities.value = rxPersonWithDisabilities.value;

    // Updated occupation handling
    if (rxOccupation.value.isNotEmpty) {
      // Check if the profession matches any predefined options
      final predefinedOccupations = {"Private Employee", "Teacher", "Homemaker", "Armed Force", "Student", "Govt. Employee", "IT Employee", "Non-IT Employee", "Business"};
      if (predefinedOccupations.contains(rxOccupation.value)) {
        selectedOccupation.value = rxOccupation.value;
        otherOccupationController.clear();
      } else {
        // If profession doesn't match predefined options, set to "Others" and populate the text field
        selectedOccupation.value = "Others";
        otherOccupationController.text = rxOccupation.value;
      }
    } else {
      selectedOccupation.value = ''; // Set to empty if no profession is stored
    }
    
    // Store original values when first loading
    originalMobileNumber.value = rxMobileNo.value;
    originalFullName.value = '${rxFirstName.value} ${rxLastName.value}';
    originalEmail.value = rxEmailAddress.value;
    originalDob = dobController.text;
    originalGenderValue = selectedGender.value;
    originalPersonWithDisabilitiesValue = selectedPersonWithDisabilities.value;
    originalOccupationValue = rxOccupation.value;
  }


  // Reset form to original values
  void resetForm() {
    fullNameController.text = originalFullName.value;
    mobileNumberController.text = originalMobileNumber.value;
    emailController.text = originalEmail.value;
    dobController.text = originalDob;
    selectedGender.value = originalGenderValue;
    selectedPersonWithDisabilities.value = originalPersonWithDisabilitiesValue;

    // Updated occupation reset logic
    final predefinedOccupations = {"Private Employee", "Teacher", "Homemaker", "Armed Force", "Student", "Govt. Employee", "IT Employee", "Non-IT Employee", "Business"};
    if (predefinedOccupations.contains(originalOccupationValue)) {
      selectedOccupation.value = originalOccupationValue;
      otherOccupationController.clear();
    } else {
      selectedOccupation.value = "Others";
      otherOccupationController.text = originalOccupationValue;
    }
    
    // Reset editable state
    isEditable.value = false;
    
    // Reset date picker if needed
    try {
      final parts = originalDob.split('-');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        selectedDate.value = DateTime(year, month, day);
      }
    } catch (e) {
      print('Error resetting date: $e');
    }
  }

  // Toggle edit mode
  void toggleEdit() {
    if (isEditable.value) {
      // If currently editable, reset form when toggling off
      if (formKey.currentState!.validate()) {
        resetForm();
      }
    } else {
      // If currently not editable, enable editing
      isEditable.value = true;
    }
  }
  

  Future<void> updateLocalStorageAndUI(Map<String, dynamic> userData) async {
    // Update local storage
    await TLocalStorage().saveData('firstName', userData['firstName']);
    await TLocalStorage().saveData('lastName', userData['lastName']);
    await TLocalStorage().saveData('mobileNo', userData['mobileNo']);
    await TLocalStorage().saveData('emailAddress', userData['emailAddress']);
    await TLocalStorage().saveData('dateOfBirth', userData['dateOfBirth']);
    await TLocalStorage().saveData('gender', userData['gender']);
    await TLocalStorage().saveData('occupation', userData['occupation']);
    await TLocalStorage().saveData('personWithDisability', userData['personWithDisability']);

    // Update Rx variables to trigger UI updates
    rxFirstName.value = userData['firstName'];
    rxLastName.value = userData['lastName'];
    rxMobileNo.value = userData['mobileNo'];
    rxEmailAddress.value = userData['emailAddress'];
    rxDateOfBirth.value = userData['dateOfBirth'];
    rxGender.value = userData['gender'];
    rxOccupation.value = userData['occupation'];
    rxPersonWithDisabilities.value = userData['personWithDisability'];

    // Re-populate the form data to ensure consistency
    _populateUserData();

    // Notify other widgets that depend on this data
    update();
  }
  

  Future<void> updateUserProfile() async {
    if (!formKey.currentState!.validate()) {
      return; 
    }

    if (mobileNumberController.text != originalMobileNumber.value
          || fullNameController.text != originalFullName.value
          //|| emailController.text != originalEmail.value
          )
    {
      requestOtpProfileUpdate();
    } else {
      updateUserRecord();
      isEditable.value = false;
    }
  }
  
  ///This function is used to sent Otp when Name, Mob No., Email has Changed..
  Future<void> requestOtpProfileUpdate() async {
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
        "Mobile_No": mobileNumberController.text,
      };

      final data = await userRepository.requestOtpProfileUpdate(
        payload: payload,
        uid: uid,
        authToken: tappUserToken
      ); 

      if (data.status == "success") {
        // Navigate to OTP dialog if mobile number/ fullname / email was changed
        return const OTPConfirmationDialog().showUpdateProfileOtpDialog(Get.context!, data.oTP);
      }
      else {
        throw data.message.toString();
      }

    } catch (error) {
      //Stop Loading
      isLoading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  
  Future<void> updateUserRecord() async {
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

      String genderCode = selectedGender.value == 'Male' ? 'M' : 'F';
      String formattedDob = "${selectedDate.value.year}-${selectedDate.value.month.toString().padLeft(2, '0')}-${selectedDate.value.day.toString().padLeft(2, '0')}";
      String occupation = selectedOccupation.value == 'Others'
        ? otherOccupationController.text
        : selectedOccupation.value;

      final payload = {
        "First_Name": fullNameController.text.split(' ').first,
        "Last_Name": fullNameController.text.split(' ').length > 1 ? fullNameController.text.split(' ').last : '',
        "Gender": genderCode,
        "Date_of_birth": formattedDob,
        "Mobile_No": mobileNumberController.text,
        "Email_Address": emailController.text,
        "OTP_request": otpCode.value,
        "Occupation": occupation,
        "Person_with_disability": selectedPersonWithDisabilities.value
      };

      //Login user using mobile authentication
      final data = await userRepository.updateUserDetails(
        payload: payload,
        uid: uid,
        authToken: tappUserToken
      );
      
      //Reset the Otp value to empty for Gender & DOB fields
      otpCode.value= '';
      
      if (data.status == "success") {

        try{
          final updatedUserData = await userRepository.fetchUserDetails(uid: uid, authToken: tappUserToken);
          print('Original MOb ${originalMobileNumber.value}');

          if(updatedUserData.status == "success"){
             // Update local storage and UI
            await updateLocalStorageAndUI({
              'firstName': updatedUserData.userinfo!.firstName,
              'lastName': updatedUserData.userinfo!.lastName,
              'mobileNo': updatedUserData.userinfo!.mobileNo,
              'emailAddress': updatedUserData.userinfo!.emailAddress,
              'dateOfBirth': updatedUserData.userinfo!.dateOfBirth,
              'gender': updatedUserData.userinfo!.gender,
              'occupation': updatedUserData.userinfo!.occupation,
              'personWithDisability': updatedUserData.userinfo!.personWithDisability,
            });
            
            //This are fields which require OTP..
            originalMobileNumber.value = updatedUserData.userinfo!.mobileNo!;
            originalFullName.value = '${updatedUserData.userinfo!.firstName!} ${updatedUserData.userinfo!.lastName!}';
            originalEmail.value = updatedUserData.userinfo!.emailAddress!;
            print('New Original MOb ${originalMobileNumber.value}');

            isEditable.value = false;
            Get.back();
            THelperFunctions.showSnackBar("Profile Updated Successfully.");
          } else{
            throw updatedUserData.message.toString();
          }
        }catch(e){
          TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
        }

      } else {
        throw data.message.toString();
      }

    } catch (error) {
      //Stop Loading
      isLoading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: error.toString());
    } finally {
      isLoading.value = false;
    }
  }


  void setDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  void handleEditSubmitButton() {
    if (isEditable.value) {
      // Validate and submit form
      if (formKey.currentState!.validate()) {
        updateUserProfile();
      }
    } else {
      // Enable form for editing
      toggleEdit();
    }
  }



  //============Upload Profile Logic=======================================//
  // Rx<File?> profileImage = Rx<File?>(null);
  // final ImagePicker picker = ImagePicker();

  // Future<void> pickImage(ImageSource source) async {
  //   final pickedFile = await picker.pickImage(source: source);
  //   if (pickedFile != null) {
  //     profileImage.value = File(pickedFile.path);
  //     sendImageToServer(profileImage.value!);
  //   }
  // }

  // Future<void> sendImageToServer(File image) async {
  //   const String apiUrl = 'https://api.example/';
  //   try {
  //     final request = http.MultipartRequest('POST', Uri.parse(apiUrl));
  //     request.files.add(await http.MultipartFile.fromPath('profile_image', image.path));

  //     final response = await request.send();
  //     if (response.statusCode == 200) {
  //       print('Profile picture uploaded successfully');
  //     } else {
  //       print('Failed to upload profile picture');
  //     }
  //   } catch (e) {
  //     print('Error uploading profile picture: $e');
  //   }
  // }

  // void deleteImage() {
  //   profileImage.value = null;
  //   sendDeleteImageRequest();
  // }

  // Future<void> sendDeleteImageRequest() async {
  //   const String apiUrl = 'https://api.example';
  //   try {
  //     final response = await http.delete(Uri.parse(apiUrl));
  //     if (response.statusCode == 200) {
  //       print('Profile picture deleted successfully');
  //     } else {
  //       print('Failed to delete profile picture');
  //     }
  //   } catch (e) {
  //     print('Error deleting profile picture: $e');
  //   }
  // }

}

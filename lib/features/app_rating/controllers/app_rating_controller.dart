import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/bottom_navigation/bottom_navigation_menu.dart';
import 'package:tsavaari/data/repositories/app_ratings/app_rating_repository.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/helpers/network_manager.dart';
import 'package:tsavaari/utils/local_storage/storage_utility.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class AppRatingController extends GetxController {
  static AppRatingController get instance => Get.find();

  final _appRatingRepository = Get.put(AppRatingRepository());
  final TextEditingController suggestionController = TextEditingController();
  
  // Observable variables
  RxBool isLoading = false.obs;
  RxInt selectedRating = 2.obs; 

  Future<void> submitRating({required String? orderId}) async {
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
      
      final tappUserToken = TLocalStorage().readData('tappUserToken') ?? '';
      final uid = TLocalStorage().readData('uid') ?? '';
      final firstName = TLocalStorage().readData('firstName') ?? '';
      final lastName = TLocalStorage().readData('lastName') ?? '';
      final mobileNo = TLocalStorage().readData('mobileNo') ?? '';

      final payload = {
        "USERID": uid,
        "Rating": selectedRating.value,
        "Comment": suggestionController.text.trim(),
        "ltmrhlPurchaseId": orderId,
        "Mobile_No": mobileNo,
        "is_rated": true,
        "Username": "$firstName $lastName"
      };

      final ratingData = await _appRatingRepository.postRating(payload, tappUserToken);

      if (ratingData.status == "success") {
        THelperFunctions.showSnackBar(getThankYouMessage());
        Get.offAll(() => const BottomNavigationMenu(requireAuth: false));      

        //Reset the values
        selectedRating.value = 2;
        suggestionController.clear();
        Get.delete<AppRatingController>();
      } else {
        throw ratingData.message.toString();
      }

    } catch (error) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: error.toString());
    } finally {
      //Remove loader
      isLoading.value = false;
    }
  }

  // Method to get the thank-you message based on the selected rating
  String getThankYouMessage() {
    switch (selectedRating.value) {
      case 5:
        return "Wow! Thank you for the amazing rating! We're glad you loved it!";
      case 4:
        return "Thanks for loving our services! We appreciate your support.";
      case 3:
        return "Thanks for your review! We’ll strive to improve your experience.";
      case 2:
        return "We appreciate your feedback! We'll work on making things better.";
      default:
        return "We're sorry to hear that! Let us know how we can improve.";
    }
  }

  // @override
  // void onClose() {
  //   suggestionController.dispose();
  //   super.onClose();
  // }

}

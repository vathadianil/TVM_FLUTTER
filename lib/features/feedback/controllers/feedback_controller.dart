import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tsavaari/bottom_navigation/bottom_navigation_menu.dart';
import 'package:tsavaari/data/repositories/feedback/feedback_repository.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/helpers/network_manager.dart';
import 'package:tsavaari/utils/local_storage/storage_utility.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class FeedbackController extends GetxController {
  static FeedbackController get instance => Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final feedbackRepository = Get.put(FeedbackRepository());
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  RxString selectedReason = ''.obs;

  final ImagePicker _picker = ImagePicker();
  Rx<String?> attachmentName = Rx<String?>(null);
  Rx<String?> base64EncodedImage = Rx<String?>(null);
  RxBool isLoading = false.obs;


  Future<void> pickImage(ImageSource source) async {
    // Check for permissions
    if (source == ImageSource.camera) {
      final cameraStatus = await Permission.camera.request();
      //if (cameraStatus.isDenied || cameraStatus.isPermanentlyDenied) {
      if (!cameraStatus.isGranted) {
         _showPermissionDialog(Get.context!, 'Camera');
        return;
      }
    } else if (source == ImageSource.gallery) {
      final galleryStatus = await Permission.photos.request();
      //if (galleryStatus.isDenied || galleryStatus.isPermanentlyDenied) {
      if (!galleryStatus.isGranted) {
         _showPermissionDialog(Get.context!, 'Gallery');
        return;
      }
    }

    // Pick image after permissions are granted
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      attachmentName.value = File(pickedFile.path).path.split('/').last;

      // Convert the selected image to Base64 format
      final bytes = await File(pickedFile.path).readAsBytes();
      final base64Image = base64Encode(bytes);

      // Store the Base64 string in a variable to be used in the payload
      base64EncodedImage.value = base64Image;
    }
  }

  void clearAttachment() {
    attachmentName.value = null;
    Get.back();
  }

  Future<void> submitFeedback() async {
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

      final uid = TLocalStorage().readData('uid') ?? '';
      final tappUserToken = TLocalStorage().readData('tappUserToken') ?? '';
      final firstName = TLocalStorage().readData('firstName') ?? '';
      final lastName = TLocalStorage().readData('lastName') ?? '';
      final mobileNo = TLocalStorage().readData('mobileNo') ?? '';

      final payload = {
        "USERID": uid,
        "Subject": subjectController.text.trim(),
        "Description": descriptionController.text.trim(),
        "Mobile_No": mobileNo,
        "Feedback": selectedReason.value,
        "Username": "$firstName $lastName"
      };

      // Conditionally add the Image key only if a Base64 image is available
      if (base64EncodedImage.value != null) {
        payload["Image"] = {
          "name": attachmentName.value,
          "content": base64EncodedImage.value
        };
      }

      final feedbackData = await feedbackRepository.sendFeedback(payload, tappUserToken);

      if (feedbackData.status == "success") {
        THelperFunctions.showSnackBar('Feedback has been sent successfully!');
        Get.offAll(() => const BottomNavigationMenu(requireAuth: false));
      } else {
        throw feedbackData.message.toString();
      }

    } catch (error) {
      //Stop Loading
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: error.toString());
    } finally {
      //Remove loader
      isLoading.value = false;
    }
  }

  void _showPermissionDialog(BuildContext context, String permissionType) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('$permissionType Permission'),
          content: Text('Please enable $permissionType permission in app settings.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                openAppSettings(); // Opens the app's settings
                Navigator.pop(context);
              },
              child: const Text('Settings'),
            ),
          ],
        );
      },
    );
  }
}

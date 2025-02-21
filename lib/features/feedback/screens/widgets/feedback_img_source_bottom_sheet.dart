import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsavaari/features/feedback/controllers/feedback_controller.dart';
import 'package:tsavaari/features/feedback/screens/widgets/custom_image_source_bottom_sheet.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';

void showImageSourceModalSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (_) {
      return CustomModalSheet(
        title: 'Upload Photo',
        options: [
          ModalSheetOption(
            iconPath: TImages.cameraIcon,
            label: 'Camera',
            onTap: () async {
              Get.back();
              await FeedbackController.instance.pickImage(ImageSource.camera);
            },
          ),
          ModalSheetOption(
            iconPath: TImages.galleryICon,
            label: 'Gallery',
            onTap: () async {
              Get.back();
              await FeedbackController.instance.pickImage(ImageSource.gallery);
            },
          ),
        ],
        onClose: () => Get.back(),
        onClear: FeedbackController.instance.clearAttachment,
      );
    },
  );
}

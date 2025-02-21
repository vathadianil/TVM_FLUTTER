// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tsavaari/common/styles/app_style.dart';
// import 'package:tsavaari/features/feedback/screens/widgets/custom_image_source_bottom_sheet.dart';
// import 'package:tsavaari/features/profile/controllers/profile_controller.dart';
// import 'package:tsavaari/utils/constants/image_strings.dart';
// import 'package:tsavaari/utils/constants/size_config.dart';

// class ImageSourceModalSheet extends StatelessWidget {
//   const ImageSourceModalSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }

//   void showImageSourceModalSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
//       ),
//       builder: (_) {
//         return CustomModalSheet(
//           title: 'Upload Photo',
//           options: [
//             ModalSheetOption(
//               iconPath: TImages.cameraIcon,
//               label: 'Camera',
//               onTap: () {
//                 Get.back(); 
//                 ProfileController.instance.pickImage(ImageSource.camera);
//               },
//             ),
//             ModalSheetOption(
//               iconPath: TImages.galleryICon,
//               label: 'Gallery',
//               onTap: () {
//                 Get.back();
//                 ProfileController.instance.pickImage(ImageSource.gallery);
//               },
//             ),
//           ],
//           onClose: () => Get.back(),
//           onClear: () {
//             // Call delete image logic
//             Get.back();  // Close the modal
//             _imageDeleteConfirmationDialog(context); // Show confirmation dialog before deleting
//           },
//         );
//       },
//     );
//   }

//   void _imageDeleteConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12), 
//           ),
//           child: Padding(
//             padding: EdgeInsets.all( SizeConfig.blockSizeVertical * 2), // Add padding inside the dialog
//             child: Column(
//               mainAxisSize: MainAxisSize.min, // Makes the dialog size fit the content
//               children: [
//                 Text(
//                   'Are you sure you want to delete your profile image?',
//                   style: AppTextStyle.commonTextStyle11(),
//                   textAlign: TextAlign.start, 
//                 ),
//                 const SizedBox(height: 20), 
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end, 
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         Get.back(); // Close the dialog
//                       },
//                       child: Text(
//                         'Cancel',
//                         style: AppTextStyle.commonTextStyle12(),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         ProfileController.instance.deleteImage(); // Call delete logic
//                         Get.back(); // Close the dialog
//                       },
//                       child: Text(
//                         'Delete',
//                         style: AppTextStyle.commonTextStyle12(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
  
// }

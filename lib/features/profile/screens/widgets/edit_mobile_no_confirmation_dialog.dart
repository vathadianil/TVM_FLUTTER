// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tsavaari/features/profile/controllers/profile_controller.dart';
// import 'package:tsavaari/utils/constants/size_config.dart';

// class EditConfirmationDialog extends StatelessWidget {
//   const EditConfirmationDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }

//   void showEditMobileNoConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12), 
//           ),
//           child: Padding(
//             padding: EdgeInsets.all( SizeConfig.blockSizeVertical * 2), // Add padding inside the dialog
//             child: Column(
//               mainAxisSize: MainAxisSize.min, // Makes the dialog size fit the content
//               children: [
//                 const Text(
//                   'Are you sure you want to change the mobile number?',
//                 ),
//                 const SizedBox(height: 20), 
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end, 
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         ProfileController.instance.isMobileNumberEditable.value = false; // Disable editing
//                         Get.back(); // Close the dialog
//                       },
//                       child: const Text('No'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         ProfileController.instance.isMobileNumberEditable.value = true; // Enable editing
//                         Get.back(); // Close the dialog
//                       },
//                       child: const Text('Yes'),
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

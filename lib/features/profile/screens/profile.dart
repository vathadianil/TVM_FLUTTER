import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/features/profile/controllers/profile_controller.dart';
import 'package:tsavaari/features/profile/screens/widgets/profile_details_form.dart';
import 'package:tsavaari/features/profile/screens/widgets/profile_header.dart';
import 'package:tsavaari/utils/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = ProfileController.instance;
    return WillPopScope(
      onWillPop: () async {
        if (profileController.isEditable.value) {
          profileController.resetForm();
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: TColors.primary,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: TColors.primary,
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                if (profileController.isEditable.value) {
                  profileController.resetForm();
                }
                Get.back();
              },
              icon: const Icon(
                Iconsax.arrow_left,
                color: TColors.white,
              )),
          title: Text(
            'Edit Profile',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: TColors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ProfileHeader(), ProfileDetailsForm()],
          ),
        ),
      ),
    );
  }
}

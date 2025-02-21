import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/components/custom_drop_down.dart';
import 'package:tsavaari/common/widgets/appbar/t_appbar.dart';
import 'package:tsavaari/features/feedback/controllers/feedback_controller.dart';
import 'package:tsavaari/features/feedback/screens/widgets/contact_info_card.dart';
import 'package:tsavaari/common/components/custom_textfield.dart';
import 'package:tsavaari/features/feedback/screens/widgets/dotted_border_button.dart';
import 'package:tsavaari/features/feedback/screens/widgets/feedback_img_source_bottom_sheet.dart';
import 'package:tsavaari/features/feedback/screens/widgets/submit_button.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class FeedbackScreen extends StatelessWidget {
  FeedbackScreen({super.key});

  final FeedbackController controller = Get.put(FeedbackController());
  final screenHeight = TDeviceUtils.getScreenHeight();
  final screenWidth = TDeviceUtils.getScreenWidth(Get.context!);

  @override
  Widget build(BuildContext context) {
    final textScaler = TextScaleUtil.getScaledText(context);

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Feedback',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: TColors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.md),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ContactInfoCard(),
                const SizedBox(height: TSizes.lg),
                Text(
                  'Suggestions',
                  textScaler: textScaler,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                CustomTextField(
                  hintText: 'Subject',
                  controller: controller.subjectController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a subject';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                CustomTextField(
                  hintText: 'Description',
                  controller: controller.descriptionController,
                  maxLines: 4,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Obx(() => CustomDropdown(
                  labelText: 'Reason',
                  value: controller.selectedReason.value.isEmpty ? null : controller.selectedReason.value,
                  items: const [
                    DropdownMenuItem(value: "Appreciation", child: Text("Appreciation")),
                    DropdownMenuItem(value: "Suggestion", child: Text("Suggestion")),
                    DropdownMenuItem(value: "Complaint", child: Text("Complaint")),
                  ],
                  onChanged: (value) {
                    controller.selectedReason.value = value ?? '';
                  },
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenHeight * .017,
                    horizontal:screenWidth * .04,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your reason';
                    }
                    return null;
                  },
                )),
                const SizedBox(height: TSizes.lg),
                Text(
                  'Upload Screenshot',
                  textScaler: textScaler,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: TSizes.xs),
                Text(
                  'Note: File size must be less than 100kb',
                  textScaler: textScaler,
                  style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(
                        color: TColors.error),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                _buildAttachmentUploader(context),
                Obx(() {
                  if (controller.attachmentName.value != null) {
                    return Column(
                      children: [
                        const SizedBox(height: TSizes.spaceBtwItems),
                        _buildAttachmentDisplay(),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                }),
                const SizedBox(height: TSizes.spaceBtwSections),
                const SubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAttachmentUploader(BuildContext context) {
    return DottedBorderButton(
      onPressed: () => showImageSourceModalSheet(context),
    );
  }

  Widget _buildAttachmentDisplay() {
    return Container(
      width: double.infinity,
      height: TSizes.productImageSize / 2.4,
      decoration: BoxDecoration(
        color: TColors.darkGrey,
        borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
      ),
      padding:
          const EdgeInsets.symmetric(horizontal: TSizes.md),
      child: Center(
        child: Obx(() => Text(
              controller.attachmentName.value ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
                      color: TColors.white),
            )),
      ),
    );
  }
}

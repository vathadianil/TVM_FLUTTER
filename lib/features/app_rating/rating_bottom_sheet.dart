import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/components/custom_textfield.dart';
import 'package:tsavaari/common/widgets/button/custom_elevated_btn.dart';
import 'package:tsavaari/features/app_rating/controllers/app_rating_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class RatingBottomSheet extends StatelessWidget {
  final String? orderId;

  const RatingBottomSheet({
    super.key, 
    required this.orderId
  });

  @override
  Widget build(BuildContext context) {
    final AppRatingController controller = Get.put(AppRatingController());
    final textScaler = TextScaleUtil.getScaledText(context);
    final screenWidth = TDeviceUtils.getScreenWidth(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, 
        ),
        child: Container(
          padding: const EdgeInsets.all(TSizes.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close button
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Get.delete<AppRatingController>();
                    Get.back();
                  },
                ),
              ),
              
              const SizedBox(height: TSizes.sm),
              
              // Title
              Text(
                'Rate Your experience with us !!',
                style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(
                            fontWeight: FontWeight.bold),
              ),
              
              const SizedBox(height: TSizes.spaceBtwItems),
              
              // Star Rating
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < controller.selectedRating.value 
                          ? Icons.star 
                          : Icons.star_border,
                      color: TColors.secondary,
                      size: screenWidth * 0.11,
                    ),
                    onPressed: () => controller.selectedRating.value = index + 1,
                  );
                }),
              )),
              
              const SizedBox(height: TSizes.spaceBtwItems),
              
              // Thank you text
              Obx(() => Text(
                controller.getThankYouMessage(),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.w600),
              )),
          
              const SizedBox(height: TSizes.spaceBtwSections),
              
              // Suggestion TextField
              CustomTextField(
                hintText: 'Any Other Suggestion ?',
                controller: controller.suggestionController,
                maxLines: 4,
                keyboardType: TextInputType.text,
              ),
              
              const SizedBox(height: TSizes.defaultSpace),
              
              // Submit Button
              Obx(() => CustomElevatedBtn(
                onPressed: controller.isLoading.value 
                ? null 
                : () => controller.submitRating(orderId: orderId),
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : Text('Submit', textScaler: textScaler),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class CustomModalSheet extends StatelessWidget {
  final String title;
  final List<ModalSheetOption> options;
  final VoidCallback? onClose;
  final VoidCallback? onClear;

  const CustomModalSheet({
    super.key,
    required this.title,
    required this.options,
    this.onClose,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final screenWidth = TDeviceUtils.getScreenWidth(context);

    return Container(
      padding: const EdgeInsets.all(TSizes.md),
      height: TSizes.productItemHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: dark ? TColors.white : TColors.dark,
                  size: screenWidth * .06,
                ),
                onPressed: onClose ?? () => Get.back(),
              ),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: dark ? TColors.white : TColors.dark,
                  size: screenWidth * .06,
                ),
                onPressed: onClear,
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: options.map((option) {
              return GestureDetector(
                onTap: option.onTap,
                child: _buildOption(iconPath: option.iconPath, label: option.label),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOption({required String iconPath, required String label}) {
    final dark = THelperFunctions.isDarkMode(Get.context!);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: TColors.accent,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(TSizes.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            color: dark ? TColors.white : null,
            height: TSizes.iconMd
          ),
          const SizedBox(width: TSizes.md),
          Text(
            label, 
            style: Theme.of(Get.context!)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class ModalSheetOption {
  final String iconPath;
  final String label;
  final VoidCallback onTap;

  ModalSheetOption({
    required this.iconPath,
    required this.label,
    required this.onTap,
  });
}

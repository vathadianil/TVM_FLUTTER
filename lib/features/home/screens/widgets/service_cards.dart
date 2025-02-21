import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/widgets/containers/t_circular_container.dart';
import 'package:tsavaari/features/home/models/metro_services_model.dart';
import 'package:tsavaari/features/my_orders/controllers/orders_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/t_icons.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class ServiceCards extends StatelessWidget {
  const ServiceCards(
      {super.key, required this.service, required this.onMediaTap});
  final MetroServicesModel service;
  final VoidCallback onMediaTap;

  void _handleNavigation(BuildContext context) {
    if (service.targetScreen == '/media') {
      onMediaTap();
      return;
    }

    if (service.targetScreen == '/book-qr') {
      if (Get.isRegistered<OrdersController>()) {
        Get.delete<OrdersController>();
      }
    }

    Get.toNamed(service.targetScreen);
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    return InkWell(
      onTap: () => _handleNavigation(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TCircularContainer(
              applyBoxShadow: true,
              backgroundColor: dark ? TColors.dark : TColors.white,
              boxShadowColor:
                  dark ? TColors.accent.withOpacity(.3) : TColors.accent,
              radius: TSizes.borderRadiusMd,
              child: Icon(
                TIcons.getIcon(service.icon),
                size: screenWidth * .04,
                color: dark ? TColors.accent : TColors.primary,
              ),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems / 2,
          ),
          Text(
            service.title,
            textScaler: TextScaleUtil.getScaledText(context, maxScale: 1.5),
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/fare_calculator/screens/widgets/fare_display_card_shimmer.dart';
import 'package:tsavaari/features/fare_calculator/screens/widgets/fare_display_container.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/book_qr_controller.dart';

class FareDisplayCard extends StatelessWidget {
  const FareDisplayCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = BookQrController.instance;

    return Obx(
      () => controller.isLoading.value
          ? const FareDisplayCardShimmer()
          : (!controller.isLoading.value &&
                  controller.fareCalculationData.isNotEmpty)
              ? const FareDisplayContainer()
              : Container(),
    );
  }
}

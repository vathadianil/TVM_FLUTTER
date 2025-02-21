import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmountsScrollController extends GetxController {
  static AmountsScrollController get instance => Get.find();
  late FixedExtentScrollController controller;

  @override
  void onInit() {
    super.onInit();
    controller = FixedExtentScrollController();
  }

  @override
  void onReady() {
    super.onReady();
    animateToIndex(4);
  }

  void animateToIndex(index) {
    controller.animateToItem(
      index,
      duration: const Duration(seconds: 2),
      curve: Curves.bounceOut,
    );
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisplayQrController extends GetxController {
  static DisplayQrController get instance => Get.find();

  //variables
  final pageController = PageController();
  final carouselCurrentIndex = 0.obs;

  //Update page navigation dots
  void updatePageIndicator(index, itemsLength) {
    carouselCurrentIndex.value = index;
  }
}

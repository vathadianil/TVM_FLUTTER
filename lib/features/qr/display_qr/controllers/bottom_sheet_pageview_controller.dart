import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetPageViewController extends GetxController {
  static BottomSheetPageViewController get instace => Get.find();

  ///Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  ///Update current Index when page scroll
  void updatePageIndicator(index) {
    currentPageIndex.value = index;
  }

  void refundPage(BuildContext context) {
    int page = 2;
    updatePageIndicator(page);
    pageController.jumpToPage(page);
  }

  void changeDesitinationPage(BuildContext context) {
    int page = 1;
    updatePageIndicator(page);
    pageController.jumpToPage(page);
  }

  void firstPage(BuildContext context) {
    int page = 0;

    pageController.jumpToPage(page);
  }

  void topupAmountConfirmPage(BuildContext context) {
    int page = 1;
    currentPageIndex.value = page;
    pageController.jumpToPage(page);
  }
}

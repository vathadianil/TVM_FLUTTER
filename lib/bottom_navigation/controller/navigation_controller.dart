import 'package:get/get.dart';
import 'package:tsavaari/features/home/screens/home.dart';
import 'package:tsavaari/features/menu/screens/menu.dart';
import 'package:tsavaari/features/my_orders/my_orders.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();

  final Rx<int> selectedIndex = 0.obs;
  final right = 5.0.obs;
  final top = (TDeviceUtils.getScreenHeight() * 0.4).obs;
  final RxBool isAuthenticated = false.obs;
  final RxBool isLoading = true.obs;

  final screens = [
    const HomeScreen(),
    // const TravelHistoryScreen(),
    const MyOrdersScreen(),
    const MenuScreen()
  ];

  void onDestinationSelectionChange(int index) {
    selectedIndex.value = index;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/data/services/device_auth_service.dart';
import 'package:tsavaari/data/services/firebase_messaging_service.dart';
import 'package:tsavaari/features/home/screens/home.dart';
import 'package:tsavaari/features/menu/screens/menu.dart';
import 'package:tsavaari/features/my_orders/my_orders.dart';
// import 'package:tsavaari/features/travel_history/travel_history.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();

  final FirebaseMessagingService _firebaseMessagingService;
  final AuthService _authService;
  
  NavigationController({
    FirebaseMessagingService? messagingService,
    AuthService? authService,
  }) : 
  _firebaseMessagingService = messagingService ?? FirebaseMessagingService(),
  _authService = authService ?? AuthService();
  
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

  @override
  void onInit() async {
    super.onInit();
    await _initializeServices();
  }

  Future<void> _initializeServices() async {
    try {
      //await _authenticateUser();
      await _initializeFirebaseMessaging();
    } catch (e) {
      debugPrint('Initialization Error: $e');
    }
  }

  Future<void> initializeAuth() async {
    try {
      isLoading.value = true;
      isAuthenticated.value = await _authService.authenticateUser();
    } catch (e) {
      debugPrint('Authentication Error: $e');
      isAuthenticated.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _initializeFirebaseMessaging() async {
    await _firebaseMessagingService.init();
    // String? token = await _firebaseMessagingService.getToken();
    // debugPrint('FCM Token: $token');
    await _firebaseMessagingService.subscribeToTopic('all');
    debugPrint('Subscribed to topic: all');
  }

  void onDestinationSelectionChange(int index) {
    selectedIndex.value = index;
  }
}

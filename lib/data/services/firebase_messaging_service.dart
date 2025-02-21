import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/notifications/controllers/notifications_controller.dart';
import 'package:tsavaari/routes/routes.dart';
import 'package:tsavaari/utils/local_storage/storage_utility.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = 
      FlutterLocalNotificationsPlugin();
   bool _isInitialized = false;

  // Initialize Firebase and Messaging
  Future<void> init() async {
     if (_isInitialized) return; // Prevent re-initialization

    _isInitialized = true;

    // Initialize Firebase
    await Firebase.initializeApp();

    // iOS-specific setup
    await _setupIOSNotifications();

    // Request Notification Permissions
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: true,  // iOS-specific
      carPlay: true,      // iOS-specific
      criticalAlert: true // iOS-specific
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      
      // Configure local notifications
      _configureLocalNotifications();
      
      // Handle foreground messages
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
      
      // Handle background messages
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      
      // Handle notification tap
      FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

      // Set foreground notification presentation options for iOS
      //This will trigger 2 times notifications in app
      // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      //   alert: true,
      //   badge: true,
      //   sound: true,
      // );
    } else {
      print('Notification permissions denied');
    }

  }

  // iOS-specific setup
  Future<void> _setupIOSNotifications() async {
    // Request provisional authorization for iOS
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    
    // Get APNs token
    String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    if (apnsToken != null) {
      print('APNs Token: $apnsToken');
    }
  }

  // Configure Local Notifications
  void _configureLocalNotifications() async  {
    const AndroidInitializationSettings initializationSettingsAndroid = 
        AndroidInitializationSettings('@drawable/metro_logo'); 
    
    final DarwinInitializationSettings initializationSettingsIOS = 
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      //requestCriticalPermission: true, // Add this to ensure critical alerts
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        // Handle notification tap when app is in foreground
        _handleLocalNotificationTap(details);
      },
    );
  }

  // Handle Foreground Messages
  void _handleForegroundMessage(RemoteMessage message) async {
    print('Received foreground message');
 
    RemoteNotification? notification = message.notification;
    // AndroidNotification? android = message.notification?.android;
    // AppleNotification? apple = message.notification?.apple;

    // Show local notification for foreground messages
    if (notification != null) {

      // Increment notification count
      NotificationController.instance.firebaseNotificationCount.value++;

      await _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            importance: Importance.max,
            priority: Priority.high,
            icon: '@drawable/metro_logo', 
            channelShowBadge: true,
            enableLights: true,
            // color: const Color(0xFF0A367E), // Notification LED color
            // styleInformation: const BigTextStyleInformation(''), // For expandable notifications
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            badgeNumber: 1,
          ),
        ),
      );

      // Refresh notifications list
      await NotificationController.instance.fetchAllNotifications();
    }
  }

  // Handle Background Messages
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Background message: ${message.messageId}');

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (Get.isRegistered<NotificationController>()) {
        // Increment unread count
        NotificationController.instance.firebaseNotificationCount.value++;
        // Refresh notifications list
        await NotificationController.instance.fetchAllNotifications();
      }
    });
  }

  // Handle Notification Tap (when app is in background/closed)
  void _handleNotificationTap(RemoteMessage message) async {
    print('Message clicked!');
    // Navigate to specific screen based on notification data
    final token = await TLocalStorage().readData('token') ?? '';
    if (token != '') {
      Get.toNamed(Routes.notificationsPage);

      // Reset count when notifications are viewed
      NotificationController.instance.resetNotificationCount();

      // Refresh notifications list
      await NotificationController.instance.fetchAllNotifications();
    } else {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: "Please Login to access notifications");
    }
    // Example: Navigator.pushNamed(context, '/specific-screen');
  }

  // Handle Local Notification Tap
  void _handleLocalNotificationTap(NotificationResponse details) async {
    print('Local notification tapped');
    // Handle notification tap when app is in foreground
    final token = await TLocalStorage().readData('token') ?? '';
    if (token != '') {
      Get.toNamed(Routes.notificationsPage);

      // Reset count when notifications are viewed
      NotificationController.instance.resetNotificationCount();
    } else {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: "Please login to see notifications details");
    }
  }

  // Get FCM Token
  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  // Subscribe to Topic
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  // Unsubscribe from Topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}


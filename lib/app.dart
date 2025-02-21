import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/bindings/general_bindings.dart';
import 'package:tsavaari/routes/app_routes.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
// import 'package:tsavaari/utils/constants/api_constants.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';
// import 'package:tsavaari/utils/device/device_utility.dart';
// import 'package:tsavaari/utils/loaders/shimmer_effect.dart';
import 'package:tsavaari/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,

      //Show Loader or circular progress indicator meanwhile authentication service is
      //deciding to show releveant screen
      
      home: Scaffold(
        body: Center(
            child: CachedNetworkImage(
          imageUrl: ApiEndPoint.splashImageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => ShimmerEffect(
            width: double.infinity,
            height: TDeviceUtils.getScreenHeight() / 2,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        )),
      ),
    );
  }
}


  // NotificationServices notificationServices = NotificationServices();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   notificationServices.requestNotificationPermission();
  //   notificationServices.forgroundMessage();
  //   notificationServices.firebaseInit(context);
  //   notificationServices.setupInteractMessage(context);
  //   notificationServices.isTokenRefresh();

  //   notificationServices.getDeviceToken().then((value){
  //     if (kDebugMode) {
  //       print('FCM Token');
  //       print(value);
  //     }
  //   });
  // }

  //===========================================================================================




  
  // final FirebaseMessagingService _firebaseMessagingService = 
  //     FirebaseMessagingService();

  // @override
  // void initState() {
  //   super.initState();
  //   _initializeFirebase();
  // }

  // Future<void> _initializeFirebase() async {
  //   try {
  //     // Ensure Firebase is initialized
  //     await Firebase.initializeApp();
      
  //     // Initialize Firebase Messaging
  //     await _firebaseMessagingService.init();
      
  //     // Get FCM Token
  //     String? token = await _firebaseMessagingService.getToken();
  //     debugPrint('FCM Token: $token');

  //     // Optional: Subscribe to a topic
  //     await _firebaseMessagingService.subscribeToTopic('news');
  //   } catch (e) {
  //     debugPrint('Firebase Initialization Error: $e');
  //   }
  // }
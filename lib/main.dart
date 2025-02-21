import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:tsavaari/app.dart';
import 'package:tsavaari/data/repositories/authentication/authenticaion_repository.dart';

void main() async {
  //Add Widgets Binding
  await dotenv.load(fileName: '.env');
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await MobileAds.instance.initialize();
  RequestConfiguration configuration = RequestConfiguration(testDeviceIds: [
    '6F14768FE20735159BAEFF56DE796E03'
  ] // Your test device ID from the logs
      );
  MobileAds.instance.updateRequestConfiguration(configuration);

  //Initialize local storage
  await GetStorage.init();

  // Await splash until other items load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  Get.put(AuthenticationRepository());

  // Restrict to portrait mode only
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  runApp(const App());
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => const App(),
  //   ),
  // );
}


// Card Engraved Id’s for testing
// 11100000014626
// 11100000014618


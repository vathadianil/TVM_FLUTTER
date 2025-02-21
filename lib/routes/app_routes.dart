import 'package:get/get.dart';
import 'package:tsavaari/bottom_navigation/bottom_navigation_menu.dart';
import 'package:tsavaari/features/authentication/login/screens/login.dart';
import 'package:tsavaari/features/authentication/otp/screens/otp.dart';
import 'package:tsavaari/features/authentication/register/screens/registration.dart';
import 'package:tsavaari/features/fare_calculator/screens/fare_calculator.dart';
import 'package:tsavaari/features/feedback/screens/feedback.dart';
import 'package:tsavaari/features/metro_network_map/screens/network_map.dart';
import 'package:tsavaari/features/notifications/screens/notifications.dart';
import 'package:tsavaari/features/profile/screens/profile.dart';
import 'package:tsavaari/features/qr/book_qr/screens/book_qr.dart';
import 'package:tsavaari/features/card_reacharge/screens/card_reachage.dart';
import 'package:tsavaari/features/reward_points/screens/reward_points.dart';
import 'package:tsavaari/features/station_facilities/bindings/station_facilities_binding.dart';
import 'package:tsavaari/features/station_facilities/screens/9_imp_catchment_area/imp_catchment_area.dart';
import 'package:tsavaari/features/station_facilities/screens/station_facilities_dashboard.dart';
import 'package:tsavaari/routes/routes.dart';

import '../features/station_facilities/screens/4_bus_stop/bus_stop.dart';
import '../features/station_facilities/screens/8_neighbourhood_area/neighbourhood_area.dart';
import '../features/station_facilities/screens/web_view/web_view.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: Routes.loginPage,
      page: () => const LoginScreen(),
    ),
    GetPage(name: Routes.registrationPage, page: () => RegistrationPage()),
    GetPage(name: Routes.otpPage, page: () => const OtpInputScreen()),
    GetPage(name: Routes.home, page: () => const BottomNavigationMenu()),
    GetPage(name: Routes.bookQr, page: () => const BookQrScreen()),
    GetPage(
        name: Routes.cardReacharge, page: () => const CardReachargeScreen()),
    GetPage(
        name: Routes.fareCalculator, page: () => const FareCalculatorScreen()),
    GetPage(name: Routes.metroNetworkMap, page: () => const NetworkMapScreen()),
    GetPage(
        name: Routes.stationFacilities,
        page: () => StationFacilitiesScreen(),
        binding: StationFacilitiesBinding()),
    GetPage(name: Routes.webViewScreen, page: () => const WebViewScreen()),
    GetPage(name: Routes.busStopPage, page: () => BusStopScreen()),
    GetPage(
        name: Routes.impCatchmentAreaPage,
        page: () => ImpCatchmentAreaScreen()),
    GetPage(
        name: Routes.neighbourhoodAreasPage,
        page: () => NeighbourhoodAreasScreen()),
    GetPage(name: Routes.profilePage, page: () => const ProfileScreen()),
    GetPage(name: Routes.feedbackPage, page: () => FeedbackScreen()),
    GetPage(
        name: Routes.notificationsPage,
        page: () => const NotificationsScreen()),
    GetPage(name: Routes.rewardPoints, page: () => const RewardPointsScreen()),
  ];
}

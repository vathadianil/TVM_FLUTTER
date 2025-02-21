import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsEngine {
  static final _instance = FirebaseAnalytics.instance;

  static void logEvent(String name, Map<String, dynamic> parameters) {
    _instance.logEvent(name: name, parameters: parameters);
  }

  static void qrPurchaseEvent(double value) {
    _instance.logPurchase(currency: 'INR', value: value);
  }
}

import UIKit
import Flutter
import Firebase
import UserNotifications
import FirebaseMessaging
// import FirebaseCore
// import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Initialize Firebase
    FirebaseApp.configure()

    // Set messaging delegate
    UNUserNotificationCenter.current().delegate = self

    // // Register for remote notifications
    // if #available(iOS 10.0, *) {
    //   UNUserNotificationCenter.current().delegate = self
      
    //   let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
    //   UNUserNotificationCenter.current().requestAuthorization(
    //     options: authOptions,
    //     completionHandler: { _, _ in }
    //   )
    // } else {
    //   let settings: UIUserNotificationSettings =
    //     UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
    //   application.registerUserNotificationSettings(settings)
    // }

    application.registerForRemoteNotifications()

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

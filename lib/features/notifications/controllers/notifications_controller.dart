import 'package:get/get.dart';
import 'package:tsavaari/data/repositories/notifications/notifications_repository.dart';
import 'package:tsavaari/features/notifications/models/notification_model.dart';

class NotificationController extends GetxController {
  static NotificationController get instance => Get.find();

  //Variables
  final _notificationsRepository = Get.put(NotificationsRepository());
  final isLoading = false.obs;
  final RxList<Notification> notificationsList = <Notification>[].obs;
  final RxInt firebaseNotificationCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllNotifications();
  }

  // Fetch Notifications
  Future<void> fetchAllNotifications({bool showLoader = true}) async {
    try {
      if (showLoader) {
        isLoading.value = true;
      }

      final notification = await _notificationsRepository.getAllNotifications();

      if (notification.data!.success == true) {
        notificationsList.assignAll(notification.data!.notification!);

      } else {
        print("Failed to load Notifications");
      }
      
    } catch (e) {
      print(e.toString());
      //TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      if (showLoader) {
        isLoading.value = false;
      }
    }
  }

  // Reset notification count
  void resetNotificationCount() {
    firebaseNotificationCount.value = 0;
  }

}

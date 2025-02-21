import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/widgets/appbar/t_appbar.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/card_history_shimmer.dart';
import 'package:tsavaari/features/notifications/controllers/notifications_controller.dart';
import 'package:tsavaari/features/notifications/screens/widgets/notification_card.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController controller = NotificationController.instance;

    // Reset unread count when user navigates to this screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.resetNotificationCount();  // Reset unread count
    });

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Notifications',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: TColors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: TSizes.md),
        child: RefreshIndicator(
          onRefresh: () => controller.fetchAllNotifications(showLoader: false),
          child: Obx(() {
            //Loader
            if (controller.isLoading.value) {
              return const CardHiistroyShimmer();
            }
            
            // If no notifications are available
            if (controller.notificationsList.isEmpty) {
              return const Center(
                child: Text('No Notifications'),
              );
            }
          
            return ListView.builder(
              itemCount: controller.notificationsList.length,
              itemBuilder: (context, index) {
                final notification = controller.notificationsList[index];
          
                // Formatting date to a string
                String formattedDate = notification.createdDate != null
                    ? "${notification.createdDate!.day.toString().padLeft(2, '0')}/"
                      "${notification.createdDate!.month.toString().padLeft(2, '0')}/"
                      "${notification.createdDate!.year}"
                    : "No Date";
          
                return NotificationCard(
                  title: notification.notificationTitle ?? "No Title",
                  content: notification.description ?? "No Description",
                  date: formattedDate, 
                  sideColor: TColors.success,
                );
              },
            );
          
          }),
        ),
      ),
    );
  }
}

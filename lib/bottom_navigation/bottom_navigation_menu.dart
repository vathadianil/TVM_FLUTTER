import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/bottom_navigation/controller/navigation_controller.dart';
import 'package:tsavaari/bottom_navigation/widgets/floating_button.dart';
// import 'package:tsavaari/bottom_navigation/widgets/floating_button.dart';
import 'package:tsavaari/bottom_navigation/widgets/navigation_container.dart';
import 'package:tsavaari/data/repositories/book_qr/book_qr_repository.dart';
import 'package:tsavaari/data/repositories/loyalty_points/loyalty_points_repository.dart';
import 'package:tsavaari/features/my_orders/controllers/orders_controller.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/book_qr_controller.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/station_list_controller.dart';
import 'package:tsavaari/features/qr/display_qr/screens/display_qr.dart';
import 'package:tsavaari/features/reward_points/controllers/reward_points_controller.dart';
import 'package:tsavaari/utils/constants/ticket_status_codes.dart';
// import 'package:tsavaari/features/qr/book_qr/controllers/station_list_controller.dart';
// import 'package:tsavaari/features/qr/display_qr/screens/display_qr.dart';
// import 'package:tsavaari/utils/constants/ticket_status_codes.dart';

class BottomNavigationMenu extends StatefulWidget {
  final bool requireAuth;

  const BottomNavigationMenu({
    super.key,
    this.requireAuth = true, // Default to true for backward compatibility
  });

  @override
  State<BottomNavigationMenu> createState() => _BottomNavigationMenuState();
}

class _BottomNavigationMenuState extends State<BottomNavigationMenu> {
  late final NavigationController controller;
  late final OrdersController ordersController;
  late final StationListController stationListController;
  final RouteObserver<ModalRoute<void>> routeObserver =
      RouteObserver<ModalRoute<void>>();

  @override
  void initState() {
    super.initState();
    controller = Get.put(NavigationController());
    ordersController = Get.put(OrdersController());
    stationListController = Get.put(StationListController());

    if (widget.requireAuth) {
      // Only initialize authentication if required
      _initializeAuth();
    } else {
      // If auth not required, set authenticated state directly
      controller.isAuthenticated.value = true;
      controller.isLoading.value = false;
    }
  }

  Future<void> _initializeAuth() async {
    await controller.initializeAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main Screen UI (Always visible in background)
        _buildMainScreen(),

        // Loading or Authentication Overlay - Only show if authentication is required
        if (widget.requireAuth)
          Obx(() {
            if (controller.isLoading.value) {
              return _buildOverlay();
            }

            if (!controller.isAuthenticated.value) {
              exit(0);
            }

            return const SizedBox.shrink();
          }),
      ],
    );
  }

  Widget _buildMainScreen() {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            controller.screens[controller.selectedIndex.value],
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: NavigationContainer(
                currentIndex: controller.selectedIndex.value,
                onPressed: (index) {
                  controller.onDestinationSelectionChange(index);
                  Get.delete<OrdersController>();
                  Get.delete<RewardPointsController>();
                  Get.delete<BookQrController>();
                  Get.delete<BookQrRepository>();
                  Get.delete<LoyaltyPointsRepository>();
                },
              ),
            ),
            if (ordersController.activeTickets.isNotEmpty &&
                ordersController.activeTickets.first.ticketHistory != null &&
                (ordersController.activeTickets.first.ticketHistory![0]
                            .tickets![0].ticketStatus ==
                        TicketStatusCodes.newTicketString ||
                    ordersController.activeTickets.first.ticketHistory![0]
                            .tickets![0].ticketStatus ==
                        TicketStatusCodes.entryUsedString))
              FloatingButton(
                ticketStatus: ordersController.activeTickets.first
                        .ticketHistory![0].tickets![0].ticketStatus ??
                    '',
                onTap: () {
                  Get.to(() => DisplayQrScreen(
                        stationList: stationListController.stationList,
                        tickets: ordersController
                            .activeTickets.first.ticketHistory![0].tickets!,
                        orderId: ordersController.activeTickets.first
                                    .ticketHistory![0].tickets![0].orderID !=
                                null
                            ? ordersController.activeTickets.first
                                .ticketHistory![0].tickets![0].orderID!
                                .substring(14, 37)
                            : '',
                      ));
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      // child: const Center(
      //   child: CircularProgressIndicator(color: Colors.white),
      // ),
    );
  }
}

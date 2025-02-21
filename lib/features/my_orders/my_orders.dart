import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/controllers/button_tabbar_controller.dart';
import 'package:tsavaari/common/widgets/appbar/button_tabbar.dart';
import 'package:tsavaari/common/widgets/appbar/t_appbar.dart';
import 'package:tsavaari/common/widgets/layout/max_width_container.dart';
import 'package:tsavaari/features/my_orders/controllers/orders_controller.dart';
import 'package:tsavaari/features/my_orders/widgets/my_orders_shimmer.dart';
import 'package:tsavaari/features/my_orders/widgets/my_orders_ticket_shape_card.dart';
import 'package:tsavaari/features/my_orders/widgets/payment_failed_ticket_shape_card.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/book_qr_controller.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/station_list_controller.dart';
import 'package:tsavaari/features/qr/display_qr/screens/display_qr.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stationController = Get.put(StationListController());
    final tabBarController = Get.put(ButtonTabbarController());
    Get.put(BookQrController());
    final ordersController =
        Get.put(OrdersController(tabIndex: tabBarController.tabIndex.value));
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final buttonTexts = [
      TTexts.activeTickets,
      TTexts.pastTickets,
      TTexts.others,
    ];

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: false,
        title: Text(
          'Order History',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: TColors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: MaxWidthContaiiner(
                child: Column(
                  children: [
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    //-- Tabbar to change Active and Past Tickets
                    ButtonTabbar(
                      buttonTexts: buttonTexts,
                      onTap: (index) {
                        tabBarController.tabIndex.value = index;
                        if (index == 0) {
                          ordersController.getActiveTickets();
                        } else if (index == 1) {
                          ordersController.getPastTickets();
                        } else if (index == 2) {
                          ordersController.getPaymentFailedAndRefundedTickets();
                        }
                      },
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    Obx(
                      () => (ordersController.isLoading.value ||
                              stationController.isLoading.value)
                          ? ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return const MyOrdersShimmer();
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: TSizes.spaceBtwSections,
                                );
                              },
                              itemCount: 2,
                            )
                          : (ordersController.activeTickets.isNotEmpty &&
                                  tabBarController.tabIndex.value == 0)
                              //--Active Tickets
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return MyOrdersTicketShapeCard(
                                      ticketData: ordersController.activeTickets
                                          .first.ticketHistory![index],
                                      stationList:
                                          stationController.stationList,
                                      onTap: () {
                                        Get.to(() => DisplayQrScreen(
                                              tickets: ordersController
                                                  .activeTickets
                                                  .first
                                                  .ticketHistory![index]
                                                  .tickets,
                                              stationList:
                                                  stationController.stationList,
                                              previousScreenIndication:
                                                  'myOrders',
                                              orderId: ordersController
                                                          .activeTickets
                                                          .first
                                                          .ticketHistory![index]
                                                          .tickets![0]
                                                          .orderID !=
                                                      null
                                                  ? ordersController
                                                      .activeTickets
                                                      .first
                                                      .ticketHistory![index]
                                                      .tickets![0]
                                                      .orderID!
                                                      .substring(14, 37)
                                                  : '',
                                            ));
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: screenWidth * .1,
                                    );
                                  },
                                  itemCount: ordersController.activeTickets
                                      .first.ticketHistory!.length,
                                )
                              : (ordersController.activeTickets.isNotEmpty &&
                                      tabBarController.tabIndex.value == 1)
                                  //--Past Tickets
                                  ? ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return MyOrdersTicketShapeCard(
                                          ticketData: ordersController
                                              .activeTickets
                                              .first
                                              .ticketHistory![index],
                                          stationList:
                                              stationController.stationList,
                                          onTap: () {
                                            Get.to(
                                              () => DisplayQrScreen(
                                                tickets: ordersController
                                                    .activeTickets
                                                    .first
                                                    .ticketHistory![index]
                                                    .tickets,
                                                stationList: stationController
                                                    .stationList,
                                                previousScreenIndication:
                                                    'myOrders',
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          height: screenWidth * .1,
                                        );
                                      },
                                      itemCount: ordersController.activeTickets
                                          .first.ticketHistory!.length,
                                    )
                                  : (ordersController
                                              .paymentFailedData.isNotEmpty &&
                                          tabBarController.tabIndex.value == 2)
                                      ?
                                      //--Payment Failed & Refund
                                      ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return PaymentFailedTicketShapeCard(
                                              paymentFailedData:
                                                  ordersController
                                                      .paymentFailedData[index],
                                              stationList:
                                                  stationController.stationList,
                                              onTap: () {},
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return SizedBox(
                                              height: screenWidth * .1,
                                            );
                                          },
                                          itemCount: ordersController
                                              .paymentFailedData.length,
                                        )
                                      : const Center(
                                          child: Text('Data not Found'),
                                        ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

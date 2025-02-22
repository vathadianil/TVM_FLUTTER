import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/common/controllers/checkbox_controller.dart';
import 'package:tsavaari/common/widgets/appbar/t_appbar.dart';
import 'package:tsavaari/common/widgets/layout/max_width_container.dart';
// import 'package:tsavaari/features/home/screens/widgets/banner_image_slider.dart';
// import 'package:tsavaari/features/my_orders/controllers/orders_controller.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/book_qr_controller.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/business_hours_controller.dart';
// import 'package:tsavaari/features/qr/book_qr/controllers/station_list_controller.dart';
import 'package:tsavaari/features/qr/book_qr/screens/book_qr_shimmer.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/display_fare_and_pay_btn_container.dart';
// import 'package:tsavaari/features/qr/book_qr/screens/widgets/display_reedem_points_container.dart';
// import 'package:tsavaari/features/qr/book_qr/screens/widgets/recent_rebook_ticket_card.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/source_destination_selection.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/ticket_count_selection.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/ticket_preview_after_reedem.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/ticket_type_selection.dart';
// import 'package:tsavaari/features/reward_points/controllers/reward_points_controller.dart';
// import 'package:tsavaari/utils/constants/banner_page_type.dart';
import 'package:tsavaari/utils/constants/colors.dart';
// import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
// import '../../../../common/controllers/google_ad_controller.dart';

class BookQrScreen extends StatelessWidget {
  const BookQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final stationListController = Get.put(StationListController());
    final busineessHoursController = Get.put(BusineessHoursController());
    final bookQrController = Get.put(BookQrController());
    Get.put(CheckBoxController());
    // final rewardPointsController = Get.put(RewardPointsController());
    // final ordersController = Get.put(
    //     OrdersController(tabIndex: 1)); //--tabIndex= 1 to fetch Past Tickets.
    // final adController = Get.put(GoogleAdController());

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: false,
        leadingIcon: Iconsax.arrow_left,
        leadingOnPressed: () {
          Get.back();
        },
        title: Text(
          TTexts.bookTicketTitle,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: TColors.white),
          textScaler: TextScaleUtil.getScaledText(context),
        ),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        // padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: SafeArea(
          child: Center(
            child: MaxWidthContaiiner(
              child: Obx(
                () => busineessHoursController.isLoading.value
                    ? const BookQrShimmer()
                    : Column(
                        children: [
                          bookQrController.isRedeemed.value
                              ? TicketPreviewAfterReedem()
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: TSizes.defaultSpace),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(TSizes.md),
                                    border: Border.all(
                                      width: 1,
                                      color: TColors.grey,
                                    ),
                                  ),
                                  child: const Column(
                                    children: [
                                      //-- Ticket type Selection
                                      TicketTypeSlection(),

                                      //-- No. of Tickets selection
                                      TicketCountSelection(),

                                      //-- Source and Destination station selection
                                      SourceDestinationSelection(),

                                      SizedBox(
                                        height: TSizes.spaceBtwItems,
                                      ),
                                    ],
                                  ),
                                ),

                          const SizedBox(
                            height: TSizes.spaceBtwSections / 2,
                          ),

                          // if (adController.isBannerAdReady.value &&
                          //     adController.bannerAd != null)
                          //   const SizedBox(
                          //     height: TSizes.spaceBtwSections,
                          //   ),

                          // //-- Display Google Ads Or Banners
                          // BannerImageSlider(
                          //     autoPlay: true,
                          //     pageType: BannerPageType.qRTicketBooking),

                          //-- Display Reedem Points Container
                          // if (!busineessHoursController
                          //         .isTicketSelleingTimeExpired.value &&
                          //     !busineessHoursController.isLoading.value &&
                          //     bookQrController.source !=
                          //         bookQrController.destination &&
                          //     rewardPointsController.loyaltyProgramKey.value ==
                          //         1)
                          //   const DisplayRedeemPointsContainer(),

                          //-- Display Total Fare and Route
                          if (!busineessHoursController
                                  .isTicketSelleingTimeExpired.value &&
                              !busineessHoursController.isLoading.value &&
                              bookQrController.source !=
                                  bookQrController.destination)
                            const DisplayFarePayBtnContainer(),

                          //-- Recent Rebook Ticket
                          // bookQrController.isRedeemed.value
                          //     ? const SizedBox.shrink()
                          //     : RecentRebookTicketCard(
                          //         stationList:
                          //             stationListController.stationList,
                          //         ticketData: ordersController
                          //                     .activeTickets.isNotEmpty &&
                          //                 ordersController.activeTickets.first
                          //                         .ticketHistory !=
                          //                     null
                          //             ? ordersController
                          //                 .activeTickets.first.ticketHistory![0]
                          //             : null,
                          //       ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: const Image(
      //   height: 100,
      //   image: AssetImage(
      //     TImages.trainImg1,
      //   ),
      // ),
    );
  }
}

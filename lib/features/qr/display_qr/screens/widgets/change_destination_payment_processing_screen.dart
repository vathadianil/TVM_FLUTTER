import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/bottom_navigation/bottom_navigation_menu.dart';
import 'package:tsavaari/common/widgets/layout/max_width_container.dart';
import 'package:tsavaari/features/qr/book_qr/models/create_order_model.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/change_destination_payment_processing_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/loaders/animation_loader.dart';

class ChangeDestPaymentProcessingScreen extends StatelessWidget {
  const ChangeDestPaymentProcessingScreen({
    super.key,
    required this.verifyPayment,
    required this.stationId,
    required this.stationList,
    required this.checkBoxValue,
  });
  final CreateOrderModel verifyPayment;
  final String stationId;
  final List<dynamic> checkBoxValue;
  final List<StationListModel> stationList;

  @override
  Widget build(BuildContext context) {
    final paymentProcessingController =
        Get.put(ChangeDestPaymentProcessingController(
      verifyPaymentData: verifyPayment,
      stationId: '',
      checkBoxValue: [],
      stationList: stationList,
    ));
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
              child: MaxWidthContaiiner(
                  child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (paymentProcessingController.isPaymentVerifing.value &&
                      !paymentProcessingController
                          .hasPaymentVerifyRetriesCompleted.value)
                    Text(
                      'Payment in Progress',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),

                  if (paymentProcessingController
                          .hasVerifyPaymentSuccess.value &&
                      !paymentProcessingController.isGenerateTicketError.value)
                    Text(
                      'Payment Success',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: TColors.success),
                    ),

                  if (!paymentProcessingController
                          .hasVerifyPaymentSuccess.value &&
                      paymentProcessingController
                          .hasPaymentVerifyRetriesCompleted.value)
                    Text(
                      'Payment Failed',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: TColors.error),
                    ),
                  if (paymentProcessingController
                          .hasVerifyPaymentSuccess.value &&
                      paymentProcessingController.isGenerateTicketError.value)
                    Text(
                      'Ticket Generation Failed',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: TColors.error),
                    ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  //-- Payment in Progress animation
                  if (paymentProcessingController.isPaymentVerifing.value &&
                      !paymentProcessingController
                          .hasPaymentVerifyRetriesCompleted.value)
                    const TAnimationLoaderWidget(
                      animation: TImages.trainAnimation,
                      text: 'Please Wait...',
                    ),
                  //-- Payment Success animation
                  if (paymentProcessingController.hasVerifyPaymentSuccess.value)
                    const TAnimationLoaderWidget(
                      isGifanimation: false,
                      animation: TImages.paymentSuccess,
                      text: 'Generating Ticket Please Wait...',
                    ),

                  //-- Payment failed animation
                  if (!paymentProcessingController
                          .hasVerifyPaymentSuccess.value &&
                      paymentProcessingController
                          .hasPaymentVerifyRetriesCompleted.value)
                    const TAnimationLoaderWidget(
                      isGifanimation: false,
                      animation: TImages.paymentFailed,
                      text:
                          'If any amount deducted will be refuned in 2-3 business days',
                    ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  if (!paymentProcessingController
                      .hasPaymentVerifyRetriesCompleted.value)
                    Text(
                      'Do not close the app',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Date:',
                      ),
                      Text(
                        verifyPayment.createdAt != null
                            ? THelperFunctions.getFormattedDateTimeString2(
                                verifyPayment.createdAt!)
                            : '',
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Order Id:',
                      ),
                      Text(
                        verifyPayment.orderId ?? '',
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Amount:',
                      ),
                      Text(
                        '${TTexts.rupeeSymbol}${verifyPayment.orderAmount!.toString()}/-',
                        style: Theme.of(context).textTheme.headlineMedium,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  if (paymentProcessingController
                      .hasPaymentVerifyRetriesCompleted.value)
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.defaultSpace,
                          vertical: TSizes.defaultSpace / 2,
                        ),
                        side: const BorderSide(color: TColors.accent),
                      ),
                      onPressed: () {
                        Get.offAll(() =>
                            const BottomNavigationMenu(requireAuth: false));
                      },
                      icon: const Icon(Iconsax.home),
                      label: const Text('Go Back to Home'),
                    )
                ],
              ),
            ),
          ))),
        ),
      ),
    );
  }
}

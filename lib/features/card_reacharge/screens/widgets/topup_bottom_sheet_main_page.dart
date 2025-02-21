import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/widgets/button/custom_elevated_btn.dart';
import 'package:tsavaari/features/card_reacharge/controllers/amounts_scroll_controller.dart';
import 'package:tsavaari/features/card_reacharge/controllers/metro_card_controller.dart';
import 'package:tsavaari/features/card_reacharge/models/nebula_card_validation_model.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/bottom_sheet_pageview_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class TopupMainPage extends StatelessWidget {
  const TopupMainPage({
    super.key,
    required this.cardData,
  });

  final NebulaCardValidationModel cardData;

  @override
  Widget build(BuildContext context) {
    final cardController = MetroCardController.instance;
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final scrollController = Get.put(AmountsScrollController());
    // final amounts = [
    //   '100',
    //   '200',
    //   '300',
    //   '400',
    //   '500',
    //   '600',
    //   '700',
    //   '800',
    //   '900',
    //   '1000'
    // ];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Amount',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          Text(
            'How much would like to top up?',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(bottom: screenWidth * .02),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: TColors.grey),
              ),
            ),
            child: Obx(
              () => Center(
                child: Text(
                  '${TTexts.rupeeSymbol}${cardController.selectedTopupAmount.value}/-',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          if (cardController.cardRechargeAmounts.isNotEmpty)
            SizedBox(
              height: screenWidth * .7,
              child: ListWheelScrollView(
                  controller: scrollController.controller,
                  physics: const FixedExtentScrollPhysics(),
                  itemExtent: screenWidth * .2,
                  perspective: 0.008,
                  squeeze: .9,
                  onSelectedItemChanged: (index) {
                    cardController.selectedTopupAmount.value =
                        cardController.cardRechargeAmounts[index].toString();
                  },
                  children: cardController.cardRechargeAmounts
                      .map(
                        (amount) => Container(
                          decoration: BoxDecoration(
                            color: TColors.primary,
                            borderRadius:
                                BorderRadius.circular((screenWidth * .1) / 2),
                          ),
                          child: SizedBox(
                            width: screenWidth * .6,
                            child: InkWell(
                              onTap: () {
                                cardController.selectedTopupAmount.value =
                                    amount.toString();
                              },
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * .05,
                                  ),
                                  child: Text(
                                    amount.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: TColors.light,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList()),
            ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => CustomElevatedBtn(
                  backgroundColor:
                      cardController.selectedTopupAmount.value == '0'
                          ? TColors.grey
                          : TColors.primary,
                  onPressed: cardController.selectedTopupAmount.value == '0'
                      ? null
                      : () {
                          BottomSheetPageViewController.instace
                              .topupAmountConfirmPage(context);
                        },
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

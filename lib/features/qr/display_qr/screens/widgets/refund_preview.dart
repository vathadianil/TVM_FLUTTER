import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/common/controllers/checkbox_controller.dart';
import 'package:tsavaari/common/widgets/containers/t_circular_container.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/proceed_to_pay_btn.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/bottom_sheet_pageview_controller.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/refund_preview_controller.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/constants/ticket_status_codes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class RefundPreview extends StatelessWidget {
  const RefundPreview({super.key, this.tickets, required this.orderId});

  final List<TicketsListModel>? tickets;
  final String orderId;

  @override
  Widget build(BuildContext context) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final refundController =
        Get.put(RefundPreviewController(tickets: tickets!, orderId: orderId));
    Get.put(CheckBoxController());

    final dark = THelperFunctions.isDarkMode(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    BottomSheetPageViewController.instace.firstPage(context);
                    Get.delete<CheckBoxController>();
                  },
                  icon: const Icon(Iconsax.arrow_left)),
              const SizedBox(
                width: TSizes.md,
              ),
              Text(TTexts.cancelTicket,
                  textScaler: TextScaleUtil.getScaledText(context),
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!refundController.isLoading.value &&
                    tickets!.length ==
                        refundController.refundPreviewData.length &&
                    refundController.refundPreviewData.isNotEmpty)
                  Text(
                    TTexts.selectPassengers,
                    textScaler:
                        TextScaleUtil.getScaledText(context, maxScale: 2.4),
                  ),

                if (tickets!.length == 1)
                  const SizedBox(
                    height: 50,
                  ),

                //--Select all button
                if (!refundController.isLoading.value &&
                    tickets!.length ==
                        refundController.refundPreviewData.length &&
                    refundController.refundPreviewData.isNotEmpty &&
                    tickets!.length > 1)
                  TextButton(
                    onPressed: () {
                      onValueChanged(0, isSelectAll: true);
                    },
                    child: Text(
                      TTexts.selectAll,
                      textScaler:
                          TextScaleUtil.getScaledText(context, maxScale: 2.4),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TSizes.md),
              border: Border.all(
                width: 1,
                color: TColors.grey,
              ),
            ),
            child: Obx(
              () => Column(
                children: [
                  if (!refundController.isLoading.value &&
                      refundController.refundPreviewData.isEmpty)
                    const Text(TTexts.noDataFound),
                  if (refundController.isLoading.value)
                    Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return const ShimmerEffect(
                              width: double.infinity,
                              height: 60,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: TSizes.spaceBtwItems,
                            );
                          },
                          itemCount: 2),
                    ),
                  if (!refundController.isLoading.value &&
                      tickets!.length ==
                          refundController.refundPreviewData.length &&
                      refundController.refundPreviewData.isNotEmpty)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: refundController
                                      .refundPreviewData[index].returnCode ==
                                  '0'
                              ? () {
                                  onValueChanged(index);
                                }
                              : null,
                          leading: Obx(
                            () => Checkbox(
                                //if the ticket is RJT we are checking for rjtid ortherwise ticketid
                                value: isTicketSelected(index),
                                onChanged: refundController
                                            .refundPreviewData[index]
                                            .returnCode ==
                                        '0'
                                    ? (value) {
                                        onValueChanged(index);
                                      }
                                    : null),
                          ),
                          title: Text(
                            '${TTexts.passenger} ${(index + 1).toString()}',
                            textScaler: TextScaleUtil.getScaledText(context,
                                maxScale: 2.4),
                          ),
                          subtitle: Text(
                            refundController
                                        .refundPreviewData[index].returnCode ==
                                    '0'
                                ? TTexts.refundPossible
                                : TTexts.refundNotPossible,
                            textScaler: TextScaleUtil.getScaledText(context,
                                maxScale: 2.4),
                          ),
                          subtitleTextStyle: TextStyle(
                              color: refundController.refundPreviewData[index]
                                          .returnCode ==
                                      '0'
                                  ? TColors.success
                                  : TColors.error),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (refundController
                                      .refundPreviewData[index].returnCode ==
                                  '0')
                                Column(
                                  children: [
                                    Text(
                                      '${TTexts.rupeeSymbol} ${refundController.refundPreviewData[index].singleTicketValue ?? 0}/-',
                                      textScaler: TextScaleUtil.getScaledText(
                                          context,
                                          maxScale: 2.4),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    Text(
                                      TTexts.refundAmt,
                                      textScaler: TextScaleUtil.getScaledText(
                                          context,
                                          maxScale: 2.4),
                                    ),
                                  ],
                                )
                              else
                                Tooltip(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: TSizes.sm,
                                      horizontal: TSizes.md),
                                  decoration: BoxDecoration(
                                      color: TColors.error,
                                      borderRadius:
                                          BorderRadius.circular(TSizes.sm),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: TColors.error,
                                            blurRadius: TSizes.sm)
                                      ]),
                                  message: getRefundStatusMessage(
                                    refundController
                                        .refundPreviewData[index].returnMsg
                                        .toString()
                                        .split(':')[1],
                                  ),
                                  showDuration: const Duration(seconds: 5),
                                  triggerMode: TooltipTriggerMode.tap,
                                  child: TCircularContainer(
                                    width: screenWidth * .07,
                                    height: screenWidth * .07,
                                    applyBoxShadow: true,
                                    backgroundColor:
                                        dark ? TColors.dark : TColors.white,
                                    boxShadowColor: dark
                                        ? TColors.accent.withOpacity(.3)
                                        : TColors.accent,
                                    radius: screenWidth * .1,
                                    child: Icon(
                                      Iconsax.info_circle,
                                      color: dark
                                          ? TColors.accent
                                          : TColors.primary,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: TSizes.defaultSpace),
                          child: Divider(),
                        );
                      },
                      itemCount: tickets!.length,
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Obx(
            () => refundController.radioSelectedValue.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          TTexts.totalToBeRefund,
                          textScaler: TextScaleUtil.getScaledText(context,
                              maxScale: 2.5),
                        ),
                        Text(
                          '${TTexts.rupeeSymbol}${refundController.totalRefundAmount.value.toString()}/-',
                          textScaler: TextScaleUtil.getScaledText(context),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: TColors.error),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ),
          SizedBox(
            height: screenWidth * 0.05,
          ),
          Obx(
            () => refundController.radioSelectedValue.isNotEmpty
                ? CustomBtnWithTermsDialog(
                    btnText: TTexts.proccedToCancel,
                    onPressed: (CheckBoxController
                                .instance.checkBoxState.value &&
                            refundController.radioSelectedValue.isNotEmpty)
                        ? () {
                            if (refundController.totalRefundAmount.value < 1) {
                              TLoaders.warningSnackBar(
                                  title: 'Refund Warning',
                                  message:
                                      'The refund amount must be greater than ₹1.');
                            } else {
                              Navigator.pop(context);
                              refundController.getRefundConfirm();
                            }
                          }
                        : null,
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  String getRefundStatusMessage(String statusCode) {
    var message = TTexts.rfdGeneralMsg;
    if (statusCode == TicketStatusCodes.entryUsed.toString()) {
      message = TTexts.rfdEntryUsedMsg;
    } else if (statusCode == TicketStatusCodes.changeDestination.toString()) {
      message = TTexts.rfdChgDtMsg;
    } else if (statusCode == TicketStatusCodes.exitUsed.toString()) {
      message = TTexts.rfdExitUsedMsg;
    } else if (statusCode == TicketStatusCodes.refunded.toString()) {
      message = TTexts.rfdRefundStatusMsg;
    } else if (statusCode == TicketStatusCodes.expired.toString()) {
      message = TTexts.rfdTicketExpireddMsg;
    }
    return message;
  }

  bool isTicketSelected(int index) {
    var ticketId = _getTicketId(index);
    return RefundPreviewController.instance.radioSelectedValue
        .contains(ticketId);
  }

  void onValueChanged(int index, {bool isSelectAll = false}) {
    if (isSelectAll) {
      _selectAllTickets();
    } else {
      _toggleTicketSelection(index);
    }
  }

  void _selectAllTickets() {
    RefundPreviewController.instance.radioSelectedValue.clear();
    RefundPreviewController.instance.totalRefundAmount.value = 0;
    for (var index = 0; index < tickets!.length; index++) {
      if (_isRefundable(index)) {
        var ticketId = _getTicketId(index);
        double refundAmount = RefundPreviewController
            .instance.refundPreviewData[index].singleTicketValue!;
        RefundPreviewController.instance.radioSelectedValue.add(ticketId);
        RefundPreviewController.instance.totalRefundAmount.value +=
            refundAmount;
      }
    }
  }

  void _toggleTicketSelection(int index) {
    var ticketId = _getTicketId(index);
    double refundAmount = RefundPreviewController
        .instance.refundPreviewData[index].singleTicketValue!;

    if (RefundPreviewController.instance.radioSelectedValue
        .contains(ticketId)) {
      RefundPreviewController.instance.radioSelectedValue.remove(ticketId);
      RefundPreviewController.instance.totalRefundAmount.value -= refundAmount;
    } else {
      RefundPreviewController.instance.radioSelectedValue.add(ticketId);
      RefundPreviewController.instance.totalRefundAmount.value += refundAmount;
    }
  }

  bool _isRefundable(int index) {
    return RefundPreviewController
            .instance.refundPreviewData[index].returnCode ==
        '0';
  }

  dynamic _getTicketId(int index) {
    if (tickets![index].ticketType == 'RJT' ||
        tickets![index].ticketTypeId == 20) {
      return tickets![index].rjtID ?? tickets![index].rjtId;
    } else {
      return tickets![index].ticketId;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/common/controllers/checkbox_controller.dart';
import 'package:tsavaari/common/widgets/containers/t_circular_container.dart';
import 'package:tsavaari/common/widgets/dropdown/t_dropdown.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/proceed_to_pay_btn.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/bottom_sheet_pageview_controller.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/change_destination_preview_controller.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/constants/ticket_status_codes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';

class ChangeDesinationPreview extends StatelessWidget {
  const ChangeDesinationPreview({super.key, this.tickets, this.stationList});

  final List<TicketsListModel>? tickets;
  final List<StationListModel>? stationList;

  @override
  Widget build(BuildContext context) {
    final changeDestinationPreviewController = Get.put(
        ChangeDestinationPreviewController(
            tickets: tickets!, stationList: stationList!));
    Get.put(CheckBoxController());
    final screenWidth = TDeviceUtils.getScreenWidth(context);
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
                    Get.delete<ChangeDestinationPreviewController>();
                    Get.delete<CheckBoxController>();
                  },
                  icon: const Icon(Iconsax.arrow_left)),
              const SizedBox(
                width: TSizes.md,
              ),
              Text(TTexts.changeDest,
                  textScaler: TextScaleUtil.getScaledText(context),
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          Obx(
            () => !changeDestinationPreviewController
                    .isChangeDestinationPreviewChecked.value
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        TTexts.selectPassengers,
                        textScaler:
                            TextScaleUtil.getScaledText(context, maxScale: 2.4),
                      ),

                      if (tickets!.length == 1 )
                      const SizedBox(height: 50,),
                       
                      // --Select all button
                      if (tickets!.length > 1 )
                      TextButton(
                        onPressed: () {
                          onValueChanged(0, isSelectAll: true);
                        },
                        child: Text(
                          TTexts.selectAll,
                          textScaler: TextScaleUtil.getScaledText(context,
                              maxScale: 2.4),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
          const SizedBox(height: TSizes.sm),
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
                  if (changeDestinationPreviewController.isLoading.value)
                    Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return const ShimmerEffect(
                                width: double.infinity, height: 60);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: TSizes.spaceBtwItems,
                            );
                          },
                          itemCount: 2),
                    ),
                  if (!changeDestinationPreviewController.isLoading.value)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: !changeDestinationPreviewController
                                  .isChangeDestinationPreviewChecked.value
                              ? () {
                                  onValueChanged(index);
                                }
                              : null,
                          leading: Obx(
                            () => !changeDestinationPreviewController
                                    .isChangeDestinationPreviewChecked.value
                                ? Checkbox(
                                    //if the ticket is RJT we are checking for rjtid ortherwise ticketid
                                    value: isTicketSelected(index),
                                    onChanged: (value) {
                                      onValueChanged(index);
                                    },
                                  )
                                : const SizedBox(),
                          ),
                          title: Text(
                            '${TTexts.passenger} ${(index + 1).toString()}',
                            textScaler: TextScaleUtil.getScaledText(context,
                                maxScale: 2.4),
                          ),
                          subtitle: (!changeDestinationPreviewController
                                      .isLoading.value &&
                                  changeDestinationPreviewController
                                      .isChangeDestinationPreviewChecked
                                      .value &&
                                  changeDestinationPreviewController
                                      .changeDestinationPreviewData.isNotEmpty)
                              ? Text(
                                  _isDestinationChangable(index)
                                      ? '${TTexts.updatedDstWillbe}${changeDestinationPreviewController.stationName.value}'
                                      : TTexts.changeDstNotPossible,
                                  textScaler: TextScaleUtil.getScaledText(
                                      context,
                                      maxScale: 2.4),
                                )
                              : Text(
                                  '${TTexts.currDst}${tickets![index].toStation ?? THelperFunctions.getStationFromStationId(tickets![index].toStationId!, stationList!).name}',
                                  textScaler: TextScaleUtil.getScaledText(
                                      context,
                                      maxScale: 2.4),
                                ),
                          subtitleTextStyle: changeDestinationPreviewController
                                  .isChangeDestinationPreviewChecked.value
                              ? TextStyle(
                                  color: _isDestinationChangable(index)
                                      ? TColors.success
                                      : TColors.error,
                                )
                              : Theme.of(context).textTheme.labelLarge,
                          trailing: changeDestinationPreviewController
                                  .isChangeDestinationPreviewChecked.value
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (changeDestinationPreviewController
                                            .changeDestinationPreviewData[index]
                                            .returnCode ==
                                        '0')
                                      Column(
                                        children: [
                                          Text(
                                            '${TTexts.rupeeSymbol} ${changeDestinationPreviewController.changeDestinationPreviewData[index].totalFareAdjusted}/-',
                                            textScaler:
                                                TextScaleUtil.getScaledText(
                                                    context,
                                                    maxScale: 2.4),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                          ),
                                          Text(
                                            TTexts.payableAmt,
                                            textScaler:
                                                TextScaleUtil.getScaledText(
                                                    context,
                                                    maxScale: 2.4),
                                          ),
                                        ],
                                      )
                                    else
                                      Tooltip(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: TSizes.defaultSpace,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: TSizes.sm,
                                            horizontal: TSizes.md),
                                        decoration: BoxDecoration(
                                            color: TColors.error,
                                            borderRadius: BorderRadius.circular(
                                                TSizes.sm),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: TColors.error,
                                                  blurRadius: TSizes.sm)
                                            ]),
                                        message: getChangeDstStatusMessage(
                                          changeDestinationPreviewController
                                              .changeDestinationPreviewData[
                                                  index]
                                              .returnMsg
                                              .toString()
                                              .split(':')[1],
                                        ),
                                        showDuration:
                                            const Duration(seconds: 5),
                                        triggerMode: TooltipTriggerMode.tap,
                                        child: TCircularContainer(
                                          width: screenWidth * .07,
                                          height: screenWidth * .07,
                                          applyBoxShadow: true,
                                          backgroundColor: dark
                                              ? TColors.dark
                                              : TColors.white,
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
                                )
                              : const SizedBox(),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: TSizes.defaultSpace),
                          child: Divider(),
                        );
                      },
                      itemCount: (!changeDestinationPreviewController
                                  .isLoading.value &&
                              changeDestinationPreviewController
                                  .isChangeDestinationPreviewChecked.value &&
                              changeDestinationPreviewController
                                  .changeDestinationPreviewData.isNotEmpty)
                          ? changeDestinationPreviewController
                              .changeDestinationPreviewData.length
                          : tickets!.length,
                    ),
                  if (!changeDestinationPreviewController
                      .isChangeDestinationPreviewChecked.value)
                    Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: TDropdown(
                          labelColor: TColors.error,
                          value: changeDestinationPreviewController
                              .stationName.value,
                          items:
                              stationList!.map((item) => item.name!).toList(),
                          labelText: TTexts.selectDstLabelText,
                          onChanged: (value) {
                            changeDestinationPreviewController
                                .stationName.value = value!;
                          }),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Obx(
            () => (!changeDestinationPreviewController.isLoading.value &&
                    changeDestinationPreviewController
                        .isChangeDestinationPossible.value &&
                    changeDestinationPreviewController
                        .changeDestinationPreviewData.isNotEmpty)
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          TTexts.totalTobePaid,
                          textScaler: TextScaleUtil.getScaledText(
                            context,
                            maxScale: 2.4,
                          ),
                        ),
                        Text(
                          '${TTexts.rupeeSymbol}${changeDestinationPreviewController.totalAmount.value.toString()}/-',
                          textScaler: TextScaleUtil.getScaledText(context,
                              maxScale: 2.4),
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ),
          SizedBox(
            height: TDeviceUtils.getScreenWidth(context) * .05,
          ),
          Obx(
            () => Column(
              children: [
                if (changeDestinationPreviewController.isLoading.value)
                  const ShimmerEffect(width: double.infinity, height: 60),
                if (!changeDestinationPreviewController.isLoading.value &&
                    !changeDestinationPreviewController
                        .isChangeDestinationPreviewChecked.value)
                  CustomBtnWithTermsDialog(
                    btnText: TTexts.submit,
                    onPressed: () {
                      changeDestinationPreviewController
                          .changeDestinationPreview();
                    },
                  ),
                if (!changeDestinationPreviewController.isLoading.value &&
                    changeDestinationPreviewController
                        .isChangeDestinationPossible.value)
                  CustomBtnWithTermsDialog(
                    btnText: TTexts.proccedToPay,
                    onPressed: () {
                      Navigator.pop(context);
                      changeDestinationPreviewController
                          .getChangeDestinationConfirm();
                    },
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String getChangeDstStatusMessage(String statusCode) {
    var message = TTexts.chdGeneralMsg;
    if (statusCode == TicketStatusCodes.newTicket.toString()) {
      message = TTexts.chdNewMsg;
    } else if (statusCode == TicketStatusCodes.changeDestination.toString()) {
      message = TTexts.chdStatustMsg;
    } else if (statusCode == TicketStatusCodes.exitUsed.toString()) {
      message = TTexts.chdExitUsedMsg;
    } else if (statusCode == TicketStatusCodes.refunded.toString()) {
      message = TTexts.chdRefundMsg;
    } else if (statusCode == TicketStatusCodes.expired.toString()) {
      message = TTexts.chdTicketExpireddMsg;
    }
    return message;
  }

  bool isTicketSelected(int index) {
    var ticketId = _getTicketId(index);
    return ChangeDestinationPreviewController.instance.checkBoxValue
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
    ChangeDestinationPreviewController.instance.checkBoxValue.clear();

    for (var index = 0; index < tickets!.length; index++) {
      var ticketId = _getTicketId(index);
      ChangeDestinationPreviewController.instance.checkBoxValue.add(ticketId);
    }
  }

  void _toggleTicketSelection(int index) {
    var ticketId = _getTicketId(index);

    if (ChangeDestinationPreviewController.instance.checkBoxValue
        .contains(ticketId)) {
      ChangeDestinationPreviewController.instance.checkBoxValue
          .remove(ticketId);
    } else {
      ChangeDestinationPreviewController.instance.checkBoxValue.add(ticketId);
    }
  }

  bool _isDestinationChangable(int index) {
    return ChangeDestinationPreviewController
            .instance.changeDestinationPreviewData[index].returnCode ==
        '0';
  }

  dynamic _getTicketId(int index) {
    return tickets![index].ticketId;
  }
}

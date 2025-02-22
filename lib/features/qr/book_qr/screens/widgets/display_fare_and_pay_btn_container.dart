import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/controllers/checkbox_controller.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/book_qr_controller.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/display_fare.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/proceed_to_pay_btn.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/qr_shimmer_container.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';

class DisplayFarePayBtnContainer extends StatelessWidget {
  const DisplayFarePayBtnContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bookQrController = BookQrController.instance;

    return Obx(
      () => Column(
        children: [
          if (bookQrController.isLoading.value)
            const Padding(
              padding: EdgeInsets.only(top: TSizes.spaceBtwSections),
              child: QrShimmerContainer(),
            ),
          if (bookQrController.qrFareData.isNotEmpty &&
              !bookQrController.isLoading.value)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(TSizes.md),
                border: Border.all(
                  width: 1,
                  color: TColors.grey,
                ),
              ),
              child: Column(
                children: [
                  const DisplayFare(),
                  //-- Proceed to pay button
                  CustomBtnWithTermsDialog(
                    btnText:
                        '${TTexts.proccedToPay}  ${TTexts.rupeeSymbol}${_getFinalFare()}/-',
                    // btnText: bookQrController.qrFareData.first.finalFare! > bookQrController.maxRedemptionAmount.value
                    //           && bookQrController.loyaltyProgramKey.value == 1
                    //     ? '${TTexts.proccedToPay}  ${TTexts.rupeeSymbol}${_getFinalFare()}/-'
                    //     : '${TTexts.proccedToPay}  ${TTexts.rupeeSymbol}${bookQrController.passengerCount.value * bookQrController.qrFareData.first.finalFare!}/-',
                    onPressed: CheckBoxController.instance.checkBoxState.value
                        ? () {
                            bookQrController.generateTicket();
                          }
                        : null,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Helper function to calculate final fare after redeeming points
  String _getFinalFare() {
    final bookQrController = BookQrController.instance;

    // Get base fare
    final baseFare = bookQrController.passengerCount.value *
        bookQrController.qrFareData.first.finalFare!;

    // If points are redeemed, deduct the redeemed amount (e.g., 10)
    final finalFare = bookQrController.isRedeemed.value &&
            bookQrController.loyaltyProgramKey.value == 1 &&
            baseFare >= bookQrController.maxRedemptionAmount.value
        ? baseFare - bookQrController.maxRedemptionAmount.value
        : baseFare;

    return finalFare.toString();
  }
}

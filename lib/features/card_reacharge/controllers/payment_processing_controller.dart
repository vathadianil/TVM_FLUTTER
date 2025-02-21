import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tsavaari/data/repositories/loyalty_points/loyalty_points_repository.dart';
import 'package:tsavaari/data/repositories/metro_card/metro_card_repository.dart';
import 'package:tsavaari/features/card_reacharge/models/paytm_verify_payment_model.dart';
import 'package:tsavaari/utils/helpers/card_recharge_utils.dart';
import 'package:tsavaari/utils/local_storage/storage_utility.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class CardPaymentProcessingController extends GetxController {
  CardPaymentProcessingController(
      {required this.addValueAmount,
      required this.retryRecharge,
      required this.orderId,
      required this.cardNumber,
      required this.pgOrderId,
      required this.pgPaymentMode,
      required this.pgPaymentStatus,
      required this.isRedemptionEligibile,
      required this.pointsToRedeem,
      required this.quoteId,
      required this.finalRedeemedAmount});
  final _cardRepository = Get.put(MetroCardRepository());
  final bool retryRecharge;

  final String orderId;
  final String addValueAmount;
  final String cardNumber;
  var verifyRechargeCounter = 0;
  final isRechargeVerifing = false.obs;
  final hasVerifyRechargeSuccess = false.obs;
  final hasRechargeVerifyRetriesCompleted = false.obs;
  final String pgOrderId;
  final String pgPaymentStatus;
  final String pgPaymentMode;
  final String finalRedeemedAmount;
  final _loyaltyPointsRepository = Get.put(LoyaltyPointsRepository());
  final int isRedemptionEligibile;
  final int pointsToRedeem;
  final String quoteId;
  final isPaymentVerifing = false.obs;
  var verifyApiCounter = 0;
  final hasVerifyPaymentSuccess = false.obs;
  final hasPaymentVerifyRetriesCompleted = false.obs;
  final verifyPaytmPaymentData = <PaytmVefiyPaymentModel>{}.obs;

  @override
  void onInit() {
    super.onInit();
    if (retryRecharge) {
      verifyOrder();
    }
  }

  Future<void> verifyOrder() async {
    try {
      isPaymentVerifing.value = true;

      //Retry limit reached
      if (verifyApiCounter == 2) {
        isPaymentVerifing.value = false;
        hasVerifyPaymentSuccess.value = false;
        hasPaymentVerifyRetriesCompleted.value = true;
      } else {
        //calling verify payment after second
        Future.delayed(const Duration(seconds: 5), () async {
          try {
            verifyPaytmPaymentData.clear();
            final verifyPaymentResponse =
                await _cardRepository.verifyPaytmPayment({"orderId": orderId});
            verifyPaytmPaymentData.add(verifyPaymentResponse);
            if (verifyPaymentResponse.body!.resultInfo!.resultMsg ==
                'Txn Success') {
              isPaymentVerifing.value = false;
              hasVerifyPaymentSuccess.value = true;
              await verifyRecharge();
            } else {
              verifyApiCounter++;
              await verifyOrder();
            }
          } catch (e) {
            isPaymentVerifing.value = false;
            hasVerifyPaymentSuccess.value = false;
            TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
          }
        });
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> verifyRecharge() async {
    try {
      isRechargeVerifing.value = true;

      //Retry limit reached
      if (verifyRechargeCounter == 2) {
        isRechargeVerifing.value = false;
        hasVerifyRechargeSuccess.value = false;
        hasRechargeVerifyRetriesCompleted.value = true;
        //Refund the amount if recharge fails
        refundRechargeAmount();
      } else {
        //calling verify payment after second
        Future.delayed(const Duration(seconds: 5), () async {
          try {
            // Generate required data
            String bankCode = CardRechargeUtils.bankCode;
            String bankRequestDateTime =
                CardRechargeUtils.getBankRequestDateTime();
            String bankRefNumber = CardRechargeUtils.getBankReferenceNumber(
                cardNumber, bankRequestDateTime);
            final userId = await TLocalStorage().readData('uid') ?? '';
            final firstName = await TLocalStorage().readData('firstName') ?? '';
            final lastName = await TLocalStorage().readData('lastName') ?? '';
            final phoneNumber =
                await TLocalStorage().readData('mobileNo') ?? '';
            final email = await TLocalStorage().readData('emailAddress') ?? '';
            // Prepare the request body
            Map<String, String> payload = {
              "ticketEngravedID": cardNumber,
              "bankCode": bankCode,
              "bankReferenceNumber": bankRefNumber,
              "bankTransactionDateTime": bankRequestDateTime,
              "addValueAmount": addValueAmount,
              "topUpChannel": CardRechargeUtils.topUpChannel,
              "metroOrderId": orderId,
              "userId": userId.toString(),
              "userName": '$firstName $lastName',
              "email": email,
              'phoneNumber': phoneNumber,
              "pgOrderId": verifyPaytmPaymentData.first.body!.txnId!,
              "pgPaymentStatus":
                  verifyPaytmPaymentData.first.body!.resultInfo!.resultMsg!,
              "pgPaymentMode": pgPaymentMode,
              "trxResponseCode":
                  verifyPaytmPaymentData.first.body!.resultInfo!.resultCode!,
              "trxResponseMessage":
                  verifyPaytmPaymentData.first.body!.resultInfo!.resultStatus!,
              "pgTxnDate": verifyPaytmPaymentData.first.body!.txnDate!,
            };
            final response = await _cardRepository.addCardBalance(payload);
            if (response.bankReferenceNumber != null &&
                response.merchantTransactionID != null) {
              isRechargeVerifing.value = false;
              hasVerifyRechargeSuccess.value = true;

              //--Redeem Points after payment success only.
              if (isRedemptionEligibile == 1) {
                final payload = {
                  "points_to_redeem": pointsToRedeem,
                  "user_id": userId.toString(),
                  "quote_id": quoteId,
                };

                final redeemPointsData =
                    await _loyaltyPointsRepository.redeemPoints(payload);

                if (redeemPointsData.success == true) {
                  TLoaders.successSnackBar(
                      title: 'Success!', message: redeemPointsData.message);
                } else {
                  TLoaders.errorSnackBar(
                      title: 'Oh Snap!', message: redeemPointsData.message);
                }
              }
              //=============================================================================================
            } else {
              verifyRechargeCounter++;
              await verifyRecharge();
            }
          } catch (e) {
            verifyRechargeCounter++;
            await verifyRecharge();
          }
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      //Refund the amount if recharge fails
      refundRechargeAmount();
      // TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> refundRechargeAmount() async {
    try {
      String platformCode = '';
      if (Platform.isAndroid) {
        platformCode = 'AND';
      } else if (Platform.isIOS) {
        platformCode = 'IOS';
      }

      final payload = {
        "txnType": "REFUND",
        "orderId": orderId,
        "txnId": verifyPaytmPaymentData.first.body!.txnId!,
        "refId": "RFD$platformCode${DateTime.now().millisecondsSinceEpoch}",
        "refundAmount": finalRedeemedAmount,
      };
      await _cardRepository.refundPaytmRechargeAmount(payload);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}

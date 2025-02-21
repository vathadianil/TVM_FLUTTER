import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:tsavaari/common/controllers/checkbox_controller.dart';
import 'package:tsavaari/data/repositories/loyalty_points/loyalty_points_repository.dart';
import 'package:tsavaari/data/repositories/metro_card/metro_card_repository.dart';
import 'package:tsavaari/features/card_reacharge/controllers/amounts_scroll_controller.dart';
import 'package:tsavaari/features/card_reacharge/models/paytm_payment_failed_response.dart';
import 'package:tsavaari/features/card_reacharge/models/paytm_trasaction_response_model.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/payment_processing_screen.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/bottom_sheet_pageview_controller.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/card_recharge_utils.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/local_storage/storage_utility.dart';
import 'package:tsavaari/utils/popups/full_screen_loader.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class PaytmPaymentController extends GetxController {
  static PaytmPaymentController get instance => Get.find();
  final _metroCardRepository = Get.put(MetroCardRepository());
  final cardNumber = ''.obs;
  final orderId = ''.obs;
  final addValueAmount = ''.obs;
  final paymentResponse = <PaytmTransactionResponseModel>{}.obs;

  // Variable to track redemption status
  final _loyaltyPointsRepository = Get.put(LoyaltyPointsRepository());
  final isReedeemed = false.obs;
  final finalRedeemedAmount = ''.obs; //Total amount after reedem
  final isRedemptinEligibile = 0.obs;
  final pointToRedeem = 0.obs;
  final quoteID = ''.obs;

  startPayment(
      {required String amount,
      required String cardNum,
      required String finalRechargeAmount,
      required int isRedemptionEligibile,
      required int pointsToRedeem,
      required String quoteId,
      required bool isRedeemed}) async {
    try {
      String platformCode = TDeviceUtils.getPlatfromString();
      final userId = await TLocalStorage().readData('uid') ?? '';
      final phoneNumber = await TLocalStorage().readData('mobileNo') ?? '';
      cardNumber.value = cardNum;
      orderId.value =
          "RC$platformCode${phoneNumber.substring(6, 10)}${DateTime.now().millisecondsSinceEpoch}";
      addValueAmount.value = amount;
      finalRedeemedAmount.value =
          finalRechargeAmount; //Total amount after reedem
      isRedemptinEligibile.value = isRedemptionEligibile;
      pointToRedeem.value = pointsToRedeem;
      quoteID.value = quoteId;
      isReedeemed.value = isRedeemed;

      final callbackUrl = "${dotenv.env["PAYTM_CALLBACK_URL"]}${orderId.value}";
      final isStaging = dotenv.env["PAYTM_IS_STAGING"] == "TRUE" ? true : false;
      final restrictAppInvoke =
          dotenv.env["RESTRICT_APP_INVOKE"] == "TRUE" ? true : false;
      ;

      final initiatePaymentResponse =
          await _metroCardRepository.initiatePaytmPayment({
        "requestType": "Payment",
        "websiteName": "WEBSTAGING",
        "orderId": orderId.value,
        "callbackUrl": callbackUrl,
        "txnAmount_value": finalRechargeAmount, //Total amount after reedem
        "txnAmount_currency": "INR",
        "custId": userId
      });
      if (initiatePaymentResponse.body != null &&
          initiatePaymentResponse.body!.resultInfo!.resultCode == '0000') {
        final data = await AllInOneSdk.startTransaction(
            dotenv.env['PAYTM_MERCHANT_KEY']!,
            orderId.value,
            finalRechargeAmount, //Total amount after reedem...
            initiatePaymentResponse.body!.txnToken!,
            callbackUrl,
            isStaging,
            restrictAppInvoke);
        if (data != null) {
          Map<String, dynamic> castedMap = data.cast<String, dynamic>();
          final response = PaytmTransactionResponseModel.fromJson(castedMap);
          paymentResponse.clear();
          paymentResponse.add(response);
          if (response.status == 'TXN_SUCCESS') {
            addCardBalance(response);
          } else {
            gotoPaymentProcessingScreen(
                retryRecharge: true, paymentGatewayResponse: response);
          }
        } else {
          gotoPaymentProcessingScreen(
              retryRecharge: true,
              paymentGatewayResponse: paymentResponse.first);
        }
      } else {
        gotoPaymentProcessingScreen(
            retryRecharge: true, paymentGatewayResponse: paymentResponse.first);
      }
    } on PlatformException catch (e) {
      final exceptionData = PaytmePaymentFailedException(
        code: e.code,
        details: PaytmTransactionResponseModel(
          mid: e.details['MID'] ?? '',
          bankName: e.details["BANKNAME"] ?? '',
          bankTxnId: e.details["BANKTXNID"] ?? '',
          checksumHash: e.details["CHECKSUMHASH"] ?? '',
          currency: e.details["CURRENCY"] ?? '',
          gatewayName: e.details["GATEWAYNAME"] ?? '',
          orderId: e.details["ORDERID"] ?? '',
          paymentMode: e.details["PAYMENTMODE"] ?? '',
          responseCode: e.details["RESPCODE"] ?? '',
          responseMessage: e.details["RESPMSG"] ?? '',
          retryAllowed: e.details["retryAllowed"] ?? '',
          status: e.details["STATUS"] ?? '',
          txnAmount: e.details["TXNAMOUNT"] ?? '',
          txnDate: e.details["TXNDATE"] ?? '',
          txnId: e.details["TXNID"] ?? '',
        ),
        message: e.message ?? '',
        stackTrace: e.stacktrace ?? '',
      );
      gotoPaymentProcessingScreen(
        paymentGatewayResponse: exceptionData.details,
        message: exceptionData.message,
      );
      final userId = await TLocalStorage().readData('uid') ?? '';
      final phoneNumber = await TLocalStorage().readData('mobileNo') ?? '';
      final firstName = TLocalStorage().readData('firstName') ?? '';
      final lastName = TLocalStorage().readData('lastName') ?? '';
      final email = await TLocalStorage().readData('emailAddress') ?? '';
      final paymentFailedPayload = {
        "user_id": userId,
        "user_name": "$firstName $lastName",
        "user_mobile": phoneNumber,
        "user_email": email,
        "orderId": exceptionData.details.orderId,
        "bankName": exceptionData.details.bankName,
        "bankTxnId": exceptionData.details.bankTxnId,
        "checksumHash": exceptionData.details.checksumHash,
        "currency": exceptionData.details.currency,
        "gatewayName": exceptionData.details.gatewayName,
        "paymentMode": exceptionData.details.paymentMode,
        "responseCode": exceptionData.details.responseCode,
        "responseMessage": exceptionData.details.responseMessage,
        "retryAllowed": false,
        "status": exceptionData.details.status,
        "txnAmount": exceptionData.details.txnAmount,
        "txnDate": exceptionData.details.txnDate,
        "txnId": exceptionData.details.txnId
      };
      _metroCardRepository.postPaytmPaymentFailedData(paymentFailedPayload);
      // TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  Future<void> addCardBalance(
      PaytmTransactionResponseModel paymentGatewayResponse) async {
    try {
      // Generate required data
      String bankCode = CardRechargeUtils.bankCode;
      String bankRequestDateTime = CardRechargeUtils.getBankRequestDateTime();
      String bankRefNumber = CardRechargeUtils.getBankReferenceNumber(
          cardNumber.value, bankRequestDateTime);
      final userId = await TLocalStorage().readData('uid') ?? '';
      final firstName = await TLocalStorage().readData('firstName') ?? '';
      final lastName = await TLocalStorage().readData('lastName') ?? '';
      final phoneNumber = await TLocalStorage().readData('mobileNo') ?? '';
      final email = await TLocalStorage().readData('emailAddress') ?? '';
      // Prepare the request body
      Map<String, String> payload = {
        "ticketEngravedID": cardNumber.value,
        "bankCode": bankCode,
        "bankReferenceNumber": bankRefNumber,
        "bankTransactionDateTime": bankRequestDateTime,
        "addValueAmount": addValueAmount.value,
        "topUpChannel": CardRechargeUtils.topUpChannel,
        "metroOrderId": orderId.value,
        "userId": userId.toString(),
        "userName": '$firstName $lastName',
        "email": email,
        'phoneNumber': phoneNumber,
        "pgOrderId": paymentGatewayResponse.txnId!,
        "pgPaymentStatus": paymentGatewayResponse.status!,
        "pgPaymentMode": paymentGatewayResponse.paymentMode!,
        "trxResponseCode": paymentGatewayResponse.responseCode!,
        "trxResponseMessage": paymentGatewayResponse.responseMessage!,
        "pgTxnDate": paymentGatewayResponse.txnDate!,
      };
      //Posting data to Metro Server
      final response = await _metroCardRepository.addCardBalance(payload);

      if (response.bankReferenceNumber != null &&
          response.merchantTransactionID != null) {
        try {
          //--Redeem Points after payment success only.
          if (isRedemptinEligibile.value == 1) {
            final payload = {
              "points_to_redeem": pointToRedeem.value,
              "user_id": userId.toString(),
              "quote_id": quoteID.value,
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

          final inquiryAfcresponse = await _metroCardRepository.inquiryAfc({
            "bankCode": CardRechargeUtils.bankCode,
            "bankReferenceNumber": response.bankReferenceNumber,
            "webAPIName": 'OPC_VALIDATE_TRX',
          });

          gotoPaymentProcessingScreen(
              isRechargeSuccess: true,
              date: THelperFunctions.getFormattedDateTimeString1(
                  inquiryAfcresponse.bankTransactionDateTime ??
                      THelperFunctions.getFormattedDateTime1(DateTime.now())),
              paymentGatewayResponse: PaytmTransactionResponseModel.empty());
        } catch (e) {
          gotoPaymentProcessingScreen(
            isRechargeSuccess: true,
            date: THelperFunctions.getFormattedDateTime1(DateTime.now()),
            paymentGatewayResponse: PaytmTransactionResponseModel.empty(),
          );
        }
      } else {
        gotoPaymentProcessingScreen(
            retryRecharge: true,
            paymentGatewayResponse: paymentGatewayResponse);
      }
    } catch (e) {
      gotoPaymentProcessingScreen(
          retryRecharge: true, paymentGatewayResponse: paymentGatewayResponse);
    }
  }

  gotoPaymentProcessingScreen(
      {isRechargeSuccess = false,
      message =
          'If any amount deducted will be refuned to your source account in 2-3 business days',
      date,
      cardRechargePayload,
      retryRecharge = false,
      PaytmTransactionResponseModel? paymentGatewayResponse}) {
    Get.delete<AmountsScrollController>();
    Get.delete<BottomSheetPageViewController>();
    Get.delete<CheckBoxController>();
    TFullScreenLoader.stopLoading();
    Get.offAll(
      () => PaymentProcessingScreen(
        isRechargeSuccess: isRechargeSuccess,
        orderId: orderId.value,
        amount: addValueAmount.value,
        cardNumber: cardNumber.value,
        message: message,
        date: date ?? THelperFunctions.getFormattedDateTime1(DateTime.now()),
        retryRecharge: retryRecharge,

        pgOrderId: paymentGatewayResponse != null
            ? paymentGatewayResponse.txnId ?? ''
            : '',
        pgPaymentMode: paymentGatewayResponse != null
            ? paymentGatewayResponse.paymentMode ?? ''
            : '',
        pgPaymentStatus: paymentGatewayResponse != null
            ? paymentGatewayResponse.status ?? ''
            : '',
        isReedeemed: isReedeemed.value,
        finalRedeemedAmount:
            finalRedeemedAmount.value, //Total amount after reedem,
        isRedemptionEligibile: isRedemptinEligibile.value,
        pointsToRedeem: pointToRedeem.value,
        quoteId: quoteID.value,
      ),
    );
  }
}

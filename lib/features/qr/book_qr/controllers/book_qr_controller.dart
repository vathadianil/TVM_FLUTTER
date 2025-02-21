import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tsavaari/data/repositories/book_qr/book_qr_repository.dart';
import 'package:tsavaari/data/repositories/loyalty_points/loyalty_points_repository.dart';
import 'package:tsavaari/features/fare_calculator/models/fare_calculation_model.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/station_list_controller.dart';
import 'package:tsavaari/features/qr/book_qr/models/create_order_model.dart';
import 'package:tsavaari/features/qr/book_qr/models/qr_get_fare_model.dart';
import 'package:tsavaari/features/qr/display_qr/screens/display_qr.dart';
import 'package:tsavaari/features/qr/display_qr/screens/payment_processing_screen.dart';
import 'package:tsavaari/features/reward_points/controllers/reward_points_controller.dart';
import 'package:tsavaari/routes/routes.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/ticket_status_codes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/helpers/network_manager.dart';
import 'package:tsavaari/utils/local_storage/storage_utility.dart';
import 'package:tsavaari/utils/popups/full_screen_loader.dart';
import 'package:tsavaari/utils/popups/loaders.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BookQrController extends GetxController {
  static BookQrController get instance => Get.find();

  //variables
  final isLoading = false.obs;
  final ticketType = false.obs;
  final passengerCount = 1.obs;
  final source = ''.obs;
  final destination = ''.obs;
  final deviceStorage = GetStorage();
  final bookQrRepository = Get.put(BookQrRepository());
  final stationController = StationListController.instance;
  final qrFareData = <QrGetFareModel>{}.obs;
  final fareCalculationData = <FareCalculationModel>{}.obs;
  final loyaltyPointsRepository = Get.put(LoyaltyPointsRepository());

  // Variable to track redemption status
  final loyaltyProgramKey = 0.obs;
  final isRedeemed = false.obs;
  final pointsToRedeem = 0.obs;
  final maxRedemptionAmount = 0.obs;
  final quoteId = ''.obs;
  final isRedemptionEligibile = 0.obs;

  // Variable to track card visibility
  final showRecentTicketCard = true.obs;

  Future<void> getFare() async {
    try {
      final token = await TLocalStorage().readData('token');

      final ticketTypeId = ticketType.value
          ? TicketStatusCodes.ticketTypeRjt.toString()
          : TicketStatusCodes.ticketTypeSjt.toString();

      final fromStation = source.value != ''
          ? THelperFunctions.getStationFromStationName(
              source.value, stationController.stationList)
          : null;

      final fromStationId = fromStation?.stationId;

      final toStation = destination.value != ''
          ? THelperFunctions.getStationFromStationName(
              destination.value, stationController.stationList)
          : null;
      final toStationId = toStation?.stationId;

      if (token == null ||
          token == '' ||
          fromStationId == null ||
          fromStationId == '' ||
          toStationId == null ||
          toStationId == '') {
        return;
      }

      if (fromStationId == toStationId) {
        TLoaders.warningSnackBar(
            title: 'Invalid Input!',
            message: 'Origin and Desitnation station should be diffrent');
        return;
      }

      isLoading.value = true;

      if (Get.currentRoute == Routes.bookQr ||
          Get.currentRoute == Routes.bookQrFromScreen) {
        final payload = {
          "token": "$token",
          "fromStationId": fromStationId,
          "merchant_id": dotenv.env["TSAVAARI_MERCHANT_ID"],
          "ticketTypeId": ticketTypeId, //SJT = 10 RJT=20
          "toStationId": toStationId,
          "travelDatetime": "${DateTime.now()}",
          "zoneNumberOrStored_ValueAmount": 0 //STATIC VALUE
        };
        final fareData = await bookQrRepository.fetchFare(payload);
        if (qrFareData.isNotEmpty) {
          qrFareData.clear();
        }
        qrFareData.add(fareData);
      } else if (Get.currentRoute == Routes.fareCalculator) {
        final payload = {
          "fromStation": source.value,
          "ticketTypeId": ticketTypeId, //SJT = 10 RJT=20
          "toStation": destination.value,
        };
        final data = await bookQrRepository.fetchFareCalculationData(payload);

        if (fareCalculationData.isNotEmpty) {
          fareCalculationData.clear();
        }

        fareCalculationData.add(data);
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Remove loader
      isLoading.value = false;
    }
  }

  Future<void> checkRedemptionEligibility() async {
    try {
      //Loading
      isLoading.value = true;

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //Stop Loading
        TLoaders.customToast(message: 'No Internet Connection');
        isLoading.value = false;
        return;
      }

      final userId = await TLocalStorage().readData('uid') ?? '';

      final payload = {
        "user_id": userId.toString(),
        "ticket_amount": "${passengerCount.value * qrFareData.first.finalFare!}"
      };

      final eligibilityData =
          await loyaltyPointsRepository.checkRedemptionEligibility(payload);

      if (eligibilityData.eligible == 1) {
        loyaltyProgramKey.value = eligibilityData.loyaltyProgramKey!;
        isRedeemed.value = true;
        pointsToRedeem.value = eligibilityData.pointsToRedeem!;
        maxRedemptionAmount.value = eligibilityData.maxRedemptionAmount!;
        quoteId.value = eligibilityData.quoteId ?? '';
        isRedemptionEligibile.value = eligibilityData.eligible!;

        //Available Points after Redemption
        RewardPointsController.instance.activePoints.value =
            eligibilityData.availablePoints! - eligibilityData.pointsToRedeem!;

        TLoaders.successSnackBar(
            title: 'Success!', message: eligibilityData.message);
      } else {
        throw eligibilityData.message.toString();
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Remove loader
      isLoading.value = false;
    }
  }

  int getOrderAmount() {
    return loyaltyProgramKey.value == 1
        ? (passengerCount.value * qrFareData.first.finalFare! -
            (isRedeemed.value ? maxRedemptionAmount.value : 0))
        : (passengerCount.value * qrFareData.first.finalFare!);
  }

  Future<void> generateTicket() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Processing your request', TImages.trainAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //Stop Loading
        TFullScreenLoader.stopLoading();
        TLoaders.customToast(message: 'No Internet Connection');
        return;
      }

      String platformCode = TDeviceUtils.getPlatfromString();
      final userId = await TLocalStorage().readData('uid') ?? '';
      final firstName = await TLocalStorage().readData('firstName') ?? '';
      final lastName = await TLocalStorage().readData('lastName') ?? '';
      final phoneNumber = await TLocalStorage().readData('mobileNo') ?? '';
      final email = await TLocalStorage().readData('emailAddress') ?? '';

      final orderId =
          "SAL$platformCode${phoneNumber.substring(6, 10)}${DateTime.now().millisecondsSinceEpoch}";

      if (getOrderAmount() == 0) {
        generateNewTicketWithAmountZero(orderId);
      } else {
        final payload = {
          "customer_details": {
            "customer_id": userId.toString(),
            "customer_email": email,
            "customer_phone": phoneNumber,
            "customer_name": '$firstName $lastName'
          },
          "order_meta": {
            "return_url": "https://www.cashfree.com/devstudio/thankyou",
            "notify_url": ApiEndPoint.cashfreeWebhookUrl,
            "payment_methods": ""
          },
          "order_id": orderId,
          "order_amount": getOrderAmount(),
          "order_currency": "INR",
          "order_note": "some order note here"
        };

        final createOrderData =
            await bookQrRepository.createQrPaymentOrder(payload);

        final session = CFSessionBuilder()
            .setEnvironment(dotenv.env['CASHFREE_IS_STAGING'] == 'TRUE'
                ? CFEnvironment.SANDBOX
                : CFEnvironment.PRODUCTION)
            .setOrderId(createOrderData.orderId!)
            .setPaymentSessionId(createOrderData.paymentSessionId!)
            .build();

        final cfWebCheckout =
            CFWebCheckoutPaymentBuilder().setSession(session).build();
        final cfPaymentGateWay = CFPaymentGatewayService();
        cfPaymentGateWay.setCallback((orderId) async {
          try {
            final verifyPayment = await bookQrRepository.verifyPayment(orderId);

            if (verifyPayment.orderStatus == 'PAID') {
              final requestPayload = await prepareGenerateTicketPayload(
                  verifyPayment: verifyPayment);

              final ticketData =
                  await bookQrRepository.generateTicket(requestPayload);

              //Stop Loading
              TFullScreenLoader.stopLoading();

              //Navigate to Dispaly QR Page
              if (ticketData.returnCode == '0' &&
                  ticketData.returnMsg == 'SUCESS') {
                Get.offAll(() => DisplayQrScreen(
                      tickets: ticketData.tickets!,
                      stationList: stationController.stationList,
                      orderId: ticketData.orderId!,
                      ltmrhlPurchaseId: ticketData.ltmrhlPurchaseId,
                    ));

                // Early return if finalFare less than maxRedemptionAmount to prevent redeemPoints API call
                // if (qrFareData.first.finalFare! <= maxRedemptionAmount.value ||
                //     loyaltyProgramKey.value == 0) {
                //   return;
                // }
                if (loyaltyProgramKey.value == 0) {
                  return;
                }

                //--Redeem Points after generate tiket success only.
                if (isRedemptionEligibile.value == 1) {
                  final payload = {
                    "points_to_redeem": pointsToRedeem.value,
                    "user_id": userId.toString(),
                    "quote_id": quoteId.value,
                  };

                  final redeemPointsData =
                      await loyaltyPointsRepository.redeemPoints(payload);

                  if (redeemPointsData.success == true) {
                    TLoaders.successSnackBar(
                        title: 'Success!', message: redeemPointsData.message);
                  } else {
                    TLoaders.errorSnackBar(
                        title: 'Oh Snap!', message: redeemPointsData.message);
                  }
                }
              } else {
                throw 'Something went wrong. Please try again later!';
              }
            } else {
              TFullScreenLoader.stopLoading();
              final requestPayload = await prepareGenerateTicketPayload(
                  verifyPayment: verifyPayment);
              Get.offAll(() => PaymentProcessingScreen(
                    verifyPayment: verifyPayment,
                    generateTicketPayload: requestPayload,
                  ));
            }
          } catch (e) {
            TFullScreenLoader.stopLoading();
            TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
          }
        }, (p0, orderId) async {
          //Stop Loading
          try {
            final requestPayload = await prepareGenerateTicketPayload(
              verifyPayment: createOrderData,
              failureCode: p0.getCode() ?? '',
              failureReason: p0.getMessage() ?? '',
              qrPgOrderId: orderId,
            );

            await bookQrRepository.qrTicketPaymentFailedStatus(requestPayload);
            TFullScreenLoader.stopLoading();
            TLoaders.errorSnackBar(
                title: 'Oh Snap!', message: p0.getMessage().toString());
          } catch (e) {
            TFullScreenLoader.stopLoading();
          }
        });
        cfPaymentGateWay.doPayment(cfWebCheckout);
      }
    } on CFException catch (e) {
      //Stop Loading
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } catch (e) {
      //Stop Loading
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void generateNewTicketWithAmountZero(String orderId,
      {String failureCode = "", String failureReason = ""}) async {
    try {
      final requestPayload =
          await prepareGenerateTicketPayload(zeroAmountOrderID: orderId);

      final ticketData = await bookQrRepository.generateTicket(requestPayload);

      //Stop Loading
      TFullScreenLoader.stopLoading();

      //Navigate to Dispaly QR Page
      if (ticketData.returnCode == '0' && ticketData.returnMsg == 'SUCESS') {
        Get.offAll(() => DisplayQrScreen(
              tickets: ticketData.tickets!,
              stationList: stationController.stationList,
              orderId: ticketData.orderId!,
              ltmrhlPurchaseId: ticketData.ltmrhlPurchaseId,
            ));

        // Early return if finalFare less than maxRedemptionAmount to prevent redeemPoints API call
        // if (qrFareData.first.finalFare! <= maxRedemptionAmount.value ||
        //     loyaltyProgramKey.value == 0) {
        //   return;
        // }
        if (loyaltyProgramKey.value == 0) {
          return;
        }

        //--Redeem Points after generate tiket success only.
        if (isRedemptionEligibile.value == 1) {
          final userId = await TLocalStorage().readData('uid') ?? '';

          final payload = {
            "points_to_redeem": pointsToRedeem.value,
            "user_id": userId.toString(),
            "quote_id": quoteId.value,
          };

          final redeemPointsData =
              await loyaltyPointsRepository.redeemPoints(payload);

          if (redeemPointsData.success == true) {
            TLoaders.successSnackBar(
                title: 'Success!', message: redeemPointsData.message);
          } else {
            TLoaders.errorSnackBar(
                title: 'Oh Snap!', message: redeemPointsData.message);
          }
        }
      } else {
        throw 'Something went wrong. Please try again later!';
      }
    } catch (e) {
      //Stop Loading
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<Map<String, Object?>> prepareGenerateTicketPayload(
      {CreateOrderModel? verifyPayment,
      String failureCode = "",
      String failureReason = "",
      String qrPgOrderId = '',
      String? zeroAmountOrderID}) async {
    final token = await deviceStorage.read('token');
    final phoneNumber = await TLocalStorage().readData('mobileNo') ?? '';
    final userId = await TLocalStorage().readData('uid');
    final ticketTypeId = ticketType.value
        ? TicketStatusCodes.ticketTypeRjt.toString()
        : TicketStatusCodes.ticketTypeSjt.toString();

    final fromStation = source.value != ''
        ? stationController.stationList
            .firstWhere((station) => station.name == source.value)
        : null;

    final fromStationId = fromStation?.stationId;

    final toStation = destination.value != ''
        ? stationController.stationList
            .firstWhere((station) => station.name == destination.value)
        : null;
    final toStationId = toStation?.stationId;
    final requestPayload = {
      "token": "$token",
      "user_id": userId.toString(),
      "merchantOrderId": verifyPayment?.orderId ?? zeroAmountOrderID,
      "merchantId": dotenv.env["TSAVAARI_MERCHANT_ID"],
      "transType": "0",
      "fromStationId": fromStationId,
      "toStationId": toStationId,
      "ticketTypeId": ticketTypeId,
      "noOfTickets": passengerCount.value,
      "travelDateTime": "${DateTime.now()}",
      "merchantEachTicketFareBeforeGst": qrFareData.first.finalFare,
      "merchantEachTicketFareAfterGst": qrFareData.first.finalFare,
      "merchantTotalFareBeforeGst":
          (passengerCount.value * qrFareData.first.finalFare!),
      "merchantTotalCgst": 0,
      "merchantTotalSgst": 0,
      "merchantTotalFareAfterGst":
          (passengerCount.value * qrFareData.first.finalFare!),
      "ltmrhlPassId": "",
      "patronPhoneNumber": phoneNumber,
      "fareQuoteIdforOneTicket": "${qrFareData.first.fareQuotIdforOneTicket}",
      "failure_code": failureCode,
      "failure_reason": failureReason,
      "qrPgOrderId": qrPgOrderId,
      "amountPaid": getOrderAmount().toString(),
      "amountRedeemed": loyaltyProgramKey.value == 1
          ? maxRedemptionAmount.value.toString()
          : '0',
      "pointsRedeemed":
          loyaltyProgramKey.value == 1 ? pointsToRedeem.toString() : '0'
    };
    return requestPayload;
  }
}

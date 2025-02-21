import 'dart:io';

import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tsavaari/data/repositories/book_qr/book_qr_repository.dart';
import 'package:tsavaari/data/repositories/change_destination/change_destination_repository.dart';
import 'package:tsavaari/features/qr/book_qr/models/create_order_model.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/features/qr/display_qr/screens/display_qr.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/change_destination_payment_processing_screen.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/helpers/network_manager.dart';
import 'package:tsavaari/utils/popups/full_screen_loader.dart';
import 'package:tsavaari/utils/popups/loaders.dart';
import 'package:tsavaari/utils/local_storage/storage_utility.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChangeDestinationPreviewController extends GetxController {
  ChangeDestinationPreviewController({
    required this.tickets,
    required this.stationList,
  });
  static ChangeDestinationPreviewController get instance => Get.find();

  final stationName = ''.obs;
  RxList checkBoxValue = [].obs;
  List<TicketsListModel> tickets;
  List<StationListModel> stationList;
  final deviceStorage = GetStorage();
  final isLoading = false.obs;
  final _changeDestinationRepository = Get.put(ChangeDestinationRepository());
  final bookQrRepository = Get.put(BookQrRepository());
  final changeDestinationPreviewData = [].obs;
  final changeDestinationConfirmData = [].obs;
  var apiArray = <Future<dynamic>>[];
  RxDouble totalAmount = 0.0.obs;
  final isChangeDestinationPreviewChecked = false.obs;
  final isChangeDestinationPossible = false.obs;

  Future<void> changeDestinationPreview() async {
    try {
      final token = await deviceStorage.read('token');
      changeDestinationPreviewData.clear();

      if (stationName.value == '' || checkBoxValue.isEmpty) {
        TLoaders.errorSnackBar(
            title: 'Oh Snap!', message: 'Please select required fields');
        return;
      }

      final station = stationName.value != ''
          ? THelperFunctions.getStationFromStationName(
              stationName.value, stationList)
          : null;
      final stationId = station!.stationId;

      final fromStationName = tickets[0].fromStation ??
          THelperFunctions.getStationFromStationId(
                  tickets[0].fromStationId!, stationList)
              .name;
      final toStationName = tickets[0].toStation ??
          THelperFunctions.getStationFromStationId(
                  tickets[0].toStationId!, stationList)
              .name;

      if (stationName.value == fromStationName ||
          stationName.value == toStationName) {
        TLoaders.errorSnackBar(
            title: 'Oh Snap!', message: 'Please select New Destination');
        return;
      }

      for (var index = 0; index < checkBoxValue.length; index++) {
        Future.delayed(Duration(seconds: index), () async {
          isLoading.value = true;
          isChangeDestinationPreviewChecked.value = true;
          final response =
              await _changeDestinationRepository.changeDestinationPreview({
            "token": "$token",
            "ticketId": checkBoxValue[index],
            "newDestination": stationId,
          });
          if (response.returnCode == '0') {
            isChangeDestinationPossible.value = true;
            totalAmount.value += response.totalFareAdjusted ?? 0.0;
          }
          changeDestinationPreviewData.add(response);

          if (index == checkBoxValue.length - 1) {
            isLoading.value = false;
          }
        });
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Remove loader
      isLoading.value = false;
    }
  }

  Future<void> getChangeDestinationConfirm() async {
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

      final token = await deviceStorage.read('token') ?? '';

      if (token == '') {
        //Stop Loading
        TFullScreenLoader.stopLoading();
        TLoaders.customToast(
            message: 'Your session expired!. Please Login again');
        return;
      }

      String platformCode = '';
      if (Platform.isAndroid) {
        platformCode = 'AND';
      } else if (Platform.isIOS) {
        platformCode = 'IOS';
      }

      final userId = await TLocalStorage().readData('uid') ?? '';
      final firstName = await TLocalStorage().readData('firstName') ?? '';
      final lastName = await TLocalStorage().readData('lastName') ?? '';
      final phoneNumber = await TLocalStorage().readData('mobileNo') ?? '';
      final email = await TLocalStorage().readData('emailAddress') ?? '';

      final orderId =
          "CHD$platformCode${phoneNumber.substring(6, 10)}${DateTime.now().millisecondsSinceEpoch}";

      if (totalAmount.value == 0) {
        generateNewTicket(orderId);
      } else {
        final payload = {
          "customer_details": {
            "customer_id": userId,
            "customer_email": email,
            "customer_phone": phoneNumber,
            "customer_name": '$firstName $lastName'
          },
          "order_meta": {
            "return_url": "https://www.cashfree.com/devstudio/thankyou",
            "notify_url":
                "https://122.252.226.254:5114/api/v1/NotifyUrl/CFPaymentRequest"
          },
          "order_id": orderId,
          "order_amount": totalAmount.value,
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
              generateNewTicket(orderId, verifyPayment: verifyPayment);
            } else {
              TFullScreenLoader.stopLoading();
              final station = stationName.value != ''
                  ? THelperFunctions.getStationFromStationName(
                      stationName.value, stationList)
                  : null;
              final stationId = station!.stationId;

              Get.offAll(() => ChangeDestPaymentProcessingScreen(
                    verifyPayment: verifyPayment,
                    stationList: stationList,
                    checkBoxValue: checkBoxValue,
                    stationId: stationId ?? '',
                  ));
            }
          } catch (e) {
            TFullScreenLoader.stopLoading();
            TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
          }
        }, (p0, orderId) async {
          //Stop Loading

          var chaneDestinationQuoteIdList = [];
          var ticketIdList = [];

          for (var index = 0; index < checkBoxValue.length; index++) {
            ticketIdList.addIf(
                (checkBoxValue
                    .contains(changeDestinationPreviewData[index].ticketId)),
                changeDestinationPreviewData[index].ticketId);
            chaneDestinationQuoteIdList.addIf(
                (checkBoxValue
                    .contains(changeDestinationPreviewData[index].ticketId)),
                changeDestinationPreviewData[index].codQuoteId);
          }

          for (var index = 0;
              index < chaneDestinationQuoteIdList.length;
              index++) {
            final requestPayload = await prepareGenerateTicketPayload(
                orderId, index, ticketIdList, chaneDestinationQuoteIdList,
                failureCode: p0.getCode() ?? '',
                failureReason: p0.getMessage() ?? '');
            await _changeDestinationRepository
                .changeDestTicketPaymentFailedStatus(requestPayload);
          }

          TFullScreenLoader.stopLoading();
          TLoaders.errorSnackBar(
              title: 'Oh Snap!', message: p0.getMessage().toString());
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

  void generateNewTicket(String orderId,
      {CreateOrderModel? verifyPayment,
      String failureCode = "",
      String failureReason = ""}) async {
    try {
      var chaneDestinationQuoteIdList = [];
      var ticketIdList = [];

      for (var index = 0; index < checkBoxValue.length; index++) {
        ticketIdList.addIf(
            (checkBoxValue
                .contains(changeDestinationPreviewData[index].ticketId)),
            changeDestinationPreviewData[index].ticketId);
        chaneDestinationQuoteIdList.addIf(
            (checkBoxValue
                .contains(changeDestinationPreviewData[index].ticketId)),
            changeDestinationPreviewData[index].codQuoteId);
      }

      var isSuccess = true;
      for (var index = 0; index < chaneDestinationQuoteIdList.length; index++) {
        Future.delayed(Duration(seconds: index), () async {
          try {
            final requestPayload = await prepareGenerateTicketPayload(
                orderId, index, ticketIdList, chaneDestinationQuoteIdList);
            final ticketData = await _changeDestinationRepository
                .changeDestinationConfirm(requestPayload);

            if (ticketData.returnCode != '0') {
              isSuccess = false;
            }
            changeDestinationConfirmData.add(ticketData);

            if (index == chaneDestinationQuoteIdList.length - 1) {
              //Navigate to Dispaly QR Page
              if (isSuccess) {
                final tickets = changeDestinationConfirmData
                    .cast<TicketsListModel>()
                    .toList();

                //Stop Loading
                TFullScreenLoader.stopLoading();
                Get.offAll(
                  () => DisplayQrScreen(
                    tickets: tickets,
                    stationList: stationList,
                  ),
                );
              } else {
                TFullScreenLoader.stopLoading();
                TLoaders.errorSnackBar(
                    title: 'Oh Snap!',
                    message:
                        'Something went wrong. Unable to do Change destination. Please contact customer care!');
              }
            }
          } catch (e) {
            //Stop Loading
            TFullScreenLoader.stopLoading();
            TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
          }
        });
      }
    } catch (e) {
      //Stop Loading
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<Map<String, Object?>> prepareGenerateTicketPayload(
      orderId, index, ticketIdList, chaneDestinationQuoteIdList,
      {failureCode = '', failureReason = ''}) async {
    final token = await TLocalStorage().readData('token') ?? '';
    final station = stationName.value != ''
        ? THelperFunctions.getStationFromStationName(
            stationName.value, stationList)
        : null;
    final stationId = station!.stationId;
    final patronPhoneNumber = await TLocalStorage().readData('mobileNo') ?? '';
    return {
      "token": "$token",
      "ticketId": ticketIdList[index],
      "newDestinationId": stationId,
      "newOrderId": orderId + ticketIdList[index].substring(14, 25),
      "codQuoteId": chaneDestinationQuoteIdList[index],
      "patronPhoneNumber": patronPhoneNumber,
      "failure_code": failureCode,
      "failure_reason": failureReason
    };
  }
}

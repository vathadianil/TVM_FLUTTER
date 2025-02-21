import 'package:get/get.dart';
import 'package:tsavaari/data/repositories/book_qr/book_qr_repository.dart';
import 'package:tsavaari/data/repositories/change_destination/change_destination_repository.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/station_list_controller.dart';
import 'package:tsavaari/features/qr/book_qr/models/create_order_model.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/features/qr/display_qr/screens/display_qr.dart';
import 'package:tsavaari/utils/local_storage/storage_utility.dart';
import 'package:tsavaari/utils/payment_gateway/cash_free.dart';
import 'package:tsavaari/utils/popups/full_screen_loader.dart';
import 'package:tsavaari/utils/popups/loaders.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChangeDestPaymentProcessingController extends GetxController {
  ChangeDestPaymentProcessingController(
      {required this.verifyPaymentData,
      required this.stationId,
      required this.checkBoxValue,
      required this.stationList});
  final CreateOrderModel verifyPaymentData;

  final String stationId;
  var checkBoxValue = [];
  final _changeDestinationRepository = Get.put(ChangeDestinationRepository());
  final bookQrRepository = Get.put(BookQrRepository());
  final stationController = Get.put(StationListController());
  var verifyApiCounter = 0;
  final isPaymentVerifing = false.obs;
  final hasVerifyPaymentSuccess = false.obs;
  final hasPaymentVerifyRetriesCompleted = false.obs;
  final isGenerateTicketError = false.obs;
  final cashFreePaymentController = Get.put(CashFreeController());
  final changeDestinationPreviewData = [].obs;
  final changeDestinationConfirmData = [].obs;
  List<StationListModel> stationList;

  @override
  void onInit() async {
    super.onInit();
    await verifyOrder();
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
            final verifyPayment =
                await bookQrRepository.verifyPayment(verifyPaymentData.orderId);
            if (verifyPayment.orderStatus == 'PAID') {
              isPaymentVerifing.value = false;
              hasVerifyPaymentSuccess.value = true;
              await generateNewTicket();
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

  generateNewTicket(
      {String failureCode = "", String failureReason = ""}) async {
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
                verifyPaymentData.orderId,
                index,
                ticketIdList,
                chaneDestinationQuoteIdList);
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

                Get.offAll(
                  () => DisplayQrScreen(
                    tickets: tickets,
                    stationList: stationList,
                  ),
                );
              } else {
                await verifyGenerateTicket();
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
    final token = await TLocalStorage().readData('token');
    return {
      "token": "$token",
      "ticketId": ticketIdList[index],
      "newDestinationId": stationId,
      "newOrderId": orderId + ticketIdList[index].substring(14, 25),
      "codQuoteId": chaneDestinationQuoteIdList[index],
      "failure_code": failureCode,
      "failure_reason": failureReason
    };
  }

  verifyGenerateTicket() async {
    final token = await TLocalStorage().readData('token');
    final payload = {
      token: '$token',
      "merchantOrderId": verifyPaymentData.orderId,
      "merchantId": dotenv.env["TSAVAARI_MERCHANT_ID"]
    };
    Future.delayed(const Duration(seconds: 5), () async {
      try {
        final verifyGenerateTicketResponse =
            await bookQrRepository.verifyGenerateTicket(payload);
        if (verifyGenerateTicketResponse.returnCode == "0" &&
            verifyGenerateTicketResponse.returnMsg == "SUCESS") {
          Get.offAll(() => DisplayQrScreen(
                tickets: verifyGenerateTicketResponse.tickets!,
                stationList: stationController.stationList,
                orderId: verifyGenerateTicketResponse.orderId!,
              ));
        } else {
          final mobileNumber = TLocalStorage().readData('mobileNo');
          final refundOrderResponse =
              await cashFreePaymentController.createRefundOrder(
            verifyPaymentData.orderId!,
            verifyPaymentData.orderAmount!,
            mobileNumber,
            checkBoxValue.length,
            '',
          );
          if (refundOrderResponse.cfPaymentId != null &&
              refundOrderResponse.cfRefundId != null) {
            final getRefundStatus =
                await cashFreePaymentController.getRefundStatus(
                    verifyPaymentData.orderId!, refundOrderResponse.refundId!);
            if (getRefundStatus.refundStatus == 'SUCCESS') {
            } else if (getRefundStatus.refundStatus == 'PENDING') {
              final payload = {
                "token": "$token",
                "merchantOrderId": verifyPaymentData.orderId,
                "merchantId": dotenv.env["TSAVAARI_MERCHANT_SHORT_ID"],
                "ticketTypeId": '10', //SJT
                "noOfTickets": checkBoxValue.length,
                "merchantTotalFareAfterGst": verifyPaymentData.orderAmount,
                "travelDateTime": "${DateTime.now()}",
                "patronPhoneNumber":
                    await TLocalStorage().readData('mobileNo') ?? ''
              };
              final response =
                  await bookQrRepository.paymentRefundIntimation(payload);
              if (response.returnCode == '0') {
                isGenerateTicketError.value = true;
              } else {
                throw 'Something went wrong!';
              }
            }
          }
        }
      } catch (e) {
        rethrow;
      }
    });
  }
}

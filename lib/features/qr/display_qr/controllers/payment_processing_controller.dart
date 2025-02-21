import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:tsavaari/data/repositories/book_qr/book_qr_repository.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/station_list_controller.dart';
import 'package:tsavaari/features/qr/book_qr/models/create_order_model.dart';
import 'package:tsavaari/features/qr/display_qr/screens/display_qr.dart';
import 'package:tsavaari/utils/local_storage/storage_utility.dart';
import 'package:tsavaari/utils/payment_gateway/cash_free.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class PaymentProcessingController extends GetxController {
  PaymentProcessingController(
      {required this.verifyPaymentData, required this.requestPayload});
  final CreateOrderModel verifyPaymentData;
  final Map<String, Object?> requestPayload;
  final bookQrRepository = Get.put(BookQrRepository());
  final stationController = Get.put(StationListController());
  var verifyApiCounter = 0;
  final isPaymentVerifing = false.obs;
  final hasVerifyPaymentSuccess = false.obs;
  final hasPaymentVerifyRetriesCompleted = false.obs;
  final isGenerateTicketError = false.obs;
  final cashFreePaymentController = Get.put(CashFreeController());

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
              await generateTicket();
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

  Future<void> generateTicket() async {
    try {
      final ticketData = await bookQrRepository.generateTicket(requestPayload);
      //Navigate to Dispaly QR Page
      if (ticketData.returnCode == '0' && ticketData.returnMsg == 'SUCESS') {
        Get.offAll(() => DisplayQrScreen(
              tickets: ticketData.tickets!,
              stationList: stationController.stationList,
              orderId: ticketData.orderId!,
            ));
      } else {
        await verifyGenerateTicket();
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
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
            int.parse(requestPayload['noOfTickets'].toString()),
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
                "ticketTypeId": requestPayload['ticketTypeId'],
                "noOfTickets": requestPayload['noOfTickets'],
                "merchantTotalFareAfterGst":
                    requestPayload['merchantTotalFareAfterGst'],
                "travelDateTime": requestPayload['travelDateTime'],
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

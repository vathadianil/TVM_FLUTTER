import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tsavaari/data/repositories/refund_qr/refund_qr_repository.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/refund_message_screen.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/ticket_status_codes.dart';
import 'package:tsavaari/utils/helpers/network_manager.dart';
import 'package:tsavaari/utils/local_storage/storage_utility.dart';
import 'package:tsavaari/utils/payment_gateway/cash_free.dart';
import 'package:tsavaari/utils/popups/full_screen_loader.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class RefundPreviewController extends GetxController {
  RefundPreviewController({
    required this.tickets,
    required this.orderId,
  });
  static RefundPreviewController get instance => Get.find();

  RxList radioSelectedValue = [].obs;
  List<TicketsListModel> tickets;
  String orderId;
  final deviceStorage = GetStorage();
  final isLoading = false.obs;
  final _refundQrRepository = Get.put(RefundQrRepository());
  final refundPreviewData = [].obs;
  final refundConfirmData = [].obs;
  var apiArray = <Future<dynamic>>[];
  RxDouble totalRefundAmount = 0.0.obs;
  final cashFreePaymentController = Get.put(CashFreeController());

  @override
  void onInit() {
    super.onInit();
    getRefundPreview();
  }

  Future<void> getRefundPreview() async {
    try {
      final token = await deviceStorage.read('token');
      refundPreviewData.clear();

      for (var index = 0; index < tickets.length; index++) {
        Future.delayed(Duration(seconds: index), () async {
          isLoading.value = true;
          final response = await _refundQrRepository.refundPreview({
            "token": "$token",
            "ticketId": (tickets[index].ticketType ==
                        TicketStatusCodes.ticketTypeSjtString ||
                    tickets[index].ticketTypeId ==
                        TicketStatusCodes.ticketTypeSjt)
                ? tickets[index].ticketId
                : '',
            "rjtId": (tickets[index].ticketType ==
                        TicketStatusCodes.ticketTypeRjtString ||
                    tickets[index].ticketTypeId ==
                        TicketStatusCodes.ticketTypeRjt)
                ? (tickets[index].rjtID ?? tickets[index].rjtId)
                : '',
            "passId": "",
            "merchantId": dotenv.env["TSAVAARI_MERCHANT_ID"],
            "ltmrhlPurchaseId": "",
            "transactionType": "",
            "refundQuoteId": ""
          });
          refundPreviewData.add(response.response![0]);

          if (index == tickets.length - 1) {
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

  String getRjtIds() {
    return radioSelectedValue.map((item) => item.toString()).join(',');
  }

  Future<void> getRefundConfirm() async {
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
      final mobileNumber = TLocalStorage().readData('mobileNo');
      var rjtIds = '';
      if (tickets[0].ticketType == TicketStatusCodes.ticketTypeRjtString ||
          tickets[0].ticketTypeId == TicketStatusCodes.ticketTypeRjt) {
        rjtIds = getRjtIds();
      }

      final refundOrderResponse =
          await cashFreePaymentController.createRefundOrder(
              orderId,
              totalRefundAmount.value,
              mobileNumber,
              radioSelectedValue.length,
              rjtIds);
      if (refundOrderResponse.cfPaymentId != null &&
          refundOrderResponse.cfRefundId != null) {
        final getRefundStatus = await cashFreePaymentController.getRefundStatus(
            orderId, refundOrderResponse.refundId!);
        if (getRefundStatus.refundStatus == 'SUCCESS' ||
            getRefundStatus.refundStatus == 'PENDING') {
          var refundQuoteIdList = [];
          for (var index = 0; index < tickets.length; index++) {
            if (tickets[index].ticketType ==
                    TicketStatusCodes.ticketTypeRjtString ||
                tickets[index].ticketTypeId ==
                    TicketStatusCodes.ticketTypeRjt) {
              refundQuoteIdList.addIf(
                  radioSelectedValue.contains(refundPreviewData[index].rjtId),
                  refundPreviewData[index].refundQuoteId);
            } else {
              refundQuoteIdList.addIf(
                  radioSelectedValue
                      .contains(refundPreviewData[index].ticketid),
                  refundPreviewData[index].refundQuoteId);
            }
          }
          for (var index = 0; index < radioSelectedValue.length; index++) {
            apiArray.add(_refundQrRepository.refundConfirm({
              "token": "$token",
              "ticketId": (tickets[index].ticketType ==
                          TicketStatusCodes.ticketTypeSjtString ||
                      tickets[index].ticketTypeId ==
                          TicketStatusCodes.ticketTypeSjt)
                  ? radioSelectedValue[index]
                  : '',
              "rjtId": (tickets[index].ticketType ==
                          TicketStatusCodes.ticketTypeRjtString ||
                      tickets[index].ticketTypeId ==
                          TicketStatusCodes.ticketTypeRjt)
                  ? radioSelectedValue[index]
                  : '',
              "passId": "",
              "merchantId": dotenv.env["TSAVAARI_MERCHANT_ID"],
              "ltmrhlPurchaseId": "",
              "transactionType": "107",
              "refundQuoteId": refundQuoteIdList[index]
            }));
          }

          final response = await Future.wait(apiArray);
          refundConfirmData.assignAll(response);

          //Stop Loading
          TFullScreenLoader.stopLoading();
          var isSuccess = true;
          for (var refundStatus in response) {
            final status = refundStatus.response[0];
            if (status.returnCode != '0') {
              isSuccess = false;
            }
          }

          if (isSuccess) {
            Get.offAll(
              () => RefundMessageScreen(refundStatusData: getRefundStatus),
            );
          }
        } else {
          throw ('Unable to Process the request!. Please try again');
        }
      } else {
        throw ('Unable to Process the request!. Please try again');
      }
    } catch (e) {
      //Stop Loading
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}

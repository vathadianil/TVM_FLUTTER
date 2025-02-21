import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/qr/display_qr/models/payment_failed_ticket_model.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/exceptions/format_exceptions.dart';
import 'package:tsavaari/utils/exceptions/platform_exceptions.dart';
import 'package:tsavaari/utils/http/http_client.dart';

class MyOrdersRepository extends GetxController {
  Future<ActiveTicketModel> fetchActiveTickets(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.getActiveTickets,
        payload,
      );

      return ActiveTicketModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<ActiveTicketModel> fetchPastTickets(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.getPastTickets,
        payload,
      );
      return ActiveTicketModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<QrPaymentFailedModel> fetchPaymentFailedAndRefundedTickets(
      payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.getPaymentFailedAndRefundedTickets,
        payload,
      );
      return QrPaymentFailedModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }
}

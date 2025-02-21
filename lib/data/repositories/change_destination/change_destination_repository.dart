import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/qr/display_qr/models/change_destination_preview_model.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/exceptions/format_exceptions.dart';
import 'package:tsavaari/utils/exceptions/platform_exceptions.dart';
import 'package:tsavaari/utils/http/http_client.dart';

class ChangeDestinationRepository extends GetxController {
  Future<ChangeDestinationPreviewModel> changeDestinationPreview(
      payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.changeDestinationPreview,
        payload,
      );

      return ChangeDestinationPreviewModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<TicketsListModel> changeDestinationConfirm(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.changeDestinationConfirm,
        payload,
      );

      return TicketsListModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<void> changeDestTicketPaymentFailedStatus(payload) async {
    try {
      // final data =
      await THttpHelper.post(
        ApiEndPoint.changeDestTicketPaymentFailed,
        payload,
      );
      // return QrTicketModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<QrTicketModel> verifyGenerateTicket(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.verifyGenerateTicket,
        payload,
      );
      return QrTicketModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }
}

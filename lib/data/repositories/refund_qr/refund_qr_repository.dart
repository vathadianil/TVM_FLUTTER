import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/qr/display_qr/models/create_refund_model.dart';
import 'package:tsavaari/features/qr/display_qr/models/refund_confirm_model.dart';
import 'package:tsavaari/features/qr/display_qr/models/refund_preview_model.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/exceptions/format_exceptions.dart';
import 'package:tsavaari/utils/exceptions/platform_exceptions.dart';
import 'package:tsavaari/utils/http/http_client.dart';

class RefundQrRepository extends GetxController {
  Future<RefundPreviewModel> refundPreview(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.refundPreview,
        payload,
      );

      return RefundPreviewModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<CreateRefundModel> createRefundOrder(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.createRefundOrder,
        payload,
      );

      return CreateRefundModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<CreateRefundModel> getRefundOrderStatus(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.refundOrderStatus,
        payload,
      );

      return CreateRefundModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<RefundConfirmModel> refundConfirm(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.refundConfirm,
        payload,
      );

      return RefundConfirmModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }
}

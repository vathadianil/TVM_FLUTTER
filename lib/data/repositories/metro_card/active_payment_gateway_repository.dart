import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/card_reacharge/models/payment_gateway_switching_model.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/exceptions/format_exceptions.dart';
import 'package:tsavaari/utils/exceptions/platform_exceptions.dart';
import 'package:tsavaari/utils/http/http_client.dart';

class ActivePaymentGatewayRepository extends GetxController {
  static ActivePaymentGatewayRepository get instance => Get.find();
  Future<ActivePaymentGateWayModel> getActivePaymentGateway() async {
    try {
      final data = await THttpHelper.get(
        ApiEndPoint.activePaymentGateway,
      );
      return ActivePaymentGateWayModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }
}

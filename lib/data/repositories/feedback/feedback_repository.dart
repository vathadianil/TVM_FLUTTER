import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/authentication/login/models/login_model.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/exceptions/format_exceptions.dart';
import 'package:tsavaari/utils/exceptions/platform_exceptions.dart';
import 'package:tsavaari/utils/http/http_client.dart';

class FeedbackRepository extends GetxController {
  static FeedbackRepository get instance => Get.find();

  Future<LoginModel> sendFeedback(payload, String authToken) async {
    try {
      final data = await THttpHelper.post(
        '${ApiEndPoint.postFeedback}?auth_token=$authToken',
        payload
      );
      
      return LoginModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw 'Something went wrong. Please try again later!';
    }
  }

}

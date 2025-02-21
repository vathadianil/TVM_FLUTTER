import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/notifications/models/notification_model.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/exceptions/format_exceptions.dart';
import 'package:tsavaari/utils/exceptions/platform_exceptions.dart';
import 'package:tsavaari/utils/http/http_client.dart';

class NotificationsRepository extends GetxController {
  static NotificationsRepository get instance => Get.find();

  //Get all the notifications
  Future<NotificationsModel> getAllNotifications() async {
    try {
      final data = await THttpHelper.get(
        ApiEndPoint.getNotifications,
      );
      return NotificationsModel.fromJson(data);
    }
    on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw 'Something went wrong. Please try again later!';
    }
  }
  
}

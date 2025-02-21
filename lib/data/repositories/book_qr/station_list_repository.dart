import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/qr/book_qr/models/business_hours_model.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/exceptions/format_exceptions.dart';
import 'package:tsavaari/utils/exceptions/platform_exceptions.dart';
import 'package:tsavaari/utils/http/http_client.dart';

class StationListRepository extends GetxController {
  Future<StationDataModel> fetchStationList(String token) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.getStations,
        {"token": token},
      );

      return StationDataModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<BusinessHoursModel> fetchBusineesHours(String token) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.getBusinessHours,
        {"token": token},
      );

      return BusinessHoursModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }
}

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/station_facilities/models/station_list_lat_lng_model.dart';
import 'package:tsavaari/features/station_facilities/models/station_facilities_services_model.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/exceptions/format_exceptions.dart';
import 'package:tsavaari/utils/exceptions/platform_exceptions.dart';
import 'package:tsavaari/utils/http/http_client.dart';


class StationFacilitiesRepository extends GetxController {
  
  Future<StationsWithCoordsModel> fetchStationsWithCoordsList() async {
    try {
      final data = await THttpHelper.get(
        ApiEndPoint.getStationsWithCoords,
      );
      return StationsWithCoordsModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }


  Future<MetroStationFacilitiesServicesModel> fetchMetroStationFacilitiesServices({required int stnId}) async {
    try {
      final data = await THttpHelper.get(
        '${ApiEndPoint.getStationFacilitiesServices}$stnId',
      );
      return MetroStationFacilitiesServicesModel.fromJson(data);
    
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }
}

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/home/models/banner_model.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/exceptions/format_exceptions.dart';
import 'package:tsavaari/utils/exceptions/platform_exceptions.dart';
import 'package:tsavaari/utils/http/http_client.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  //Get all the banners
  Future<BannerModel> getAllBanners() async {
    try {
      final data = await THttpHelper.get(
        ApiEndPoint.getBannners,
      );
      return BannerModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }
  
}

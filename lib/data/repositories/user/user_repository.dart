import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/authentication/login/models/login_model.dart';
import 'package:tsavaari/features/profile/models/otp_profile_update_model.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/exceptions/format_exceptions.dart';
import 'package:tsavaari/utils/exceptions/platform_exceptions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsavaari/utils/http/http_client.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  //-- Function to fetch user data from  db
  Future<LoginModel> fetchUserDetails({required int uid, required String authToken}) async {
    try {
      final data = await THttpHelper.get(
        '${ApiEndPoint.getUserInfo}$uid?auth_token=$authToken',
      );
      return LoginModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  //-- Function to update user data in  db
  Future<LoginModel> updateUserDetails({required int uid, required Map<String, Object> payload, required String authToken}) async {
    try {
      final data = await THttpHelper.patch(
        '${ApiEndPoint.updateUserInfo}$uid?auth_token=$authToken',
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

  //-- Function to request Otp for profile update 
  Future<OtpProfileUpdateModel> requestOtpProfileUpdate({required int uid, required Map<String, Object> payload, required String authToken}) async {
    try {
      final data = await THttpHelper.patch(
        '${ApiEndPoint.requestOtpProfileUpdate}$uid?auth_token=$authToken',
        payload
      );
      return OtpProfileUpdateModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw 'Something went wrong. Please try again later!';
    }
  }

  //Upload Image
  Future<String?> uploadImage(String path, XFile image) async {
    try {
      //code to upload image
      return null;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }
}

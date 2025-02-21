import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tsavaari/bottom_navigation/bottom_navigation_menu.dart';
import 'package:tsavaari/features/authentication/login/models/login_model.dart';
import 'package:tsavaari/features/authentication/login/models/token_model.dart';
import 'package:tsavaari/features/authentication/login/screens/login.dart';
import 'package:tsavaari/features/authentication/otp/models/otp_model.dart';
import 'package:tsavaari/features/authentication/register/models/user_register_model.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/exceptions/format_exceptions.dart';
import 'package:tsavaari/utils/exceptions/platform_exceptions.dart';
import 'package:tsavaari/utils/http/http_client.dart';
import 'package:tsavaari/utils/local_storage/storage_utility.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Variables
  final deviceStorage = GetStorage();

  //Called from app.dart on app launch
  @override
  void onReady() {
    super.onReady();
    FlutterNativeSplash.remove();
    Timer(const Duration(seconds: 2), () {
      screenRedirect();
    });
  }

  //Function show relevant screen
  screenRedirect() async {
    final token = await TLocalStorage().readData('token') ?? '';
    if (token != '') {
      Get.offAll(() => const BottomNavigationMenu());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  Future<TokenModel> getToken() async {
    try {
      final data = await THttpHelper.get(
        ApiEndPoint.getToken,
      );
      return TokenModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<LoginModel> login(payload) async {
    try {
      final data = await THttpHelper.patch(ApiEndPoint.login, payload);
      return LoginModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<UserRegisterModel> register(payload) async {
    try {
      final data = await THttpHelper.post(ApiEndPoint.registerUser, payload);

      return UserRegisterModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<OtpModel> verifyOTP(payload) async {
    try {
      final data = await THttpHelper.patch(ApiEndPoint.verifyOTP, payload);

      return OtpModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<OtpModel> resendOTP(payload) async {
    try {
      final data = await THttpHelper.patch(ApiEndPoint.resendOTP, payload);
      return OtpModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<LoginModel> logout({required int uid, required Map<String, dynamic> payload}) async {
    try {
      final data = await THttpHelper.patch('${ApiEndPoint.logout}$uid', payload);
      return LoginModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }
}
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/reward_points/models/redeem_points_model.dart';
import 'package:tsavaari/features/reward_points/models/redemption_eligibility_model.dart';
import 'package:tsavaari/features/reward_points/models/user_points_summary_model.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/exceptions/format_exceptions.dart';
import 'package:tsavaari/utils/exceptions/platform_exceptions.dart';
import 'package:tsavaari/utils/http/http_client.dart';

import '../../../features/reward_points/models/loyalty_points_history_model.dart';

class LoyaltyPointsRepository extends GetxController {
  static LoyaltyPointsRepository get instance => Get.find();

  Future<UserPointsSummaryModel> getUserPointsSummary({required int uid}) async {
    try {
      final data = await THttpHelper.get(
        '${ApiEndPoint.getUserPointsSummary}$uid',
      );
      
      return UserPointsSummaryModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<RedemptionEligibilityModel> checkRedemptionEligibility(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.checkRedemptionEligibility,
        payload
      );
      
      return RedemptionEligibilityModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<RedeemPointsModel> redeemPoints(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.redeemPoints,
        payload
      );
      
      return RedeemPointsModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<LoyaltyPointsHistoryModel> getLoyaltyPointsHistory(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.getLoyaltyPointsHistory,
        payload
      );
      
      return LoyaltyPointsHistoryModel.fromJson(data);
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

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/card_reacharge/models/add_card_balance_model.dart';
import 'package:tsavaari/features/card_reacharge/models/card_details_by_user_model.dart';
import 'package:tsavaari/features/card_reacharge/models/card_recharge_amounts_model.dart';
import 'package:tsavaari/features/card_reacharge/models/card_travel_history_model.dart';
import 'package:tsavaari/features/card_reacharge/models/card_trx_details_model.dart';
import 'package:tsavaari/features/card_reacharge/models/inquiry_afc_model.dart';
import 'package:tsavaari/features/card_reacharge/models/last_recharge_status_model.dart';
import 'package:tsavaari/features/card_reacharge/models/nebula_card_validation_model.dart';
import 'package:tsavaari/features/card_reacharge/models/paytm_initiate_payment_model.dart';
import 'package:tsavaari/features/card_reacharge/models/paytm_verify_payment_model.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/exceptions/format_exceptions.dart';
import 'package:tsavaari/utils/exceptions/platform_exceptions.dart';
import 'package:tsavaari/utils/http/http_client.dart';

class MetroCardRepository extends GetxController {
  static MetroCardRepository get instance => Get.find();

  Future<CardDetailsByUserModel> getMetroCardDetailsByUser(userId) async {
    try {
      final data = await THttpHelper.get(
        '${ApiEndPoint.getCardDetailsByUser}$userId',
      );
      return CardDetailsByUserModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<LastRechargeStatusModel> getLastTransactionDetailsByCard(
      payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.getLastRechargeStatus,
        payload,
      );
      return LastRechargeStatusModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<NebulaCardValidationModel> validateNebulaCard(
    payload,
  ) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.validateNebulaCardUrl,
        payload,
      );
      return NebulaCardValidationModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<CardTrxDetailsModel> getCardTrxDetails(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.getCardTrxDetails,
        payload,
      );
      return CardTrxDetailsModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<CardTravelHistoryModel> getCardTravelHistory(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.getCardTravelHistory,
        payload,
      );
      return CardTravelHistoryModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<CardDetailsByUserModel> addOrUpdateCardDetailsByUser(payload) async {
    try {
      final data =
          await THttpHelper.post(ApiEndPoint.addOrUpdateCardDetails, payload);
      return CardDetailsByUserModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<CardDetailsByUserModel> deleteCardDetailsByUser(userId, cardNo) async {
    try {
      final data = await THttpHelper.delete(
          '${ApiEndPoint.deleteCard}$userId&CARDNO=$cardNo');
      return CardDetailsByUserModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<Map<String, dynamic>> generatePayUHash(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.generatePayUHash,
        payload,
      );
      return data;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<PaytmPaymentInitiateModel> initiatePaytmPayment(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.initiatePaytmPayment,
        payload,
      );
      return PaytmPaymentInitiateModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<PaytmPaymentInitiateModel> getPaytmPaymentStatus(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.getPaytmPaymentStatus,
        payload,
      );
      return PaytmPaymentInitiateModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<void> postPaytmPaymentFailedData(payload) async {
    try {
      await THttpHelper.post(
        ApiEndPoint.paytmPaymentFailedData,
        payload,
      );
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<AddCardBalanceModel> addCardBalance(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.addCardBalance,
        payload,
      );
      return AddCardBalanceModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<InquiryAfcModel> inquiryAfc(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.inquiryAfc,
        payload,
      );
      return InquiryAfcModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<CardRechargeAmountsModel> getCardRechargeAmounts() async {
    try {
      final data = await THttpHelper.get(
        ApiEndPoint.cardRechargeAmounts,
      );
      return CardRechargeAmountsModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<PaytmVefiyPaymentModel> verifyPaytmPayment(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.getPaytmPaymentStatus,
        payload,
      );
      return PaytmVefiyPaymentModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<PaytmVefiyPaymentModel> refundPaytmRechargeAmount(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.refundPaytmPayment,
        payload,
      );
      return PaytmVefiyPaymentModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }
}

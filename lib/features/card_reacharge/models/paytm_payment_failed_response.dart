import 'package:tsavaari/features/card_reacharge/models/paytm_trasaction_response_model.dart';

class PaytmePaymentFailedException {
  final String code;
  final String message;
  final PaytmTransactionResponseModel details;
  final dynamic stackTrace;

  PaytmePaymentFailedException({
    required this.code,
    required this.message,
    required this.details,
    this.stackTrace,
  });

  factory PaytmePaymentFailedException.fromJson(Map<String, dynamic> json) {
    return PaytmePaymentFailedException(
      code: json['code'],
      message: json['message'],
      details: PaytmTransactionResponseModel.fromJson(json['details']),
      stackTrace: json['stackTrace'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'details': details.toJson(),
      'stackTrace': stackTrace,
    };
  }
}

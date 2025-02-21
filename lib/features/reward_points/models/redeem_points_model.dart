class RedeemPointsModel {
  final String? message;
  final bool? success;
  final String? quoteId;
  final int? amountCredited;
  final int? deductedPoints;
  final int? availablePoints;

  RedeemPointsModel({
    this.message,
    this.success,
    this.quoteId,
    this.amountCredited,
    this.deductedPoints,
    this.availablePoints,
  });

  factory RedeemPointsModel.fromJson(Map<String, dynamic> json) {
    return RedeemPointsModel(
      message: json['message'] as String?,
      success: json['success'] as bool?,
      quoteId: json['quote_id'] as String?,
      amountCredited: json['amount_credited'] as int?,
      deductedPoints: json['deducted_points'] as int?,
      availablePoints: json['available_points'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': success,
      'quote_id': quoteId,
      'amount_credited': amountCredited,
      'deducted_points': deductedPoints,
      'available_points': availablePoints,
    };
  }
}

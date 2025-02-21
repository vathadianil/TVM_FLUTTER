class RedemptionEligibilityModel {
  String? message;
  int? eligible;
  String? quoteId;
  int? availablePoints;
  int? pointsToRedeem;
  int? maxRedemptionAmount;
  int? loyaltyProgramKey;
  int? minRedemptionPoints;

  RedemptionEligibilityModel({
    this.message,
    this.eligible,
    this.quoteId,
    this.availablePoints,
    this.pointsToRedeem,
    this.maxRedemptionAmount,
    this.loyaltyProgramKey,
    this.minRedemptionPoints
  });

  factory RedemptionEligibilityModel.fromJson(Map<String, dynamic> json) {
    return RedemptionEligibilityModel(
      message: json['message'],
      eligible: json['eligible'],
      quoteId: json['quote_id'],
      availablePoints: json['available_points'],
      pointsToRedeem: json['points_to_redeem'],
      maxRedemptionAmount: json['max_redemption_amount'],
      loyaltyProgramKey: json['loyalty_program_key'],
      minRedemptionPoints: json['min_redemption_points'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'eligible': eligible,
      'quote_id': quoteId,
      'available_points': availablePoints,
      'points_to_redeem': pointsToRedeem,
      'max_redemption_amount': maxRedemptionAmount,
      'loyalty_program_key': loyaltyProgramKey,
      'min_redemption_points': minRedemptionPoints
    };
  }
}

class UserPointsSummaryModel {
  final TotalSummary? totalSummary;
  final PointsSummary? pointsSummary;

  UserPointsSummaryModel({
    this.totalSummary,
    this.pointsSummary,
  });

  factory UserPointsSummaryModel.fromJson(Map<String, dynamic> json) {
    return UserPointsSummaryModel(
      totalSummary: json['total_summary'] != null
          ? TotalSummary.fromJson(json['total_summary'])
          : null,
      pointsSummary: json['points_summary'] != null
          ? PointsSummary.fromJson(json['points_summary'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_summary': totalSummary?.toJson(),
      'points_summary': pointsSummary?.toJson(),
    };
  }
}

class TotalSummary {
  final int? activePoints;
  final int? expiredPoints;
  final int? redeemedPoints;
  final int? totalTransactions;
  final int? loyaltyProgramKey;
  final int? totalPointsEarned;
  final double? maxRedemptionAmount;
  final int? maxRedemptionPoints;
  final int? minRedemptionPoints;


  TotalSummary({
    this.activePoints,
    this.expiredPoints,
    this.redeemedPoints,
    this.totalTransactions,
    this.loyaltyProgramKey,
    this.totalPointsEarned,
    this.maxRedemptionAmount,
    this.maxRedemptionPoints,
    this.minRedemptionPoints
  });

  factory TotalSummary.fromJson(Map<String, dynamic> json) {
    return TotalSummary(
      activePoints: json['active_points'],
      expiredPoints: json['expired_points'],
      redeemedPoints: json['redeemed_points'],
      totalTransactions: json['total_transactions'],
      loyaltyProgramKey: json['loyalty_program_key'],
      totalPointsEarned: json['total_points_earned'],
      maxRedemptionAmount: json['max_redemption_amount'],
      maxRedemptionPoints: json['max_redemption_points'],
      minRedemptionPoints: json['min_redemption_points'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'active_points': activePoints,
      'expired_points': expiredPoints,
      'redeemed_points': redeemedPoints,
      'total_transactions': totalTransactions,
      'loyalty_program_key': loyaltyProgramKey,
      'total_points_earned': totalPointsEarned,
      'max_redemption_amount' : maxRedemptionAmount,
      'max_redemption_points': maxRedemptionPoints,
      'min_redemption_points': minRedemptionPoints
    };
  }
}

class PointsSummary {
  final List<ActivePoint>? active;
  final List<RedeemedPoint>? redeemed;
  final dynamic expired;

  PointsSummary({
    this.active,
    this.redeemed,
    this.expired,
  });

  factory PointsSummary.fromJson(Map<String, dynamic> json) {
    return PointsSummary(
      active: json['ACTIVE'] != null
          ? List<ActivePoint>.from(
              json['ACTIVE'].map((x) => ActivePoint.fromJson(x)))
          : null,
      redeemed: json['REDEEMED'] != null
          ? List<RedeemedPoint>.from(
              json['REDEEMED'].map((x) => RedeemedPoint.fromJson(x)))
          : null,
      expired: json['EXPIRED'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ACTIVE': active != null
          ? List<dynamic>.from(active!.map((x) => x.toJson()))
          : null,
      'REDEEMED': redeemed != null
          ? List<dynamic>.from(redeemed!.map((x) => x.toJson()))
          : null,
      'EXPIRED': expired,
    };
  }
}

class ActivePoint {
  final String? pointsType;
  final int? totalPoints;
  final DateTime? lastTransaction;
  final DateTime? firstTransaction;
  final int? transactionCount;

  ActivePoint({
    this.pointsType,
    this.totalPoints,
    this.lastTransaction,
    this.firstTransaction,
    this.transactionCount,
  });

  factory ActivePoint.fromJson(Map<String, dynamic> json) {
    return ActivePoint(
      pointsType: json['points_type'],
      totalPoints: json['total_points'],
      lastTransaction: json['last_transaction'] != null
          ? DateTime.parse(json['last_transaction'])
          : null,
      firstTransaction: json['first_transaction'] != null
          ? DateTime.parse(json['first_transaction'])
          : null,
      transactionCount: json['transaction_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'points_type': pointsType,
      'total_points': totalPoints,
      'last_transaction': lastTransaction?.toIso8601String(),
      'first_transaction': firstTransaction?.toIso8601String(),
      'transaction_count': transactionCount,
    };
  }
}

class RedeemedPoint {
  final String? pointsType;
  final int? totalPoints;
  final DateTime? lastTransaction;
  final DateTime? firstTransaction;
  final int? transactionCount;

  RedeemedPoint({
    this.pointsType,
    this.totalPoints,
    this.lastTransaction,
    this.firstTransaction,
    this.transactionCount,
  });

  factory RedeemedPoint.fromJson(Map<String, dynamic> json) {
    return RedeemedPoint(
      pointsType: json['points_type'],
      totalPoints: json['total_points'],
      lastTransaction: json['last_transaction'] != null
          ? DateTime.parse(json['last_transaction'])
          : null,
      firstTransaction: json['first_transaction'] != null
          ? DateTime.parse(json['first_transaction'])
          : null,
      transactionCount: json['transaction_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'points_type': pointsType,
      'total_points': totalPoints,
      'last_transaction': lastTransaction?.toIso8601String(),
      'first_transaction': firstTransaction?.toIso8601String(),
      'transaction_count': transactionCount,
    };
  }
}




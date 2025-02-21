class LoyaltyPointsHistoryModel {
  dynamic response;
  String? date;
  String? type;
  int? points;
  int? userId;
  String? mobileNo;
  String? transactionRef;
  String? transactionType;
  String? transactionCategory;
  String? qrorderidOrCardNumber;
  int? currentRewardPointsBalance;
  String? previousRewardPointsBalance;

  LoyaltyPointsHistoryModel({
    this.response,
    this.date,
    this.type,
    this.points,
    this.userId,
    this.mobileNo,
    this.transactionRef,
    this.transactionType,
    this.transactionCategory,
    this.qrorderidOrCardNumber,
    this.currentRewardPointsBalance,
    this.previousRewardPointsBalance});

  LoyaltyPointsHistoryModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    date = json['date'];
    type = json['type'];
    points = json['points'];
    userId = json['user_id'];
    mobileNo = json['mobile_no'];
    transactionRef = json['transaction_ref'];
    transactionType = json['transaction_type'];
    transactionCategory = json['transaction_category'];
    qrorderidOrCardNumber = json['qrorderid_or_card_number'];
    currentRewardPointsBalance = json['current_reward_points_balance'];
    previousRewardPointsBalance = json['previous_reward_points_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['date'] = this.date;
    data['type'] = this.type;
    data['points'] = this.points;
    data['user_id'] = this.userId;
    data['mobile_no'] = this.mobileNo;
    data['transaction_ref'] = this.transactionRef;
    data['transaction_type'] = this.transactionType;
    data['transaction_category'] = this.transactionCategory;
    data['qrorderid_or_card_number'] = this.qrorderidOrCardNumber;
    data['current_reward_points_balance'] = this.currentRewardPointsBalance;
    data['previous_reward_points_balance'] = this.previousRewardPointsBalance;
    return data;
  }
}

class ActivePaymentGateWayModel {
  int? pgId;
  String? pgName;
  int? isActive;
  String? pgDescription;

  ActivePaymentGateWayModel(
      {this.pgId, this.pgName, this.isActive, this.pgDescription});

  ActivePaymentGateWayModel.fromJson(Map<String, dynamic> json) {
    pgId = json['pg_id'];
    pgName = json['pg_name'];
    isActive = json['is_active'];
    pgDescription = json['pg_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pg_id'] = pgId;
    data['pg_name'] = pgName;
    data['is_active'] = isActive;
    data['pg_description'] = pgDescription;
    return data;
  }
}

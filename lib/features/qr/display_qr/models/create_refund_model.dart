class CreateRefundModel {
  String? cfPaymentId;
  String? cfRefundId;
  String? createdAt;
  String? entity;
  String? metadata;
  String? orderId;
  String? processedAt;
  String? refundAmount;
  String? refundArn;
  String? refundCharge;
  String? refundCurrency;
  String? refundId;
  String? refundMode;
  String? refundNote;
  RefundSpeed? refundSpeed;
  List<Null>? refundSplits;
  String? refundStatus;
  String? refundType;
  String? statusDescription;

  CreateRefundModel(
      {this.cfPaymentId,
      this.cfRefundId,
      this.createdAt,
      this.entity,
      this.metadata,
      this.orderId,
      this.processedAt,
      this.refundAmount,
      this.refundArn,
      this.refundCharge,
      this.refundCurrency,
      this.refundId,
      this.refundMode,
      this.refundNote,
      this.refundSpeed,
      this.refundSplits,
      this.refundStatus,
      this.refundType,
      this.statusDescription});

  CreateRefundModel.fromJson(Map<String, dynamic> json) {
    cfPaymentId = json['cf_payment_id'];
    cfRefundId = json['cf_refund_id'];
    createdAt = json['created_at'];
    entity = json['entity'];
    metadata = json['metadata'];
    orderId = json['order_id'];
    processedAt = json['processed_at'];
    refundAmount = json['refund_amount'].toString();
    refundArn = json['refund_arn'];
    refundCharge = json['refund_charge'].toString();
    refundCurrency = json['refund_currency'];
    refundId = json['refund_id'];
    refundMode = json['refund_mode'];
    refundNote = json['refund_note'];
    refundSpeed = json['refund_speed'] != null
        ? RefundSpeed.fromJson(json['refund_speed'])
        : null;
    if (json['refund_splits'] != null) {
      refundSplits = [];
    }
    refundStatus = json['refund_status'];
    refundType = json['refund_type'];
    statusDescription = json['status_description'];
  }
}

class RefundSpeed {
  String? requested;
  String? accepted;
  String? processed;
  String? message;

  RefundSpeed({this.requested, this.accepted, this.processed, this.message});

  RefundSpeed.fromJson(Map<String, dynamic> json) {
    requested = json['requested'];
    accepted = json['accepted'];
    processed = json['processed'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['requested'] = requested;
    data['accepted'] = accepted;
    data['processed'] = processed;
    data['message'] = message;
    return data;
  }
}

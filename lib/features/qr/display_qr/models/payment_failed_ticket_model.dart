class QrPaymentFailedModel {
  List<PaymentFailedData>? paymentFailed;

  QrPaymentFailedModel({this.paymentFailed});

  QrPaymentFailedModel.fromJson(Map<String, dynamic> json) {
    if (json['payment_failed'] != null) {
      paymentFailed = <PaymentFailedData>[];
      json['payment_failed'].forEach((v) {
        paymentFailed!.add(PaymentFailedData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paymentFailed != null) {
      data['payment_failed'] = paymentFailed!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentFailedData {
  String? type;
  String? orderId;
  String? ticketId;
  String? refundId;
  String? createdAt;
  int? noOfTickets;
  String? refundType;
  String? toStationId;
  String? failureCode;
  String? ticketTypeId;
  String? fromStationId;
  String? refundAmount;
  String? refundStatus;
  String? failureReason;
  String? travelDateTime;
  String? updateDateTime;
  String? merchantOrderId;
  String? purchaseDatetime;
  String? statusDescription;
  String? merchantTotalFareAfterGst;
  String? qrPgOrderId;
  String? qrPgRefundId;
  String? paymentMethod;
  String? paymentTxnId;
  String? bankReference;

  PaymentFailedData(
      {this.type,
      this.orderId,
      this.ticketId,
      this.refundId,
      this.createdAt,
      this.noOfTickets,
      this.refundType,
      this.toStationId,
      this.failureCode,
      this.ticketTypeId,
      this.fromStationId,
      this.refundAmount,
      this.refundStatus,
      this.failureReason,
      this.travelDateTime,
      this.updateDateTime,
      this.merchantOrderId,
      this.purchaseDatetime,
      this.statusDescription,
      this.merchantTotalFareAfterGst,
      this.qrPgOrderId,
      this.qrPgRefundId,
      this.paymentMethod,
      this.paymentTxnId,
      this.bankReference});

  PaymentFailedData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    orderId = json['order_id'];
    ticketId = json['ticketId'];
    refundId = json['refund_id'];
    createdAt = json['created_at'];
    noOfTickets = json['noOfTickets'] ?? json['noOfTckts_selected'];
    refundType = json['refund_type'];
    toStationId = json['toStationId'];
    failureCode = json['failure_code'];
    ticketTypeId = json['ticketTypeId'];
    fromStationId = json['fromStationId'];
    refundAmount = json['refund_amount'].toString();
    refundStatus = json['refund_status'];
    failureReason = json['failure_reason'];
    travelDateTime = json['travelDateTime'];
    updateDateTime = json['updateDateTime'] ?? json['update_datetime'];
    merchantOrderId = json['merchantOrderId'];
    purchaseDatetime = json['purchase_datetime'];
    statusDescription = json['status_description'];
    merchantTotalFareAfterGst = json['merchantTotalFareAfterGst'].toString();
    qrPgOrderId = json['qrPgOrderId'];
    qrPgRefundId = json['qrPgRefundId'];
    paymentMethod = json['paymentMethod'];
    paymentTxnId = json['paymentTxnId'];
    bankReference = json['bankReference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['order_id'] = orderId;
    data['ticketId'] = ticketId;
    data['refund_id'] = refundId;
    data['created_at'] = createdAt;
    data['noOfTickets'] = noOfTickets;
    data['refund_type'] = refundType;
    data['toStationId'] = toStationId;
    data['failure_code'] = failureCode;
    data['ticketTypeId'] = ticketTypeId;
    data['fromStationId'] = fromStationId;
    data['refund_amount'] = refundAmount;
    data['refund_status'] = refundStatus;
    data['failure_reason'] = failureReason;
    data['travelDateTime'] = travelDateTime;
    data['updateDateTime'] = updateDateTime;
    data['merchantOrderId'] = merchantOrderId;
    data['purchase_datetime'] = purchaseDatetime;
    data['status_description'] = statusDescription;
    data['merchantTotalFareAfterGst'] = merchantTotalFareAfterGst;
    data['qrPgOrderId'] = qrPgOrderId;
    data['qrPgRefundId'] = qrPgRefundId;
    return data;
  }
}

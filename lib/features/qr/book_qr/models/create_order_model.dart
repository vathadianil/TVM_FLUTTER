class CreateOrderModel {
  String? cartDetails;
  String? cfOrderId;
  String? createdAt;
  CustomerDetails? customerDetails;
  String? entity;
  double? orderAmount;
  String? orderCurrency;
  String? orderExpiryTime;
  String? orderId;
  OrderMeta? orderMeta;
  String? orderNote;
  List<String>? orderSplits;
  String? orderStatus;
  String? orderTags;
  String? paymentSessionId;
  String? terminalData;

  CreateOrderModel(
      {this.cartDetails,
      this.cfOrderId,
      this.createdAt,
      this.customerDetails,
      this.entity,
      this.orderAmount,
      this.orderCurrency,
      this.orderExpiryTime,
      this.orderId,
      this.orderMeta,
      this.orderNote,
      this.orderSplits,
      this.orderStatus,
      this.orderTags,
      this.paymentSessionId,
      this.terminalData});

  CreateOrderModel.fromJson(Map<String, dynamic> json) {
    cartDetails = json['cart_details'];
    cfOrderId = json['cf_order_id'];
    createdAt = json['created_at'];
    customerDetails = json['customer_details'] != null
        ? CustomerDetails.fromJson(json['customer_details'])
        : null;
    entity = json['entity'];
    orderAmount = json['order_amount'];
    orderCurrency = json['order_currency'];
    orderExpiryTime = json['order_expiry_time'];
    orderId = json['order_id'];
    orderMeta = json['order_meta'] != null
        ? OrderMeta.fromJson(json['order_meta'])
        : null;
    orderNote = json['order_note'];
    if (json['order_splits'] != null) {
      orderSplits = <String>[];
      json['order_splits'].forEach((v) {
        orderSplits!.add(v);
      });
    }
    orderStatus = json['order_status'];
    orderTags = json['order_tags'];
    paymentSessionId = json['payment_session_id'];
    terminalData = json['terminal_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_details'] = cartDetails;
    data['cf_order_id'] = cfOrderId;
    data['created_at'] = createdAt;
    if (customerDetails != null) {
      data['customer_details'] = customerDetails!.toJson();
    }
    data['entity'] = entity;
    data['order_amount'] = orderAmount;
    data['order_currency'] = orderCurrency;
    data['order_expiry_time'] = orderExpiryTime;
    data['order_id'] = orderId;
    if (orderMeta != null) {
      data['order_meta'] = orderMeta!.toJson();
    }
    data['order_note'] = orderNote;
    if (orderSplits != null) {
      data['order_splits'] = orderSplits!.map((v) => v).toList();
    }
    data['order_status'] = orderStatus;
    data['order_tags'] = orderTags;
    data['payment_session_id'] = paymentSessionId;
    data['terminal_data'] = terminalData;
    return data;
  }
}

class CustomerDetails {
  String? customerId;
  String? customerName;
  String? customerEmail;
  String? customerPhone;
  String? customerUid;

  CustomerDetails(
      {this.customerId,
      this.customerName,
      this.customerEmail,
      this.customerPhone,
      this.customerUid});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    customerPhone = json['customer_phone'];
    customerUid = json['customer_uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_id'] = customerId;
    data['customer_name'] = customerName;
    data['customer_email'] = customerEmail;
    data['customer_phone'] = customerPhone;
    data['customer_uid'] = customerUid;
    return data;
  }
}

class OrderMeta {
  String? returnUrl;
  String? notifyUrl;
  String? paymentMethods;

  OrderMeta({this.returnUrl, this.notifyUrl, this.paymentMethods});

  OrderMeta.fromJson(Map<String, dynamic> json) {
    returnUrl = json['return_url'];
    notifyUrl = json['notify_url'];
    paymentMethods = json['payment_methods'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['return_url'] = returnUrl;
    data['notify_url'] = notifyUrl;
    data['payment_methods'] = paymentMethods;
    return data;
  }
}

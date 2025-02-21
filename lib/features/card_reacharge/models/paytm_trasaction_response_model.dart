class PaytmTransactionResponseModel {
  String? currency;
  String? gatewayName;
  String? responseMessage;
  String? bankName;
  String? paymentMode;
  String? mid;
  String? responseCode;
  String? retryAllowed;
  String? txnAmount;
  String? txnId;
  String? orderId;
  String? status;
  String? bankTxnId;
  String? txnDate;
  String? checksumHash;

  PaytmTransactionResponseModel({
    required this.currency,
    required this.gatewayName,
    required this.responseMessage,
    required this.bankName,
    required this.paymentMode,
    required this.mid,
    required this.responseCode,
    required this.retryAllowed,
    required this.txnAmount,
    required this.txnId,
    required this.orderId,
    required this.status,
    required this.bankTxnId,
    required this.txnDate,
    required this.checksumHash,
  });

  static PaytmTransactionResponseModel empty() => PaytmTransactionResponseModel(
        currency: '',
        gatewayName: '',
        responseMessage: '',
        bankName: '',
        paymentMode: '',
        mid: '',
        responseCode: '',
        txnAmount: '',
        txnId: '',
        orderId: '',
        status: '',
        bankTxnId: '',
        txnDate: '',
        checksumHash: '',
        retryAllowed: '',
      );

  PaytmTransactionResponseModel.fromJson(Map<String, dynamic> json) {
    currency = json['CURRENCY'];
    gatewayName = json['GATEWAYNAME'];
    responseMessage = json['RESPMSG'];
    bankName = json['BANKNAME'];
    paymentMode = json['PAYMENTMODE'];
    mid = json['MID'];
    responseCode = json['RESPCODE'];
    txnAmount = json['TXNAMOUNT'];
    txnId = json['TXNID'];
    orderId = json['ORDERID'];
    status = json['STATUS'];
    bankTxnId = json['BANKTXNID'];
    txnDate = json['TXNDATE'];
    checksumHash = json['CHECKSUMHASH'];
    retryAllowed = json['retryAllowed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CURRENCY'] = currency;
    data['GATEWAYNAME'] = gatewayName;
    data['RESPMSG'] = responseMessage;
    data['BANKNAME'] = bankName;
    data['PAYMENTMODE'] = paymentMode;
    data['MID'] = mid;
    data['RESPCODE'] = responseCode;
    data['TXNAMOUNT'] = txnAmount;
    data['TXNID'] = txnId;
    data['ORDERID'] = orderId;
    data['STATUS'] = status;
    data['BANKTXNID'] = bankTxnId;
    data['TXNDATE'] = txnDate;
    data['CHECKSUMHASH'] = checksumHash;
    return data;
  }
}

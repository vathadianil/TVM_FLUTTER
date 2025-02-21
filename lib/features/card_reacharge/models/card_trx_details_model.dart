class CardTrxDetailsModel {
  String? errorCode;
  String? errorDescription;
  List<CardTrxListModel>? response;

  CardTrxDetailsModel({this.response});

  CardTrxDetailsModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['ErrorCode'] ?? '';
    errorDescription = json['ErrorDescription'] ?? '';
    if (json['response'] != null) {
      response = <CardTrxListModel>[];
      json['response'].forEach((v) {
        response!.add(CardTrxListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ErrorCode'] = errorCode;
    data['ErrorDescription'] = errorDescription;
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CardTrxListModel {
  String? ticketEngravedID;
  String? merchantTransactionID;
  String? addedValue;
  String? transactionStatus;
  String? bankCode;
  String? transactionDateTime;
  String? tckPhyExprDt;
  String? pgOrderId;
  String? pgTxnId;
  String? paymentMethod;
  String? pgBankRefNum;

  CardTrxListModel({
    this.ticketEngravedID,
    this.merchantTransactionID,
    this.addedValue,
    this.transactionStatus,
    this.bankCode,
    this.transactionDateTime,
    this.tckPhyExprDt,
    this.pgOrderId,
    this.pgTxnId,
    this.paymentMethod,
    this.pgBankRefNum,
  });

  CardTrxListModel.fromJson(Map<String, dynamic> json) {
    ticketEngravedID = json['TicketEngravedID'];
    merchantTransactionID = json['MerchantTransactionID'];
    addedValue = json['AddValueAmount'];
    transactionStatus = json['TransactionStatus'];
    bankCode = json['BankCode'];
    transactionDateTime = json['BankTransactionDateTime'];
    tckPhyExprDt = json['TckPhyExprDt'];
    pgOrderId = json['metroOrderId'];
    pgTxnId = json['paymentTxnId'];
    paymentMethod = json['paymentMethod'];
    pgBankRefNum = json['bankReference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TicketEngravedID'] = ticketEngravedID;
    data['MerchantTransactionID'] = merchantTransactionID;
    data['AddedValue'] = addedValue;
    data['TransactionStatus'] = transactionStatus;
    data['BankCode'] = bankCode;
    data['TransactionDateTime'] = transactionDateTime;
    data['TckPhyExprDt'] = tckPhyExprDt;
    return data;
  }
}

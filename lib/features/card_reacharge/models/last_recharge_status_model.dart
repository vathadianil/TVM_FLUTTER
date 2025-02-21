class LastRechargeStatusModel {
  String? bankReferenceNumber;
  String? ticketEngravedID;
  String? bankCode;
  String? transactionCode;
  String? merchantTransactionID;
  String? addedValue;
  String? transactionDate;

  LastRechargeStatusModel(
      {this.bankReferenceNumber,
      this.ticketEngravedID,
      this.bankCode,
      this.transactionCode,
      this.merchantTransactionID,
      this.addedValue,
      this.transactionDate});

  LastRechargeStatusModel.fromJson(Map<String, dynamic> json) {
    bankReferenceNumber = json['BankReferenceNumber'];
    ticketEngravedID = json['TicketEngravedID'];
    bankCode = json['BankCode'];
    transactionCode = json['TransactionStatus'];
    merchantTransactionID = json['MerchantTransactionID'];
    addedValue = json['AddValueAmount'];
    transactionDate = json['BankTransactionDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BankReferenceNumber'] = bankReferenceNumber;
    data['TicketEngravedID'] = ticketEngravedID;
    data['BankCode'] = bankCode;
    data['TransactionCode'] = transactionCode;
    data['MerchantTransactionID'] = merchantTransactionID;
    data['AddedValue'] = addedValue;
    data['TransactionDate'] = transactionDate;
    return data;
  }
}

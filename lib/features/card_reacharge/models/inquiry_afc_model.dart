class InquiryAfcModel {
  String? ticketEngravedID;
  String? bankCode;
  String? bankReferenceNumber;
  String? merchantTransactionID;
  String? bankTransactionDateTime;
  String? addValueAmount;
  String? aFCTransactionDateTime;
  String? transactionResponseCode;
  String? transactionResponseMessage;
  String? hash;

  InquiryAfcModel(
      {this.ticketEngravedID,
      this.bankCode,
      this.bankReferenceNumber,
      this.merchantTransactionID,
      this.bankTransactionDateTime,
      this.addValueAmount,
      this.aFCTransactionDateTime,
      this.transactionResponseCode,
      this.transactionResponseMessage,
      this.hash});

  InquiryAfcModel.fromJson(Map<String, dynamic> json) {
    ticketEngravedID = json['TicketEngravedID'];
    bankCode = json['BankCode'];
    bankReferenceNumber = json['BankReferenceNumber'];
    merchantTransactionID = json['MerchantTransactionID'];
    bankTransactionDateTime = json['BankTransactionDateTime'];
    addValueAmount = json['AddValueAmount'];
    aFCTransactionDateTime = json['AFCTransactionDateTime'];
    transactionResponseCode = json['TransactionResponseCode'];
    transactionResponseMessage = json['TransactionResponseMessage'];
    hash = json['Hash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TicketEngravedID'] = ticketEngravedID;
    data['BankCode'] = bankCode;
    data['BankReferenceNumber'] = bankReferenceNumber;
    data['MerchantTransactionID'] = merchantTransactionID;
    data['BankTransactionDateTime'] = bankTransactionDateTime;
    data['AddValueAmount'] = addValueAmount;
    data['AFCTransactionDateTime'] = aFCTransactionDateTime;
    data['TransactionResponseCode'] = transactionResponseCode;
    data['TransactionResponseMessage'] = transactionResponseMessage;
    data['Hash'] = hash;
    return data;
  }
}

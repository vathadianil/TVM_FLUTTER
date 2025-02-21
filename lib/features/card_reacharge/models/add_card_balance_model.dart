class AddCardBalanceModel {
  String? bankReferenceNumber;
  String? merchantTransactionID;

  AddCardBalanceModel({this.bankReferenceNumber, this.merchantTransactionID});

  AddCardBalanceModel.fromJson(Map<String, dynamic> json) {
    bankReferenceNumber = json['BankReferenceNumber'];
    merchantTransactionID = json['MerchantTransactionID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BankReferenceNumber'] = bankReferenceNumber;
    data['MerchantTransactionID'] = merchantTransactionID;
    return data;
  }
}

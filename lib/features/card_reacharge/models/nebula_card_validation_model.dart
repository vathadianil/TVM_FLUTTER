class NebulaCardValidationModel {
  List<CardDetails>? cardDetails;
  String? ticketEngravedID;
  String? bankCode;
  String? bankReferenceNumber;
  String? merchantTransactionID;
  String? aFCUpdateDateTime;
  String? currentBalance;
  String? cardValidity;
  String? maxAddValueAmount;
  String? minAddValueAmount;
  String? nebulaCardValidationStatus;
  String? nebulaCardValidationMessage;
  String? hash;

  NebulaCardValidationModel(
      {this.cardDetails,
      this.ticketEngravedID,
      this.bankCode,
      this.bankReferenceNumber,
      this.merchantTransactionID,
      this.aFCUpdateDateTime,
      this.currentBalance,
      this.cardValidity,
      this.maxAddValueAmount,
      this.minAddValueAmount,
      this.nebulaCardValidationStatus,
      this.nebulaCardValidationMessage,
      this.hash});

  NebulaCardValidationModel.fromJson(Map<String, dynamic> json) {
    if (json['CardDetails'] != null) {
      cardDetails = <CardDetails>[];
      json['CardDetails'].forEach((v) {
        cardDetails!.add(CardDetails.fromJson(v));
      });
    }
    ticketEngravedID = json['TicketEngravedID'];
    bankCode = json['BankCode'];
    bankReferenceNumber = json['BankReferenceNumber'];
    merchantTransactionID = json['MerchantTransactionID'];
    aFCUpdateDateTime = json['AFCUpdateDateTime'];
    currentBalance = json['CurrentBalance'];
    cardValidity = json['CardValidity'];
    maxAddValueAmount = json['MaxAddValueAmount'];
    minAddValueAmount = json['MinAddValueAmount'];
    nebulaCardValidationStatus = json['NebulaCardValidationStatus'];
    nebulaCardValidationMessage = json['NebulaCardValidationMessage'];
    hash = json['Hash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cardDetails != null) {
      data['CardDetails'] = cardDetails!.map((v) => v.toJson()).toList();
    }
    data['TicketEngravedID'] = ticketEngravedID;
    data['BankCode'] = bankCode;
    data['BankReferenceNumber'] = bankReferenceNumber;
    data['MerchantTransactionID'] = merchantTransactionID;
    data['AFCUpdateDateTime'] = aFCUpdateDateTime;
    data['CurrentBalance'] = currentBalance;
    data['CardValidity'] = cardValidity;
    data['MaxAddValueAmount'] = maxAddValueAmount;
    data['MinAddValueAmount'] = minAddValueAmount;
    data['NebulaCardValidationStatus'] = nebulaCardValidationStatus;
    data['NebulaCardValidationMessage'] = nebulaCardValidationMessage;
    data['Hash'] = hash;
    return data;
  }
}

class CardDetails {
  String? cardType;
  String? cardCode;
  List<String>? amounts;

  CardDetails({this.cardType, this.cardCode, this.amounts});

  CardDetails.fromJson(Map<String, dynamic> json) {
    cardType = json['CardType'];
    cardCode = json['CardCode'];
    amounts = json['Amounts'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CardType'] = cardType;
    data['CardCode'] = cardCode;
    data['Amounts'] = amounts;
    return data;
  }
}

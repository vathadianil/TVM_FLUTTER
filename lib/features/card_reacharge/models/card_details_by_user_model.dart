class CardDetailsByUserModel {
  String? returnCode;
  String? returnMessage;
  List<CardDetails>? cardDetails;

  CardDetailsByUserModel(
      {this.returnCode, this.returnMessage, this.cardDetails});

  CardDetailsByUserModel.fromJson(Map<String, dynamic> json) {
    returnCode = json['returnCode'].toString();
    returnMessage = json['returnMessage'];
    if (json['cardDetails'] != null) {
      cardDetails = <CardDetails>[];
      json['cardDetails'].forEach((v) {
        cardDetails!.add(CardDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['returnCode'] = returnCode;
    data['returnMessage'] = returnMessage;
    if (cardDetails != null) {
      data['cardDetails'] = cardDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CardDetails {
  int? id;
  int? uid;
  String? cardNo;
  String? cardDesc;

  CardDetails({this.id, this.uid, this.cardNo, this.cardDesc});

  CardDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    cardNo = json['card_no'];
    cardDesc = json['card_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['card_no'] = cardNo;
    data['card_desc'] = cardDesc;
    return data;
  }
}

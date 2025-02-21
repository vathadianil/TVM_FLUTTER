class RefundPreviewModel {
  List<Response>? response;

  RefundPreviewModel({this.response});

  RefundPreviewModel.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(Response.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Response {
  String? refundQuoteId;
  String? ltmrhlPurchaseId;
  String? passId;
  String? rjtId;
  String? ticketid;
  String? noOfRemainingTrips;
  String? storedValueBalance;
  int? actualFarePaid;
  int? surCharge;
  int? gst;
  int? refundAmount;
  String? returnCode;
  String? returnMsg;
  double? singleTicketValue;

  Response(
      {this.refundQuoteId,
      this.ltmrhlPurchaseId,
      this.passId,
      this.rjtId,
      this.ticketid,
      this.noOfRemainingTrips,
      this.storedValueBalance,
      this.actualFarePaid,
      this.surCharge,
      this.gst,
      this.refundAmount,
      this.returnCode,
      this.returnMsg,
      this.singleTicketValue});

  Response.fromJson(Map<String, dynamic> json) {
    refundQuoteId = json['refundQuoteId'];
    ltmrhlPurchaseId = json['ltmrhlPurchaseId'];
    passId = json['passId'];
    rjtId = json['rjtId'];
    ticketid = json['ticketid'];
    noOfRemainingTrips = json['noOfRemainingTrips'];
    storedValueBalance = json['StoredValueBalance'];
    actualFarePaid = json['actualFarePaid'];
    surCharge = json['surCharge'];
    gst = json['Gst'];
    refundAmount = json['refundAmount'];
    returnCode = json['returnCode'];
    returnMsg = json['returnMsg'];
    singleTicketValue = json['singleTicketValue'] + 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refundQuoteId'] = refundQuoteId;
    data['ltmrhlPurchaseId'] = ltmrhlPurchaseId;
    data['passId'] = passId;
    data['rjtId'] = rjtId;
    data['ticketid'] = ticketid;
    data['noOfRemainingTrips'] = noOfRemainingTrips;
    data['StoredValueBalance'] = storedValueBalance;
    data['actualFarePaid'] = actualFarePaid;
    data['surCharge'] = surCharge;
    data['Gst'] = gst;
    data['refundAmount'] = refundAmount;
    data['returnCode'] = returnCode;
    data['returnMsg'] = returnMsg;
    return data;
  }
}

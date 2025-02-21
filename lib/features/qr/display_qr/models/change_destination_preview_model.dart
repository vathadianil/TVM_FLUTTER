class ChangeDestinationPreviewModel {
  String? ticketId;
  double? differenceOfFare;
  int? surCharge;
  int? gst;
  double? totalFareAdjusted;
  String? codQuoteId;
  String? returnCode;
  String? returnMsg;

  ChangeDestinationPreviewModel({
    this.ticketId,
    this.differenceOfFare,
    this.surCharge,
    this.gst,
    this.totalFareAdjusted,
    this.codQuoteId,
    this.returnCode,
    this.returnMsg,
  });

  ChangeDestinationPreviewModel.fromJson(Map<String, dynamic> json) {
    ticketId = json['TicketId'];
    differenceOfFare =
        (json['DifferenceOfFare'] ?? 0) + 0.0; //converting  int to double
    surCharge = json['surCharge'];
    gst = json['gst'];
    totalFareAdjusted =
        (json['totalFareAdjusted'] ?? 0) + 0.0; //converting int to double
    codQuoteId = json['codQuoteId'];
    returnCode = json['returnCode'];
    returnMsg = json['returnMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TicketId'] = ticketId;
    data['DifferenceOfFare'] = differenceOfFare;
    data['surCharge'] = surCharge;
    data['gst'] = gst;
    data['totalFareAdjusted'] = totalFareAdjusted;
    data['codQuoteId'] = codQuoteId;
    data['returnCode'] = returnCode;
    data['returnMsg'] = returnMsg;
    return data;
  }
}

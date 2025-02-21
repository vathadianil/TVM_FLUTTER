class ChangeDestinationConfirmModel {
  String? newticketId;
  String? ticketContent;
  String? ticketEntryExittype;
  String? oldTicketId;
  String? oldTicketStatusId;
  double? differenceOfFare;
  int? surCharge;
  int? gst;
  double? totalFareAdjusted;
  String? carbonEmissionMsg;
  String? returnCode;
  String? returnMsg;

  ChangeDestinationConfirmModel(
      {this.newticketId,
      this.ticketContent,
      this.ticketEntryExittype,
      this.oldTicketId,
      this.oldTicketStatusId,
      this.differenceOfFare,
      this.surCharge,
      this.gst,
      this.totalFareAdjusted,
      this.carbonEmissionMsg,
      this.returnCode,
      this.returnMsg});

  ChangeDestinationConfirmModel.fromJson(Map<String, dynamic> json) {
    newticketId = json['newticketId'];
    ticketContent = json['ticketContent'];
    ticketEntryExittype = json['ticketEntryExittype'];
    oldTicketId = json['OldTicketId'];
    oldTicketStatusId = json['oldTicketStatusId'];
    differenceOfFare = (json['DifferenceOfFare'] ?? 0) + 0.0;
    surCharge = json['surCharge'];
    gst = json['gst'];
    totalFareAdjusted = (json['totalFareAdjusted'] ?? 0) + 0.0;
    carbonEmissionMsg = json['carbonEmissionMsg'];
    returnCode = json['returnCode'];
    returnMsg = json['returnMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['newticketId'] = this.newticketId;
    data['ticketContent'] = this.ticketContent;
    data['ticketEntryExittype'] = this.ticketEntryExittype;
    data['OldTicketId'] = this.oldTicketId;
    data['oldTicketStatusId'] = this.oldTicketStatusId;
    data['DifferenceOfFare'] = this.differenceOfFare;
    data['surCharge'] = this.surCharge;
    data['gst'] = this.gst;
    data['totalFareAdjusted'] = this.totalFareAdjusted;
    data['carbonEmissionMsg'] = this.carbonEmissionMsg;
    data['returnCode'] = this.returnCode;
    data['returnMsg'] = this.returnMsg;
    return data;
  }
}

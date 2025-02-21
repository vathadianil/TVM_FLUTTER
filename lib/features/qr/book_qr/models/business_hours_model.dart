class BusinessHoursModel {
  String? businessDate;
  String? ticketSellingStartime;
  String? ticketSellingEndtime;
  String? returnCode;
  String? returnMsg;

  BusinessHoursModel(
      {this.businessDate,
      this.ticketSellingStartime,
      this.ticketSellingEndtime,
      this.returnCode,
      this.returnMsg});

  BusinessHoursModel.fromJson(Map<String, dynamic> json) {
    businessDate = json['businessDate'];
    ticketSellingStartime = json['ticketSellingStartime'];
    ticketSellingEndtime = json['ticketSellingEndtime'];
    returnCode = json['returnCode'];
    returnMsg = json['returnMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['businessDate'] = businessDate;
    data['ticketSellingStartime'] = ticketSellingStartime;
    data['ticketSellingEndtime'] = ticketSellingEndtime;
    data['returnCode'] = returnCode;
    data['returnMsg'] = returnMsg;
    return data;
  }
}

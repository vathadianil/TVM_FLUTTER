class CardTravelHistoryModel {
  String? errorCode;
  String? errorDescription;
  List<CardTravelHistoryList>? response;

  CardTravelHistoryModel(
      {this.response, this.errorCode, this.errorDescription});

  CardTravelHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      errorCode = json['ErrorCode'] ?? '';
      errorDescription = json['ErrorDescription'] ?? '';
      response = <CardTravelHistoryList>[];
      json['response'].forEach((v) {
        response!.add(CardTravelHistoryList.fromJson(v));
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

class CardTravelHistoryList {
  String? fromStation;
  String? toStation;
  String? travelDateTime;
  String? dDCTAmount;
  String? reminingBalance;

  CardTravelHistoryList(
      {this.fromStation,
      this.toStation,
      this.travelDateTime,
      this.dDCTAmount,
      this.reminingBalance});

  CardTravelHistoryList.fromJson(Map<String, dynamic> json) {
    fromStation = json['FromStation'];
    toStation = json['ToStation'];
    travelDateTime = json['TravelDateTime'];
    dDCTAmount = json['DDCTAmount'];
    reminingBalance = json['ReminingBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FromStation'] = fromStation;
    data['ToStation'] = toStation;
    data['TravelDateTime'] = travelDateTime;
    data['DDCTAmount'] = dDCTAmount;
    data['ReminingBalance'] = reminingBalance;
    return data;
  }
}

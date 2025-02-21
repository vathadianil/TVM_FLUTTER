class StationDataModel {
  String? returnCode;
  String? returnMsg;
  String? version;
  List<StationListModel>? stations;

  StationDataModel(
      {this.returnCode, this.returnMsg, this.version, this.stations});

  StationDataModel.fromJson(Map<String, dynamic> json) {
    returnCode = json['returnCode'];
    returnMsg = json['returnMsg'];
    version = json['version'];
    if (json['stations'] != null) {
      stations = <StationListModel>[];
      json['stations'].forEach((v) {
        stations!.add(StationListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['returnCode'] = returnCode;
    data['returnMsg'] = returnMsg;
    data['version'] = version;
    if (stations != null) {
      data['stations'] = stations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StationListModel {
  String? stationId;
  String? name;
  String? shortName;
  int? corridorId;
  String? corridorName;
  String? corridorColor;

  StationListModel({
    this.stationId,
    this.name,
    this.shortName,
    this.corridorId,
    this.corridorName,
    corridorColor,
  });

  StationListModel.fromJson(Map<String, dynamic> json) {
    stationId = json['stationId'];
    name = json['name'];
    shortName = json['shortName'];
    corridorId = json['corridorId'];
    corridorName = json['corridorName'];
    corridorColor = json['corridorColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stationId'] = stationId;
    data['name'] = name;
    data['shortName'] = shortName;
    data['corridorId'] = corridorId;
    data['corridorName'] = corridorName;
    data['corridorColor'] = corridorColor;
    return data;
  }
}

class FareCalculationModel {
  String? returnCode;
  RouteDetails? routeDetails;
  String? returnMessage;

  FareCalculationModel(
      {this.returnCode, this.routeDetails, this.returnMessage});

  FareCalculationModel.fromJson(Map<String, dynamic> json) {
    returnCode = json['returnCode'];
    routeDetails = json['routeDetails'] != null
        ? RouteDetails.fromJson(json['routeDetails'])
        : null;
    returnMessage = json['returnMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['returnCode'] = returnCode;
    if (routeDetails != null) {
      data['routeDetails'] = routeDetails!.toJson();
    }
    data['returnMessage'] = returnMessage;
    return data;
  }
}

class RouteDetails {
  String? fare;
  String? time;
  String? distance;
  String? toStationName;
  String? fromStationName;

  RouteDetails(
      {this.fare,
      this.time,
      this.distance,
      this.toStationName,
      this.fromStationName});

  RouteDetails.fromJson(Map<String, dynamic> json) {
    fare = json['fare'].toString();
    time = json['time'].toString();
    distance = json['distance'].toStringAsFixed(1);
    toStationName = json['toStationName'];
    fromStationName = json['fromStationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fare'] = fare;
    data['time'] = time;
    data['distance'] = distance;
    data['toStationName'] = toStationName;
    data['fromStationName'] = fromStationName;
    return data;
  }
}

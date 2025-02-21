class MetroStationFacilitiesServicesModel {
  final String? e;
  final FacilitiesData  r;
  final String? s;
  final String? em;

  MetroStationFacilitiesServicesModel({
    this.e,
    required this.r,
    this.s,
    this.em,
  });

  factory MetroStationFacilitiesServicesModel.fromJson(Map<String, dynamic> json) => MetroStationFacilitiesServicesModel(
        e: json['e'] as String?,
        r: FacilitiesData .fromJson(json['r'] as Map<String, dynamic>? ?? {}),
        s: json['s'] as String?,
        em: json['em'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'e': e,
        'r': r.toJson(),
        's': s,
        'em': em,
      };
}

class FacilitiesData  {
  final List<Facility> facilities;

  FacilitiesData ({
    required this.facilities,
  });

  factory FacilitiesData.fromJson(Map<String, dynamic> json) => FacilitiesData (
        facilities: (json['facilities'] as List<dynamic>?)
                ?.map((e) => Facility.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        'facilities': facilities.map((e) => e.toJson()).toList(),
      };
}

class Facility {
  final int? id;
  final List<Facility>? busStop;
  final int? isActive;
  final List<Facility>? catchment;
  final int? stationId;
  final String? stationName;
  final String? facilityCode;
  final String? facilityName;
  final List<Facility>? neighbourhood;
  final String? facilityContent;
  final String? isGateAvailable;
  final String? facilityIconPath;
  final int? facilityPriority;
  final String? facilityContentUrl;

  Facility({
    this.id,
    this.busStop,
    this.isActive,
    this.catchment,
    this.stationId,
    this.stationName,
    this.facilityCode,
    this.facilityName,
    this.neighbourhood,
    this.facilityContent,
    this.isGateAvailable,
    this.facilityIconPath,
    this.facilityPriority,
    this.facilityContentUrl,
  });

  factory Facility.fromJson(Map<String, dynamic> json) => Facility(
        id: json['Id'] as int?,
        stationId: json['stationId'] as int?,
        stationName: json['stationName'] as String?,
        facilityCode: json['facilityCode'] as String?,
        facilityName: json['facilityName'] as String?,
        isActive: json['isActive'] ?? 0,
        facilityContent: json['facilityContent'] as String?,
        isGateAvailable: json['isGateAvailable'] as String?,
        facilityIconPath: json['facilityIconPath'] as String?,
        facilityPriority: json['facilityPriority'] as int?,
        facilityContentUrl: json['facilityContentUrl'] as String?,
        neighbourhood: json["NEIGHBOURHOOD"] == null ? [] : List<Facility>.from(json["NEIGHBOURHOOD"]!.map((x) => Facility.fromJson(x))),
        busStop: json["BUSSTOP"] == null ? [] : List<Facility>.from(json["BUSSTOP"]!.map((x) => Facility.fromJson(x))),
        catchment: json["CATCHMENT"] == null ? [] : List<Facility>.from(json["CATCHMENT"]!.map((x) => Facility.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
        'BUSSTOP': busStop?.map((e) => e.toJson()).toList(),
        'isActive': isActive,
        'CATCHMENT': catchment?.map((e) => e.toJson()).toList(),
        'stationId': stationId,
        'stationName': stationName,
        'facilityCode': facilityCode,
        'facilityName': facilityName,
        'NEIGHBOURHOOD': neighbourhood?.map((e) => e.toJson()).toList(),
        'facilityContent': facilityContent,
        'isGateAvailable': isGateAvailable,
        'facilityIconPath': facilityIconPath,
        'facilityPriority': facilityPriority,
        'facilityContentUrl': facilityContentUrl,
      };
}

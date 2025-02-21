class StationsWithCoordsModel {
  String? e;
  String? s;
  String? em;
  List<Stnlist>? stnlist;

  StationsWithCoordsModel({this.e, this.s, this.em, this.stnlist});

  StationsWithCoordsModel.fromJson(Map<String, dynamic> json) {
    e = json['e'];
    s = json['s'];
    em = json['em'];
    if (json['stnlist'] != null) {
      stnlist = <Stnlist>[];
      json['stnlist'].forEach((v) {
        stnlist!.add(new Stnlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['e'] = this.e;
    data['s'] = this.s;
    data['em'] = this.em;
    if (this.stnlist != null) {
      data['stnlist'] = this.stnlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stnlist {
  Fc? fc;
  String? jn;
  int? tt;
  String? type;
  String? cmnJN;
  String? rtclr;
  int? stage;
  int? stnId;
  Null mMTSR;
  int? rccode;
  String? status;
  String? stcode;
  String? station;
  String? amscode;
  double? latitude;
  String? afcnumber;
  String? atsnumber;
  double? longitude;
  String? stationid;
  String? description;

  Stnlist(
      {this.fc,
      this.jn,
      this.tt,
      this.type,
      this.cmnJN,
      this.rtclr,
      this.stage,
      this.stnId,
      this.mMTSR,
      this.rccode,
      this.status,
      this.stcode,
      this.station,
      this.amscode,
      this.latitude,
      this.afcnumber,
      this.atsnumber,
      this.longitude,
      this.stationid,
      this.description});

  Stnlist.fromJson(Map<String, dynamic> json) {
    fc = json['fc'] != null ? new Fc.fromJson(json['fc']) : null;
    jn = json['jn'];
    tt = json['tt'];
    type = json['type'];
    cmnJN = json['cmnJN'];
    rtclr = json['rtclr'];
    stage = json['stage'];
    stnId = json['stnId'];
    mMTSR = json['MMTS_R'];
    rccode = json['rccode'];
    status = json['status'];
    stcode = json['stcode'];
    station = json['Station'];
    amscode = json['amscode'];
    latitude = json['latitude'];
    afcnumber = json['afcnumber'];
    atsnumber = json['atsnumber'];
    longitude = json['longitude'];
    stationid = json['stationid'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fc != null) {
      data['fc'] = this.fc!.toJson();
    }
    data['jn'] = this.jn;
    data['tt'] = this.tt;
    data['type'] = this.type;
    data['cmnJN'] = this.cmnJN;
    data['rtclr'] = this.rtclr;
    data['stage'] = this.stage;
    data['stnId'] = this.stnId;
    data['MMTS_R'] = this.mMTSR;
    data['rccode'] = this.rccode;
    data['status'] = this.status;
    data['stcode'] = this.stcode;
    data['Station'] = this.station;
    data['amscode'] = this.amscode;
    data['latitude'] = this.latitude;
    data['afcnumber'] = this.afcnumber;
    data['atsnumber'] = this.atsnumber;
    data['longitude'] = this.longitude;
    data['stationid'] = this.stationid;
    data['description'] = this.description;
    return data;
  }
}

class Fc {
  String? p;
  String? bs;
  String? rt;
  String? mmts;

  Fc({this.p, this.bs, this.rt, this.mmts});

  Fc.fromJson(Map<String, dynamic> json) {
    p = json['p'];
    bs = json['bs'];
    rt = json['rt'];
    mmts = json['mmts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['p'] = this.p;
    data['bs'] = this.bs;
    data['rt'] = this.rt;
    data['mmts'] = this.mmts;
    return data;
  }
}

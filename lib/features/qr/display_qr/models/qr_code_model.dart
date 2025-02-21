class QrTicketModel {
  String? returnCode;
  String? returnMsg;
  String? ltmrhlPurchaseId;
  List<TicketsListModel>? tickets;
  String? orderId;
  LoyaltyPoints? loyaltyPoints;

  QrTicketModel(
      {this.returnCode,
      this.returnMsg,
      this.ltmrhlPurchaseId,
      this.tickets,
      this.orderId,
      this.loyaltyPoints});

  QrTicketModel.fromJson(Map<String, dynamic> json) {
    returnCode = json['returnCode'];
    returnMsg = json['returnMsg'];
    ltmrhlPurchaseId = json['ltmrhlPurchaseId'];
    if (json['tickets'] != null) {
      tickets = <TicketsListModel>[];
      json['tickets'].forEach((v) {
        tickets!.add(TicketsListModel.fromJson(v));
      });
    }
    orderId = json['orderId'];
    loyaltyPoints = json['loyalty_points'] != null
        ? new LoyaltyPoints.fromJson(json['loyalty_points'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['returnCode'] = returnCode;
    data['returnMsg'] = returnMsg;
    data['ltmrhlPurchaseId'] = ltmrhlPurchaseId;
    if (tickets != null) {
      data['tickets'] = tickets!.map((v) => v.toJson()).toList();
    }
    data['orderId'] = orderId;
    if (loyaltyPoints != null) {
      data['loyalty_points'] = loyaltyPoints!.toJson();
    }
    return data;
  }
}

class ActiveTicketModel {
  List<TicketHistory>? ticketHistory;

  ActiveTicketModel({ticketHistory});

  ActiveTicketModel.fromJson(Map<String, dynamic> json) {
    if (json['ticketHistory'] != null) {
      ticketHistory = <TicketHistory>[];
      json['ticketHistory'].forEach((v) {
        ticketHistory!.add(TicketHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ticketHistory != null) {
      data['ticketHistory'] = ticketHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketHistory {
  String? purchaseDate;
  String? purchaseTime;
  String? fromStation;
  String? toStation;
  int? noOfPersons;
  String? totalFareAmount;
  List<TicketsListModel>? tickets;

  TicketHistory(
      {purchaseDate,
      purchaseTime,
      fromStation,
      toStation,
      noOfPersons,
      totalFareAmount,
      tickets});

  TicketHistory.fromJson(Map<String, dynamic> json) {
    purchaseDate = json['purchaseDate'];
    purchaseTime = json['purchaseTime'];
    fromStation = json['fromStation'];
    toStation = json['toStation'];
    noOfPersons = json['noOfPersons'];
    totalFareAmount = json['totalFareAmount'].toString();
    if (json['tickets'] != null) {
      tickets = <TicketsListModel>[];
      json['tickets'].forEach((v) {
        tickets!.add(TicketsListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['purchaseDate'] = purchaseDate;
    data['purchaseTime'] = purchaseTime;
    data['fromStation'] = fromStation;
    data['toStation'] = toStation;
    data['noOfPersons'] = noOfPersons;
    data['totalFareAmount'] = totalFareAmount;
    if (tickets != null) {
      data['tickets'] = tickets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketsListModel {
  String? ticketTypeCode;
  String? ticketId;
  String? rjtID;
  String? orderID;
  int? statusId;
  String? ticketContent;
  String? fromStationId;
  String? toStationId;
  int? ticketTypeId;
  String? ticketStatus;
  String? noOfTripsRemaining;
  String? noOfTripsUsed;
  String? remainingStoredValue;
  String? entryExitType;
  String? platFormNo;
  String? ticketExpiryTime;
  String? carbonEmissionMsg;
  String? rjtId;
  String? fromStation;
  String? toStation;
  String? purchaseDatetime;
  String? cancellationTime;
  String? resonForCanclation;
  String? entryExitCode;
  String? entryDateTime;
  String? exitDateTime;
  String? maxAllowdExitTime;
  String? merchantType;
  String? finalCost;
  String? ticketType;
  String? relateTicketId;
  String? returnCode;
  String? returnMsg;
  String? oldTicketId;
  String? oldTicketStatusId;
  double? differenceOfFare;
  int? surCharge;
  int? gst;
  double? totalFareAdjusted;
  String? pgOrderId;
  Ratings? ratings;
  String? paymentMethod;
  String? paymentTxnId;
  String? bankReference;

  TicketsListModel(
      {ticketTypeCode,
      ticketId,
      rjtID,
      orderID,
      statusId,
      ticketContent,
      fromStationId,
      toStationId,
      ticketTypeId,
      ticketStatus,
      noOfTripsRemaining,
      noOfTripsUsed,
      remainingStoredValue,
      entryExitType,
      platFormNo,
      ticketExpiryTime,
      carbonEmissionMsg,
      rjtId,
      fromStation,
      toStation,
      purchaseDatetime,
      cancellationTime,
      resonForCanclation,
      entryExitCode,
      entryDateTime,
      exitDateTime,
      maxAllowdExitTime,
      merchantType,
      finalCost,
      ticketType,
      relateTicketId,
      returnCode,
      returnMsg,
      oldTicketId,
      oldTicketStatusId,
      pgOrderId,
      paymentMethod,
      paymentTxnId,
      bankReference,
      this.differenceOfFare,
      this.surCharge,
      this.gst,
      this.totalFareAdjusted,
      this.ratings});

  TicketsListModel.fromJson(Map<String, dynamic> json) {
    ticketTypeCode = json['ticketTypeCode'];
    ticketId = json['ticketId'] ?? json['newticketId'];
    rjtID = json['rjtID'];
    orderID = json['orderID'];
    statusId = json['statusId'];
    ticketContent = json['ticketContent'];
    fromStationId = json['fromStationId'];
    toStationId = json['toStationId'];
    ticketTypeId = json['ticketTypeId'];
    ticketStatus = json['ticketStatus'];
    noOfTripsRemaining = json['noOfTripsRemaining'];
    noOfTripsUsed = json['noOfTripsUsed'];
    remainingStoredValue = json['remainingStoredValue'];
    entryExitType = json['entryExitType'] ?? json['ticketEntryExittype'];
    platFormNo = json['platFormNo'];
    ticketExpiryTime = json['ticketExpiryTime'];
    carbonEmissionMsg = json['carbonEmissionMsg'];
    rjtId = json['rjtId'];
    fromStation = json['fromStation'];
    toStation = json['toStation'];
    purchaseDatetime = json['purchaseDatetime'];
    purchaseDatetime = json['purchaseDatetime'];
    cancellationTime = json['cancellationTime'];
    resonForCanclation = json['resonForCanclation'];
    entryExitCode = json['entryExitCode'];
    entryDateTime = json['entryDateTime'];
    exitDateTime = json['exitDateTime'];
    maxAllowdExitTime = json['maxAllowdExitTime'];
    merchantType = json['merchantType'];
    finalCost = json['finalCost'].toString();
    ticketType = json['ticketType'];
    relateTicketId = json['relateTicketId'] ?? json['relate_Ticket_Id'];
    returnCode = json['returnCode'];
    returnMsg = json['returnMsg'];
    oldTicketId = json['OldTicketId'];
    pgOrderId = json['pgOrderId'];
    paymentTxnId = json['paymentTxnId'];
    bankReference = json['bankReference'];
    oldTicketStatusId = json['oldTicketStatusId'];
    differenceOfFare = (json['DifferenceOfFare'] ?? 0) + 0.0;
    surCharge = json['surCharge'];
    gst = json['gst'];
    paymentMethod = json['paymentMethod'];
    totalFareAdjusted = (json['totalFareAdjusted'] ?? 0) + 0.0;
    ratings =
        json['ratings'] != null ? new Ratings.fromJson(json['ratings']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ticketTypeCode'] = ticketTypeCode;
    data['ticketId'] = ticketId;
    data['rjtID'] = rjtID;
    data['orderID'] = orderID;
    data['statusId'] = statusId;
    data['ticketContent'] = ticketContent;
    data['fromStationId'] = fromStationId;
    data['toStationId'] = toStationId;
    data['ticketTypeId'] = ticketTypeId;
    data['ticketStatus'] = ticketStatus;
    data['noOfTripsRemaining'] = noOfTripsRemaining;
    data['noOfTripsUsed'] = noOfTripsUsed;
    data['remainingStoredValue'] = remainingStoredValue;
    data['entryExitType'] = entryExitType;
    data['platFormNo'] = platFormNo;
    data['ticketExpiryTime'] = ticketExpiryTime;
    data['carbonEmissionMsg'] = carbonEmissionMsg;
    data['rjtId'] = rjtId;
    data['fromStation'] = fromStation;
    data['toStation'] = toStation;
    data['purchaseDatetime'] = purchaseDatetime;
    data['purchaseDatetime'] = purchaseDatetime;
    data['cancellationTime'] = cancellationTime;
    data['resonForCanclation'] = resonForCanclation;
    data['entryExitCode'] = entryExitCode;
    data['entryDateTime'] = entryDateTime;
    data['exitDateTime'] = exitDateTime;
    data['maxAllowdExitTime'] = maxAllowdExitTime;
    data['merchantType'] = merchantType;
    data['finalCost'] = finalCost;
    data['ticketType'] = ticketType;
    data['relateTicketId'] = relateTicketId;
    data['returnCode'] = returnCode;
    data['returnMsg'] = returnMsg;
    if (this.ratings != null) {
      data['ratings'] = this.ratings!.toJson();
    }
    return data;
  }
}

class LoyaltyPoints {
  String? message;
  int? earnedPoints;
  int? expiryMonths;

  LoyaltyPoints({this.message, this.earnedPoints, this.expiryMonths});

  LoyaltyPoints.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    earnedPoints = json['earned_points'];
    expiryMonths = json['expiry_months'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['earned_points'] = earnedPoints;
    data['expiry_months'] = expiryMonths;
    return data;
  }
}

class Ratings {
  int? rating;
  String? comment;
  int? isRated;

  Ratings({this.rating, this.comment, this.isRated});

  Ratings.fromJson(Map<String, dynamic> json) {
    rating = json['Rating'];
    comment = json['Comment'];
    isRated = json['is_rated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Rating'] = this.rating;
    data['Comment'] = this.comment;
    data['is_rated'] = this.isRated;
    return data;
  }
}

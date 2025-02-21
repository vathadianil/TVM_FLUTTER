class NotificationsModel {
    Data? data;

    NotificationsModel({
        this.data,
    });

    factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    String? message;
    bool? success;
    List<Notification>? notification;
    List<dynamic>? errors;

    Data({
        this.message,
        this.success,
        this.notification,
        this.errors,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        success: json["success"],
        notification: json["notification"] == null ? [] : List<Notification>.from(json["notification"]!.map((x) => Notification.fromJson(x))),
        errors: json["errors"] == null ? [] : List<dynamic>.from(json["errors"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "notification": notification == null ? [] : List<dynamic>.from(notification!.map((x) => x.toJson())),
        "errors": errors == null ? [] : List<dynamic>.from(errors!.map((x) => x)),
    };
}

class Notification {
    int? id;
    int? userid;
    DateTime? createdDate;
    String? notificationTitle;
    String? description;
    bool isRead;

    Notification({
        this.id,
        this.userid,
        this.createdDate,
        this.notificationTitle,
        this.description,
        this.isRead = false, // Initialize as false (unread)
    });

    factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        userid: json["userid"],
        createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
        notificationTitle: json["notification_title"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userid": userid,
        "created_date": createdDate?.toIso8601String(),
        "notification_title": notificationTitle,
        "description": description,
    };
}

class OtpModel {
    String? message;
    String? status;
    String? token;
    String? tappUserToken;
    String? userverified;
    List<dynamic>? errors;

    OtpModel({
        this.message,
        this.status,
        this.token,
        this.tappUserToken,
        this.userverified,
        this.errors,
    });

    factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        message: json["message"],
        status: json["status"],
        token: json["token"],
        tappUserToken: json['tapp_user_token'],
        userverified: json["userverified"],
        errors: json["errors"] == null ? [] : List<dynamic>.from(json["errors"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "token": token,
        'tapp_user_token': tappUserToken,
        "userverified": userverified,
        "errors": errors == null ? [] : List<dynamic>.from(errors!.map((x) => x)),
    };
}

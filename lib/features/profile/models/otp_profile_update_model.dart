class OtpProfileUpdateModel {
    String? message;
    String? status;
    String? oTP;
    List<dynamic>? errors;

    OtpProfileUpdateModel({
        this.message,
        this.status,
        this.oTP,
        this.errors,
    });

    factory OtpProfileUpdateModel.fromJson(Map<String, dynamic> json) => OtpProfileUpdateModel(
        message: json["message"],
        status: json["status"],
        oTP: json['OTP'],
        errors: json["errors"] == null ? [] : List<dynamic>.from(json["errors"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        'OTP': oTP,
        "errors": errors == null ? [] : List<dynamic>.from(errors!.map((x) => x)),
    };
}

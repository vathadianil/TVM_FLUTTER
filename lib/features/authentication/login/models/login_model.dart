class LoginModel {
    String? message;
    String? status;
    Userinfo? userinfo;
    List<dynamic>? errors;

    LoginModel({
        this.message,
        this.status,
        this.userinfo,
        this.errors,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["message"],
        status: json["status"],
        userinfo: json["userinfo"] == null ? null : Userinfo.fromJson(json["userinfo"]),
        errors: json["errors"] == null ? [] : List<dynamic>.from(json["errors"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "userinfo": userinfo?.toJson(),
        "errors": errors == null ? [] : List<dynamic>.from(errors!.map((x) => x)),
    };
}

class Userinfo {
    String? gender;
    dynamic passwordUpdate;
    dynamic updatePassword;
    String? registetedBy;
    dynamic altEmailId;
    dynamic accessToken;
    String? source;
    String? dateOfBirth;
    dynamic deviceType;
    String? lastName;
    dynamic deviceToken;
    String? mobileNo;
    dynamic accTokenExpiryDate;
    dynamic updateRequestOtp;
    String? activeStatus;
    dynamic lastLoginTime;
    String? emailAddress;
    dynamic deviceInfo;
    String? userVerified;
    dynamic modifiedDate;
    dynamic password;
    String? mobileOtp;
    dynamic transactionPin;
    int? uid;
    dynamic userType;
    String? firstName;
    dynamic emailUpdate;
    dynamic updateEmail;
    dynamic mobUpdate;
    String? registrationDate;
    dynamic updateMobileNo;
    String? imei;
    String? occupation;
    String? personWithDisability;

    Userinfo({
        this.gender,
        this.passwordUpdate,
        this.updatePassword,
        this.registetedBy,
        this.altEmailId,
        this.accessToken,
        this.source,
        this.dateOfBirth,
        this.deviceType,
        this.lastName,
        this.deviceToken,
        this.mobileNo,
        this.accTokenExpiryDate,
        this.updateRequestOtp,
        this.activeStatus,
        this.lastLoginTime,
        this.emailAddress,
        this.deviceInfo,
        this.userVerified,
        this.modifiedDate,
        this.password,
        this.mobileOtp,
        this.transactionPin,
        this.uid,
        this.userType,
        this.firstName,
        this.emailUpdate,
        this.updateEmail,
        this.mobUpdate,
        this.registrationDate,
        this.updateMobileNo,
        this.imei,
        this.occupation,
        this.personWithDisability,
    });

    factory Userinfo.fromJson(Map<String, dynamic> json) => Userinfo(
        gender: json["Gender"],
        passwordUpdate: json["Password_Update"],
        updatePassword: json["UpdatePassword"],
        registetedBy: json["RegistetedBy"],
        altEmailId: json["Alt_EmailId"],
        accessToken: json["Access_Token"],
        source: json["Source"],
        dateOfBirth: json["Date_of_birth"],
        deviceType: json["DeviceType"],
        lastName: json["Last_Name"],
        deviceToken: json["Device_Token"],
        mobileNo: json["Mobile_No"],
        accTokenExpiryDate: json["Acc_Token_Expiry_Date"],
        updateRequestOtp: json["Update_Request_OTP"],
        activeStatus: json["ActiveStatus"],
        lastLoginTime: json["Last_Login_Time"],
        emailAddress: json["Email_Address"],
        deviceInfo: json["Device_Info"],
        userVerified: json["User_verified"],
        modifiedDate: json["ModifiedDate"],
        password: json["Password"],
        mobileOtp: json["mobile_otp"],
        transactionPin: json["TransactionPin"],
        uid: json["UID"],
        userType: json["User_Type"],
        firstName: json["First_Name"],
        emailUpdate: json["Email_Update"],
        updateEmail: json["UpdateEmail"],
        mobUpdate: json["Mob_Update"],
        registrationDate: json["RegistrationDate"],
        updateMobileNo: json["UpdateMobileNo"],
        imei: json["IMEI"],
        occupation : json['Occupation'] ?? '',
        personWithDisability : json['Person_with_disability']
    );

    Map<String, dynamic> toJson() => {
        "Gender": gender,
        "Password_Update": passwordUpdate,
        "UpdatePassword": updatePassword,
        "RegistetedBy": registetedBy,
        "Alt_EmailId": altEmailId,
        "Access_Token": accessToken,
        "Source": source,
        "Date_of_birth": dateOfBirth,
        "DeviceType": deviceType,
        "Last_Name": lastName,
        "Device_Token": deviceToken,
        "Mobile_No": mobileNo,
        "Acc_Token_Expiry_Date": accTokenExpiryDate,
        "Update_Request_OTP": updateRequestOtp,
        "ActiveStatus": activeStatus,
        "Last_Login_Time": lastLoginTime,
        "Email_Address": emailAddress,
        "Device_Info": deviceInfo,
        "User_verified": userVerified,
        "ModifiedDate": modifiedDate,
        "Password": password,
        "mobile_otp": mobileOtp,
        "TransactionPin": transactionPin,
        "UID": uid,
        "User_Type": userType,
        "First_Name": firstName,
        "Email_Update": emailUpdate,
        "UpdateEmail": updateEmail,
        "Mob_Update": mobUpdate,
        "RegistrationDate": registrationDate,
        "UpdateMobileNo": updateMobileNo,
        "IMEI": imei,
        'Occupation': occupation,
        'Person_with_disability' : personWithDisability
    };
}

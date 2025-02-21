class UserRegisterModel {
    String? message;
    String? status;
    Userinfo? userinfo;
    List<dynamic>? errors;

    UserRegisterModel({
        this.message,
        this.status,
        this.userinfo,
        this.errors,
    });

    factory UserRegisterModel.fromJson(Map<String, dynamic> json) => UserRegisterModel(
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
    String? registetedBy;
    dynamic updatePassword;
    dynamic passwordUpdate;
    String? dateOfBirth;
    String? source;
    dynamic accessToken;
    dynamic altEmailId;
    String? lastName;
    String? mobileNo;
    dynamic deviceType;
    dynamic accTokenExpiryDate;
    dynamic deviceToken;
    String? emailAddress;
    String? activeStatus;
    dynamic lastLoginTime;
    dynamic updateRequestOtp;
    dynamic password;
    dynamic modifiedDate;
    dynamic deviceInfo;
    String? userVerified;
    String? mobileOtp;
    dynamic transactionPin;
    int? uid;
    String? firstName;
    dynamic userType;
    dynamic updateEmail;
    dynamic emailUpdate;
    String? registrationDate;
    String? imei;
    dynamic updateMobileNo;
    dynamic mobUpdate;
    String? occupation;
    String? personWithDisability;

    Userinfo({
        this.gender,
        this.registetedBy,
        this.updatePassword,
        this.passwordUpdate,
        this.dateOfBirth,
        this.source,
        this.accessToken,
        this.altEmailId,
        this.lastName,
        this.mobileNo,
        this.deviceType,
        this.accTokenExpiryDate,
        this.deviceToken,
        this.emailAddress,
        this.activeStatus,
        this.lastLoginTime,
        this.updateRequestOtp,
        this.password,
        this.modifiedDate,
        this.deviceInfo,
        this.userVerified,
        this.mobileOtp,
        this.transactionPin,
        this.uid,
        this.firstName,
        this.userType,
        this.updateEmail,
        this.emailUpdate,
        this.registrationDate,
        this.imei,
        this.updateMobileNo,
        this.mobUpdate,
        this.occupation,
        this.personWithDisability,
    });

    factory Userinfo.fromJson(Map<String, dynamic> json) => Userinfo(
        gender: json["Gender"],
        registetedBy: json["RegistetedBy"],
        updatePassword: json["UpdatePassword"],
        passwordUpdate: json["Password_Update"],
        dateOfBirth: json["Date_of_birth"],
        source: json["Source"],
        accessToken: json["Access_Token"],
        altEmailId: json["Alt_EmailId"],
        lastName: json["Last_Name"],
        mobileNo: json["Mobile_No"],
        deviceType: json["DeviceType"],
        accTokenExpiryDate: json["Acc_Token_Expiry_Date"],
        deviceToken: json["Device_Token"],
        emailAddress: json["Email_Address"],
        activeStatus: json["ActiveStatus"],
        lastLoginTime: json["Last_Login_Time"],
        updateRequestOtp: json["Update_Request_OTP"],
        password: json["Password"],
        modifiedDate: json["ModifiedDate"],
        deviceInfo: json["Device_Info"],
        userVerified: json["User_verified"],
        mobileOtp: json["mobile_otp"],
        transactionPin: json["TransactionPin"],
        uid: json["UID"],
        firstName: json["First_Name"],
        userType: json["User_Type"],
        updateEmail: json["UpdateEmail"],
        emailUpdate: json["Email_Update"],
        registrationDate: json["RegistrationDate"],
        imei: json["IMEI"],
        updateMobileNo: json["UpdateMobileNo"],
        mobUpdate: json["Mob_Update"],
        occupation : json['Occupation'],
        personWithDisability : json['Person_with_disability']
    );

    Map<String, dynamic> toJson() => {
        "Gender": gender,
        "RegistetedBy": registetedBy,
        "UpdatePassword": updatePassword,
        "Password_Update": passwordUpdate,
        "Date_of_birth": dateOfBirth,
        "Source": source,
        "Access_Token": accessToken,
        "Alt_EmailId": altEmailId,
        "Last_Name": lastName,
        "Mobile_No": mobileNo,
        "DeviceType": deviceType,
        "Acc_Token_Expiry_Date": accTokenExpiryDate,
        "Device_Token": deviceToken,
        "Email_Address": emailAddress,
        "ActiveStatus": activeStatus,
        "Last_Login_Time": lastLoginTime,
        "Update_Request_OTP": updateRequestOtp,
        "Password": password,
        "ModifiedDate": modifiedDate,
        "Device_Info": deviceInfo,
        "User_verified": userVerified,
        "mobile_otp": mobileOtp,
        "TransactionPin": transactionPin,
        "UID": uid,
        "First_Name": firstName,
        "User_Type": userType,
        "UpdateEmail": updateEmail,
        "Email_Update": emailUpdate,
        "RegistrationDate": registrationDate,
        "IMEI": imei,
        "UpdateMobileNo": updateMobileNo,
        "Mob_Update": mobUpdate,
        'Occupation': occupation,
        'Person_with_disability' : personWithDisability
    };
}

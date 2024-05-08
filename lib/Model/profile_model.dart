import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    bool? isError;
    String? message;
    Data? data;

    ProfileModel({
        this.isError,
        this.message,
        this.data,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        isError: json["isError"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "isError": isError,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    dynamic? firstName;
    dynamic? lastName;
    dynamic phone;
    dynamic? address;
    dynamic profilePic;
    dynamic profile;
    bool? isActive;
    bool? isblock;
    dynamic clients;
    dynamic workerManagers;
    dynamic? id;
    dynamic? userName;
    dynamic? normalizedUserName;
    dynamic? email;
    dynamic? normalizedEmail;
    bool? emailConfirmed;
    dynamic? passwordHash;
    dynamic? securityStamp;
    dynamic? concurrencyStamp;
    dynamic? phoneNumber;
    bool? phoneNumberConfirmed;
    bool? twoFactorEnabled;
    dynamic lockoutEnd;
    bool? lockoutEnabled;
    int? accessFailedCount;

    Data({
        this.firstName,
        this.lastName,
        this.phone,
        this.address,
        this.profilePic,
        this.profile,
        this.isActive,
        this.isblock,
        this.clients,
        this.workerManagers,
        this.id,
        this.userName,
        this.normalizedUserName,
        this.email,
        this.normalizedEmail,
        this.emailConfirmed,
        this.passwordHash,
        this.securityStamp,
        this.concurrencyStamp,
        this.phoneNumber,
        this.phoneNumberConfirmed,
        this.twoFactorEnabled,
        this.lockoutEnd,
        this.lockoutEnabled,
        this.accessFailedCount,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        address: json["address"],
        profilePic: json["profilePic"],
        profile: json["profile"],
        isActive: json["isActive"],
        isblock: json["isblock"],
        clients: json["clients"],
        workerManagers: json["workerManagers"],
        id: json["id"],
        userName: json["userName"],
        normalizedUserName: json["normalizedUserName"],
        email: json["email"],
        normalizedEmail: json["normalizedEmail"],
        emailConfirmed: json["emailConfirmed"],
        passwordHash: json["passwordHash"],
        securityStamp: json["securityStamp"],
        concurrencyStamp: json["concurrencyStamp"],
        phoneNumber: json["phoneNumber"],
        phoneNumberConfirmed: json["phoneNumberConfirmed"],
        twoFactorEnabled: json["twoFactorEnabled"],
        lockoutEnd: json["lockoutEnd"],
        lockoutEnabled: json["lockoutEnabled"],
        accessFailedCount: json["accessFailedCount"],
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "address": address,
        "profilePic": profilePic,
        "profile": profile,
        "isActive": isActive,
        "isblock": isblock,
        "clients": clients,
        "workerManagers": workerManagers,
        "id": id,
        "userName": userName,
        "normalizedUserName": normalizedUserName,
        "email": email,
        "normalizedEmail": normalizedEmail,
        "emailConfirmed": emailConfirmed,
        "passwordHash": passwordHash,
        "securityStamp": securityStamp,
        "concurrencyStamp": concurrencyStamp,
        "phoneNumber": phoneNumber,
        "phoneNumberConfirmed": phoneNumberConfirmed,
        "twoFactorEnabled": twoFactorEnabled,
        "lockoutEnd": lockoutEnd,
        "lockoutEnabled": lockoutEnabled,
        "accessFailedCount": accessFailedCount,
    };
}

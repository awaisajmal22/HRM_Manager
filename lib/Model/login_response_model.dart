import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    String? token;
    DateTime? expiration;
    String? id;
    String? email;
    String? username;
    String? phonenumber;
    List<String>? userRoles;

    LoginResponseModel({
        this.token,
        this.expiration,
        this.id,
        this.email,
        this.username,
        this.phonenumber,
        this.userRoles,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        token: json["token"],
        expiration: json["expiration"] == null ? null : DateTime.parse(json["expiration"]),
        id: json["id"],
        email: json["email"],
        username: json["username"],
        phonenumber: json["phonenumber"],
        userRoles: json["userRoles"] == null ? [] : List<String>.from(json["userRoles"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "expiration": expiration?.toIso8601String(),
        "id": id,
        "email": email,
        "username": username,
        "phonenumber": phonenumber,
        "userRoles": userRoles == null ? [] : List<dynamic>.from(userRoles!.map((x) => x)),
    };
}

import 'dart:convert';

FiltrationResponseModel filtrationResponseModelFromJson(dynamic str) =>
    FiltrationResponseModel.fromJson(json.decode(str));

dynamic filtrationResponseModelToJson(FiltrationResponseModel data) =>
    json.encode(data.toJson());

class FiltrationResponseModel {
  List<Datum>? data;
  dynamic? message;

  FiltrationResponseModel({
    this.data,
    this.message,
  });

  factory FiltrationResponseModel.fromJson(Map<dynamic, dynamic> json) =>
      FiltrationResponseModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<dynamic, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}
class Datum {
    dynamic id;
    dynamic firstName;
    dynamic lastName;
    dynamic regularRate;
    dynamic tradeId;
    dynamic statusId;
    dynamic dob;
    dynamic profileType;
    dynamic profileBytes;

    Datum({
        this.id,
        this.firstName,
        this.lastName,
        this.regularRate,
        this.tradeId,
        this.statusId,
        this.dob,
        this.profileType,
        this.profileBytes,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        regularRate: json["regularRate"],
        tradeId: json["tradeId"],
        statusId: json["statusId"],
        dob: json["dob"],
        profileType: json["profileType"],
        profileBytes: json["profileBytes"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "regularRate": regularRate,
        "tradeId": tradeId,
        "statusId": statusId,
        "dob": dob,
        "profileType": profileType,
        "profileBytes": profileBytes,
    };
}

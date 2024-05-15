import 'dart:convert';

SuccessModel successModelFromJson(String str) => SuccessModel.fromJson(json.decode(str));

String successModelToJson(SuccessModel data) => json.encode(data.toJson());

class SuccessModel {
    int? id;
    String? message;

    SuccessModel({
        this.id,
        this.message,
    });

    factory SuccessModel.fromJson(Map<String, dynamic> json) => SuccessModel(
        id: json["id"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
    };
}

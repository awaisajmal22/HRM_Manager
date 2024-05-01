// To parse this JSON data, do
//
//     final avaliableWorkerModel = avaliableWorkerModelFromJson(jsonString);

import 'dart:convert';

AvaliableWorkerModel avaliableWorkerModelFromJson(String str) => AvaliableWorkerModel.fromJson(json.decode(str));

String avaliableWorkerModelToJson(AvaliableWorkerModel data) => json.encode(data.toJson());

class AvaliableWorkerModel {
    String? name;
    String? price;
    String? trade;
    String? status;
    String? dob;

    AvaliableWorkerModel({
        this.name,
        this.price,
        this.trade,
        this.status,
        this.dob,
    });

    factory AvaliableWorkerModel.fromJson(Map<String, dynamic> json) => AvaliableWorkerModel(
        name: json["name"],
        price: json["price"],
        trade: json["trade"],
        status: json["status"],
        dob: json["dob"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "trade": trade,
        "status": status,
        "dob": dob,
    };
}

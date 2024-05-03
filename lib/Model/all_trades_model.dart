// To parse this JSON data, do
//
//     final allTradeModel = allTradeModelFromJson(jsonString);

import 'dart:convert';

List<AllTradeModel> allTradeModelFromJson(String str) => List<AllTradeModel>.from(json.decode(str).map((x) => AllTradeModel.fromJson(x)));

String allTradeModelToJson(List<AllTradeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllTradeModel {
    int? id;
    String? tradeOptionName;
    String? description;

    AllTradeModel({
        this.id,
        this.tradeOptionName,
        this.description,
    });

    factory AllTradeModel.fromJson(Map<String, dynamic> json) => AllTradeModel(
        id: json["id"],
        tradeOptionName: json["tradeOptionName"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tradeOptionName": tradeOptionName,
        "description": description,
    };
}

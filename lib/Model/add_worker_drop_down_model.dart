import 'dart:convert';

List<AddWorkerDropDownModel> addWorkerDropDownModelFromJson(String str) => List<AddWorkerDropDownModel>.from(json.decode(str).map((x) => AddWorkerDropDownModel.fromJson(x)));

String addWorkerDropDownModelToJson(List<AddWorkerDropDownModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddWorkerDropDownModel {
    int? id;
    String? name;

    AddWorkerDropDownModel({
        this.id,
        this.name,
    });

    factory AddWorkerDropDownModel.fromJson(Map<String, dynamic> json) => AddWorkerDropDownModel(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

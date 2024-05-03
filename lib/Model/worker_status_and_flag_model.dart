
import 'dart:convert';

List<StatusAndFlagModel> StatusAndFlagModelFromJson(String str) => List<StatusAndFlagModel>.from(json.decode(str).map((x) => StatusAndFlagModel.fromJson(x)));

String StatusAndFlagModelToJson(List<StatusAndFlagModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StatusAndFlagModel {
    int? id;
    String? name;
    String? description;

    StatusAndFlagModel({
        this.id,
        this.name,
        this.description,
    });

    factory StatusAndFlagModel.fromJson(Map<String, dynamic> json) => StatusAndFlagModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
    };
}

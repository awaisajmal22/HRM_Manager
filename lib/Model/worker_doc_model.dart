import 'dart:convert';

WorkerDocModel workerDocModelFromJson(String str) => WorkerDocModel.fromJson(json.decode(str));

String workerDocModelToJson(WorkerDocModel data) => json.encode(data.toJson());

class WorkerDocModel {
    String? wasabiBytes;
    String? contentType;
    String? title;

    WorkerDocModel({
        this.wasabiBytes,
        this.contentType,
        this.title,
    });

    factory WorkerDocModel.fromJson(Map<String, dynamic> json) => WorkerDocModel(
        wasabiBytes: json["wasabiBytes"],
        contentType: json["contentType"],
        title: json['title'],
    );

    Map<String, dynamic> toJson() => {
        "wasabiBytes": wasabiBytes,
        "contentType": contentType,
        "title":title,
    };
}


import 'dart:convert';

WorkerProfileModel workerProfileModelFromJson(String str) => WorkerProfileModel.fromJson(json.decode(str));

String workerProfileModelToJson(WorkerProfileModel data) => json.encode(data.toJson());

class WorkerProfileModel {
    String? name;
    String? price;
    String? trade;
    String? status;
    String? dob;
    String? experience;
    String? previousEmployment;
    String? unionAffiliation;
    String? flag;
    String? transportation;
    String? home;
    String? certificate;
    String? specialTickets;
    String? note;

    WorkerProfileModel({
        this.name,
        this.price,
        this.trade,
        this.status,
        this.dob,
        this.experience,
        this.previousEmployment,
        this.unionAffiliation,
        this.flag,
        this.transportation,
        this.home,
        this.certificate,
        this.specialTickets,
        this.note,
    });

    factory WorkerProfileModel.fromJson(Map<String, dynamic> json) => WorkerProfileModel(
        name: json["name"],
        price: json["price"],
        trade: json["trade"],
        status: json["status"],
        dob: json["dob"],
        experience: json["experience"],
        previousEmployment: json["previous_employment"],
        unionAffiliation: json["union_affiliation"],
        flag: json["flag"],
        transportation: json["transportation"],
        home: json["home"],
        certificate: json["certificate"],
        specialTickets: json["special_tickets"],
        note: json["note"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "trade": trade,
        "status": status,
        "dob": dob,
        "experience": experience,
        "previous_employment": previousEmployment,
        "union_affiliation": unionAffiliation,
        "flag": flag,
        "transportation": transportation,
        "home": home,
        "certificate": certificate,
        "special_tickets": specialTickets,
        "note": note,
    };
}

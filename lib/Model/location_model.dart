
import 'dart:convert';

List<LocationModel> locationModelFromJson(String str) => List<LocationModel>.from(json.decode(str).map((x) => LocationModel.fromJson(x)));

String locationModelToJson(List<LocationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationModel {
    String? city;
    String? postalCode;

    LocationModel({
        this.city,
        this.postalCode,
    });

    factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        city: json["city"],
        postalCode: json["postalCode"],
    );

    Map<String, dynamic> toJson() => {
        "city": city,
        "postalCode": postalCode,
    };
}

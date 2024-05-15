import 'dart:convert';

List<JobSiteModel> jobSiteModelFromJson(String str) => List<JobSiteModel>.from(json.decode(str).map((x) => JobSiteModel.fromJson(x)));

String jobSiteModelToJson(List<JobSiteModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobSiteModel {
    int? jobsiteId;
    int? workerId;

    JobSiteModel({
        this.jobsiteId,
        this.workerId,
    });

    factory JobSiteModel.fromJson(Map<String, dynamic> json) => JobSiteModel(
        jobsiteId: json["jobsiteId"],
        workerId: json["workerId"],
    );

    Map<String, dynamic> toJson() => {
        "jobsiteId": jobsiteId,
        "workerId": workerId,
    };
}

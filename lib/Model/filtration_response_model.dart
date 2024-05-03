
import 'dart:convert';

FiltrationResponseModel filtrationResponseModelFromJson(dynamic str) => FiltrationResponseModel.fromJson(json.decode(str));

dynamic filtrationResponseModelToJson(FiltrationResponseModel data) => json.encode(data.toJson());

class FiltrationResponseModel {
    List<Datum>? data;
    dynamic? message;

    FiltrationResponseModel({
        this.data,
        this.message,
    });

    factory FiltrationResponseModel.fromJson(Map<dynamic, dynamic> json) => FiltrationResponseModel(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
    );

    Map<dynamic, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class Datum {
    dynamic dynamicernalWorkerId;
  dynamic age;
    dynamic firstName;
    dynamic nameContact1;
    dynamic mobileContact1;
    dynamic emailContact1;
    dynamic titleContact1;
    dynamic emailAdminContact1;
    dynamic contractorAdminPhone;
    dynamic adminEmail;
    dynamic adminExtention;
    dynamic addedDate;
    dynamic pickUpLocation;
    dynamic workerManagerPickUpLocation;
    dynamic? workerPickUpLocation;
    dynamic workerManagerWorkerPickUpLocation;
    dynamic? workerId;
    dynamic? lastName;
    dynamic? socialInsuranceNumber;
    dynamic? bussinessName;
    dynamic bussinessRegistrationNo;
    dynamic? bussinessWsibNo;
    dynamic address1;
    dynamic address2;
    dynamic state;
    dynamic? province;
    dynamic? postalCode;
    dynamic? country;
    dynamic? city;
    dynamic fax;
    dynamic? homeTele;
    dynamic? businessTele;
    dynamic? mobile;
    dynamic? email;
    dynamic paymentNotes;
    dynamic? workExperience;
    dynamic? workExperienceNotes;
    dynamic employeeHistoryNotes;
    dynamic unionAffillationsId;
    dynamic unionAffillationNotes;
    bool? paymentDelivery;
    bool? submitsOwnHours;
    bool? pastWsibClaim;
    dynamic? wsibClaimNotes;
    dynamic isTeamLeader;
    bool? legalToWork;
    dynamic twoRateSimple;
    dynamic dollarFlatRate;
    dynamic percentageRate;
    dynamic adminFeePercentageRate;
    dynamic transactionFee;
    dynamic paymentprocessor;
    dynamic managmentFee;
    dynamic fundsAdvanceFeeRate;
    DateTime? workerHireDate;
    DateTime? workerTerminationDate;
    DateTime? dateofBirth;
    dynamic? regularRate;
    dynamic? overTimeRate;
    dynamic isRecruiterCommission;
    dynamic? recruiterCommission;
    dynamic? billRate;
    dynamic? tradeLicenseNo;
    dynamic paymentRuleId;
    dynamic? workerFlagId;
    dynamic? workerStatusId;
    dynamic? lanaguageId;
    dynamic? workPermitNo;
    bool? ownTransportation;
    bool? englishFluency;
    dynamic notes;
    bool? clientPaysWsib;
    dynamic wsibRate;
    dynamic? type;
    dynamic? tradeOptionId;
    dynamic trade;
    dynamic certificationId;
    dynamic certificationsNotes;
    dynamic unionAffiliation;
    dynamic unionAffiliationNotes;
    dynamic emergencyContact1;
    dynamic emergencyContact2;
    dynamic emergencyTelephone1;
    dynamic emergencyTelephone2;
    dynamic? timeSheettype;
    dynamic? userId;
    dynamic user;
    dynamic paymentRule;
    dynamic workerStatus;
    dynamic jobSiteWorkers;
    dynamic assignJobSite;
    dynamic assignJobSitetoWorker;
    dynamic workerManagerTradeOptions;
    dynamic assignClient;
    dynamic workerDocuments;
    dynamic workerJobsite;
    dynamic workerHoursByClient;
    dynamic workerHoursByWorker;
    dynamic dailyWorkerHours;
    dynamic extraLineItem;
    dynamic recruiterExtraLineItem;
    dynamic? id;
    dynamic createdby;
    bool? isDeleted;
    dynamic deleterUserId;
    dynamic deletionTime;
    dynamic createdDate;
    dynamic lastModificationTime;
    dynamic lastModifierUserId;

    Datum({
        this.dynamicernalWorkerId,
        this.age,
        this.firstName,
        this.nameContact1,
        this.mobileContact1,
        this.emailContact1,
        this.titleContact1,
        this.emailAdminContact1,
        this.contractorAdminPhone,
        this.adminEmail,
        this.adminExtention,
        this.addedDate,
        this.pickUpLocation,
        this.workerManagerPickUpLocation,
        this.workerPickUpLocation,
        this.workerManagerWorkerPickUpLocation,
        this.workerId,
        this.lastName,
        this.socialInsuranceNumber,
        this.bussinessName,
        this.bussinessRegistrationNo,
        this.bussinessWsibNo,
        this.address1,
        this.address2,
        this.state,
        this.province,
        this.postalCode,
        this.country,
        this.city,
        this.fax,
        this.homeTele,
        this.businessTele,
        this.mobile,
        this.email,
        this.paymentNotes,
        this.workExperience,
        this.workExperienceNotes,
        this.employeeHistoryNotes,
        this.unionAffillationsId,
        this.unionAffillationNotes,
        this.paymentDelivery,
        this.submitsOwnHours,
        this.pastWsibClaim,
        this.wsibClaimNotes,
        this.isTeamLeader,
        this.legalToWork,
        this.twoRateSimple,
        this.dollarFlatRate,
        this.percentageRate,
        this.adminFeePercentageRate,
        this.transactionFee,
        this.paymentprocessor,
        this.managmentFee,
        this.fundsAdvanceFeeRate,
        this.workerHireDate,
        this.workerTerminationDate,
        this.dateofBirth,
        this.regularRate,
        this.overTimeRate,
        this.isRecruiterCommission,
        this.recruiterCommission,
        this.billRate,
        this.tradeLicenseNo,
        this.paymentRuleId,
        this.workerFlagId,
        this.workerStatusId,
        this.lanaguageId,
        this.workPermitNo,
        this.ownTransportation,
        this.englishFluency,
        this.notes,
        this.clientPaysWsib,
        this.wsibRate,
        this.type,
        this.tradeOptionId,
        this.trade,
        this.certificationId,
        this.certificationsNotes,
        this.unionAffiliation,
        this.unionAffiliationNotes,
        this.emergencyContact1,
        this.emergencyContact2,
        this.emergencyTelephone1,
        this.emergencyTelephone2,
        this.timeSheettype,
        this.userId,
        this.user,
        this.paymentRule,
        this.workerStatus,
        this.jobSiteWorkers,
        this.assignJobSite,
        this.assignJobSitetoWorker,
        this.workerManagerTradeOptions,
        this.assignClient,
        this.workerDocuments,
        this.workerJobsite,
        this.workerHoursByClient,
        this.workerHoursByWorker,
        this.dailyWorkerHours,
        this.extraLineItem,
        this.recruiterExtraLineItem,
        this.id,
        this.createdby,
        this.isDeleted,
        this.deleterUserId,
        this.deletionTime,
        this.createdDate,
        this.lastModificationTime,
        this.lastModifierUserId,
    });

    factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
        dynamicernalWorkerId: json["dynamicernalWorkerID"],
        age: json["age"],
        firstName: json["firstName"],
        nameContact1: json["nameContact1"],
        mobileContact1: json["mobileContact1"],
        emailContact1: json["emailContact1"],
        titleContact1: json["titleContact1"],
        emailAdminContact1: json["emailAdminContact1"],
        contractorAdminPhone: json["contractorAdminPhone"],
        adminEmail: json["adminEmail"],
        adminExtention: json["adminExtention"],
        addedDate: json["addedDate"],
        pickUpLocation: json["pickUpLocation"],
        workerManagerPickUpLocation: json["workerManagerPickUpLocation"],
        workerPickUpLocation: json["workerPickUpLocation"],
        workerManagerWorkerPickUpLocation: json["workerManagerWorkerPickUpLocation"],
        workerId: json["workerId"],
        lastName: json["lastName"],
        socialInsuranceNumber: json["socialInsuranceNumber"],
        bussinessName: json["bussinessName"],
        bussinessRegistrationNo: json["bussinessRegistrationNo"],
        bussinessWsibNo: json["bussinessWSIBNo"],
        address1: json["address1"],
        address2: json["address2"],
        state: json["state"],
        province: json["province"],
        postalCode: json["postalCode"],
        country: json["country"],
        city: json["city"],
        fax: json["fax"],
        homeTele: json["homeTele"],
        businessTele: json["businessTele"],
        mobile: json["mobile"],
        email: json["email"],
        paymentNotes: json["paymentNotes"],
        workExperience: json["workExperience"],
        workExperienceNotes: json["workExperienceNotes"],
        employeeHistoryNotes: json["employeeHistoryNotes"],
        unionAffillationsId: json["unionAffillationsId"],
        unionAffillationNotes: json["unionAffillationNotes"],
        paymentDelivery: json["paymentDelivery"],
        submitsOwnHours: json["submitsOwnHours"],
        pastWsibClaim: json["pastWSIBClaim"],
        wsibClaimNotes: json["wsibClaimNotes"],
        isTeamLeader: json["isTeamLeader"],
        legalToWork: json["legalToWork"],
        twoRateSimple: json["twoRateSimple"],
        dollarFlatRate: json["dollarFlatRate"],
        percentageRate: json["percentageRate"],
        adminFeePercentageRate: json["adminFeePercentageRate"],
        transactionFee: json["transactionFee"],
        paymentprocessor: json["paymentprocessor"],
        managmentFee: json["managmentFee"],
        fundsAdvanceFeeRate: json["fundsAdvanceFeeRate"],
        workerHireDate: json["workerHireDate"] == null ? null : DateTime.parse(json["workerHireDate"]),
        workerTerminationDate: json["workerTerminationDate"] == null ? null : DateTime.parse(json["workerTerminationDate"]),
        dateofBirth: json["dateofBirth"] == null ? null : DateTime.parse(json["dateofBirth"]),
        regularRate: json["regularRate"],
        overTimeRate: json["overTimeRate"],
        isRecruiterCommission: json["isRecruiterCommission"],
        recruiterCommission: json["recruiterCommission"],
        billRate: json["billRate"],
        tradeLicenseNo: json["tradeLicenseNo"],
        paymentRuleId: json["paymentRuleId"],
        workerFlagId: json["workerFlagId"],
        workerStatusId: json["workerStatusId"],
        lanaguageId: json["lanaguageId"],
        workPermitNo: json["workPermitNo"],
        ownTransportation: json["ownTransportation"],
        englishFluency: json["englishFluency"],
        notes: json["notes"],
        clientPaysWsib: json["clientPaysWSIB"],
        wsibRate: json["wsibRate"],
        type: json["type"],
        tradeOptionId: json["tradeOptionId"],
        trade: json["trade"],
        certificationId: json["certificationId"],
        certificationsNotes: json["certificationsNotes"],
        unionAffiliation: json["unionAffiliation"],
        unionAffiliationNotes: json["unionAffiliationNotes"],
        emergencyContact1: json["emergencyContact1"],
        emergencyContact2: json["emergencyContact2"],
        emergencyTelephone1: json["emergencyTelephone1"],
        emergencyTelephone2: json["emergencyTelephone2"],
        timeSheettype: json["timeSheettype"],
        userId: json["userId"],
        user: json["user"],
        paymentRule: json["paymentRule"],
        workerStatus: json["workerStatus"],
        jobSiteWorkers: json["jobSiteWorkers"],
        assignJobSite: json["assignJobSite"],
        assignJobSitetoWorker: json["assignJobSitetoWorker"],
        workerManagerTradeOptions: json["workerManagerTradeOptions"],
        assignClient: json["assignClient"],
        workerDocuments: json["workerDocuments"],
        workerJobsite: json["workerJobsite"],
        workerHoursByClient: json["workerHoursByClient"],
        workerHoursByWorker: json["workerHoursByWorker"],
        dailyWorkerHours: json["dailyWorkerHours"],
        extraLineItem: json["extraLineItem"],
        recruiterExtraLineItem: json["recruiterExtraLineItem"],
        id: json["id"],
        createdby: json["createdby"],
        isDeleted: json["isDeleted"],
        deleterUserId: json["deleterUserId"],
        deletionTime: json["deletionTime"],
        createdDate: json["createdDate"],
        lastModificationTime: json["lastModificationTime"],
        lastModifierUserId: json["lastModifierUserId"],
    );

    Map<dynamic, dynamic> toJson() => {
        "dynamicernalWorkerID": dynamicernalWorkerId,
        "age": age,
        "firstName": firstName,
        "nameContact1": nameContact1,
        "mobileContact1": mobileContact1,
        "emailContact1": emailContact1,
        "titleContact1": titleContact1,
        "emailAdminContact1": emailAdminContact1,
        "contractorAdminPhone": contractorAdminPhone,
        "adminEmail": adminEmail,
        "adminExtention": adminExtention,
        "addedDate": addedDate,
        "pickUpLocation": pickUpLocation,
        "workerManagerPickUpLocation": workerManagerPickUpLocation,
        "workerPickUpLocation": workerPickUpLocation,
        "workerManagerWorkerPickUpLocation": workerManagerWorkerPickUpLocation,
        "workerId": workerId,
        "lastName": lastName,
        "socialInsuranceNumber": socialInsuranceNumber,
        "bussinessName": bussinessName,
        "bussinessRegistrationNo": bussinessRegistrationNo,
        "bussinessWSIBNo": bussinessWsibNo,
        "address1": address1,
        "address2": address2,
        "state": state,
        "province": province,
        "postalCode": postalCode,
        "country": country,
        "city": city,
        "fax": fax,
        "homeTele": homeTele,
        "businessTele": businessTele,
        "mobile": mobile,
        "email": email,
        "paymentNotes": paymentNotes,
        "workExperience": workExperience,
        "workExperienceNotes": workExperienceNotes,
        "employeeHistoryNotes": employeeHistoryNotes,
        "unionAffillationsId": unionAffillationsId,
        "unionAffillationNotes": unionAffillationNotes,
        "paymentDelivery": paymentDelivery,
        "submitsOwnHours": submitsOwnHours,
        "pastWSIBClaim": pastWsibClaim,
        "wsibClaimNotes": wsibClaimNotes,
        "isTeamLeader": isTeamLeader,
        "legalToWork": legalToWork,
        "twoRateSimple": twoRateSimple,
        "dollarFlatRate": dollarFlatRate,
        "percentageRate": percentageRate,
        "adminFeePercentageRate": adminFeePercentageRate,
        "transactionFee": transactionFee,
        "paymentprocessor": paymentprocessor,
        "managmentFee": managmentFee,
        "fundsAdvanceFeeRate": fundsAdvanceFeeRate,
        "workerHireDate": workerHireDate?.toIso8601String(),
        "workerTerminationDate": workerTerminationDate?.toIso8601String(),
        "dateofBirth": dateofBirth?.toIso8601String(),
        "regularRate": regularRate,
        "overTimeRate": overTimeRate,
        "isRecruiterCommission": isRecruiterCommission,
        "recruiterCommission": recruiterCommission,
        "billRate": billRate,
        "tradeLicenseNo": tradeLicenseNo,
        "paymentRuleId": paymentRuleId,
        "workerFlagId": workerFlagId,
        "workerStatusId": workerStatusId,
        "lanaguageId": lanaguageId,
        "workPermitNo": workPermitNo,
        "ownTransportation": ownTransportation,
        "englishFluency": englishFluency,
        "notes": notes,
        "clientPaysWSIB": clientPaysWsib,
        "wsibRate": wsibRate,
        "type": type,
        "tradeOptionId": tradeOptionId,
        "trade": trade,
        "certificationId": certificationId,
        "certificationsNotes": certificationsNotes,
        "unionAffiliation": unionAffiliation,
        "unionAffiliationNotes": unionAffiliationNotes,
        "emergencyContact1": emergencyContact1,
        "emergencyContact2": emergencyContact2,
        "emergencyTelephone1": emergencyTelephone1,
        "emergencyTelephone2": emergencyTelephone2,
        "timeSheettype": timeSheettype,
        "userId": userId,
        "user": user,
        "paymentRule": paymentRule,
        "workerStatus": workerStatus,
        "jobSiteWorkers": jobSiteWorkers,
        "assignJobSite": assignJobSite,
        "assignJobSitetoWorker": assignJobSitetoWorker,
        "workerManagerTradeOptions": workerManagerTradeOptions,
        "assignClient": assignClient,
        "workerDocuments": workerDocuments,
        "workerJobsite": workerJobsite,
        "workerHoursByClient": workerHoursByClient,
        "workerHoursByWorker": workerHoursByWorker,
        "dailyWorkerHours": dailyWorkerHours,
        "extraLineItem": extraLineItem,
        "recruiterExtraLineItem": recruiterExtraLineItem,
        "id": id,
        "createdby": createdby,
        "isDeleted": isDeleted,
        "deleterUserId": deleterUserId,
        "deletionTime": deletionTime,
        "createdDate": createdDate,
        "lastModificationTime": lastModificationTime,
        "lastModifierUserId": lastModifierUserId,
    };
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hrm_manager/Model/add_worker_drop_down_model.dart';
import 'package:hrm_manager/Network/api_services.dart';
import 'package:hrm_manager/Network/api_url.dart';
import 'package:hrm_manager/constant/spinkit_view.dart';

class EditWorkerServices {
  Future getWorkerExperience({required BuildContext context}) async {
    List<AddWorkerDropDownModel> dropDownList = <AddWorkerDropDownModel>[];
    try {
      final response =
          await API().getRequest(context, ApiUrl.getWorkerExperinceUrl);
      if (response.statusCode == 200) {
        final Map data = response.data as Map<dynamic, dynamic>;
        print(data);
        dropDownList = data.entries
            .map((e) =>
                AddWorkerDropDownModel(id: int.parse(e.key), name: e.value))
            .toList();
      } else {
        return;
      }
    } catch (e) {
      return;
    }
    return dropDownList;
  }

  Future getTimeSheet({required BuildContext context}) async {
    List<AddWorkerDropDownModel> dropDownList = <AddWorkerDropDownModel>[];
    try {
      final response = await API().getRequest(context, ApiUrl.getTimeSheetUrl);
      if (response.statusCode == 200) {
        final Map data = response.data as Map<dynamic, dynamic>;
        print(data);
        dropDownList = data.entries
            .map((e) =>
                AddWorkerDropDownModel(id: int.parse(e.key), name: e.value))
            .toList();
      } else {
        return;
      }
    } catch (e) {
      return;
    }
    return dropDownList;
  }

  Future getUnionAfflication({required BuildContext context}) async {
    List<AddWorkerDropDownModel> dropDownList = <AddWorkerDropDownModel>[];
    try {
      final response =
          await API().getRequest(context, ApiUrl.getUnionAffiliationUrl);
      if (response.statusCode == 200) {
        final Map data = response.data as Map<dynamic, dynamic>;
        print(data);
        dropDownList = data.entries
            .map((e) =>
                AddWorkerDropDownModel(id: int.parse(e.key), name: e.value))
            .toList();
      } else {
        return;
      }
    } catch (e) {
      return;
    }
    return dropDownList;
  }

  Future getJobSite({required BuildContext context}) async {
    List<AddWorkerDropDownModel> dropDownList = <AddWorkerDropDownModel>[];
    try {
      final response = await API().getRequest(context, ApiUrl.getJobSitesUrl);
      if (response.statusCode == 200) {
        response.data.forEach(
            (e) => dropDownList.add(AddWorkerDropDownModel.fromJson(e)));
      } else {
        return;
      }
    } catch (e) {
      return;
    }
    return dropDownList;
  }

  Future getRecruiter({required BuildContext context}) async {
    List<AddWorkerDropDownModel> dropDownList = <AddWorkerDropDownModel>[];
    try {
      final response = await API().getRequest(context, ApiUrl.getRecruiterUrl);
      if (response.statusCode == 200) {
        response.data.forEach(
            (e) => dropDownList.add(AddWorkerDropDownModel.fromJson(e)));
      } else {
        return;
      }
    } catch (e) {
      return;
    }
    return dropDownList;
  }

  Future getCertificate({required BuildContext context}) async {
    List<AddWorkerDropDownModel> dropDownList = <AddWorkerDropDownModel>[];
    try {
      final response =
          await API().getRequest(context, ApiUrl.getCertificationsUrl);
      if (response.statusCode == 200) {
        response.data.forEach(
            (e) => dropDownList.add(AddWorkerDropDownModel.fromJson(e)));
      } else {
        return;
      }
    } catch (e) {
      return;
    }
    return dropDownList;
  }

  Future getLanguage({required BuildContext context}) async {
    List<AddWorkerDropDownModel> dropDownList = <AddWorkerDropDownModel>[];
    try {
      final response = await API().getRequest(context, ApiUrl.getLanguagesUrl);
      if (response.statusCode == 200) {
        response.data.forEach(
            (e) => dropDownList.add(AddWorkerDropDownModel.fromJson(e)));
      } else {
        return;
      }
    } catch (e) {
      return;
    }
    return dropDownList;
  }

  Future getWorkerPickupLocation({required BuildContext context}) async {
    List<AddWorkerDropDownModel> dropDownList = <AddWorkerDropDownModel>[];
    try {
      final response =
          await API().getRequest(context, ApiUrl.getWorkerPickUpLocationUrl);
      if (response.statusCode == 200) {
        response.data.forEach(
            (e) => dropDownList.add(AddWorkerDropDownModel.fromJson(e)));
      } else {
        return;
      }
    } catch (e) {
      return;
    }
    return dropDownList;
  }

  Future<List<AddWorkerDropDownModel>> getWorkerStatus(
      {required BuildContext context}) async {
    List<AddWorkerDropDownModel> statusModelList = <AddWorkerDropDownModel>[];
    try {
      final response = await API().getRequest(context, ApiUrl.workerStatusUrl);
      if (response.statusCode == 200) {
        response.data.forEach(
            (dt) => statusModelList.add(AddWorkerDropDownModel.fromJson(dt)));
      }
    } catch (e) {}

    return statusModelList;
  }

  Future<List<AddWorkerDropDownModel>> getWorkerFlag(
      {required BuildContext context}) async {
    List<AddWorkerDropDownModel> statusModelList = <AddWorkerDropDownModel>[];
    try {
      final response = await API().getRequest(context, ApiUrl.workerFlagUrl);
      if (response.statusCode == 200) {
        response.data.forEach(
            (dt) => statusModelList.add(AddWorkerDropDownModel.fromJson(dt)));
      }
    } catch (e) {}

    return statusModelList;
  }

  addWorker({
    required BuildContext context,
    int? workerID,
    String? internalWorkerID,
    String? clientWorkerID,
    int? age,
    String? firstName,
    String? nameContact1,
    String? mobileContact1,
    String? emailContact1,
    String? titleContact1,
    String? emailAdminContact1,
    String? constructorAdminPhone,
    String? adminEmail,
    String? adminExtension,
    String? addedDate,
    int? workerPickupLocation,
    int? recruiterAssingId,
    String? lastName,
    String? socialInsuranceNo,
    String? businessName,
    String? businessRegNo,
    String? businessWIBSno,
    String? address1,
    String? address2,
    String? state,
    String? province,
    String? postalCode,
    String? country,
    String? city,
    String? fax,
    String? homeTele,
    String? businessTele,
    String? mobile,
    String? email,
    String? paymentNotes,
    String? workExperience,
    String? workExperienceNotes,
    String? employeHistoryNotes,
    String? unionAffliciationId,
    String? unionAffliciationNotes,
    bool? paymentDelivery,
    bool? submitOwnHours,
    bool? pastWIBSClaim,
    String? wibsClaimNotes,
    bool? isTeamLeader,
    bool? legalToWork,
    bool? twoRateSimple,
    double? dollarFlatRate,
    double? percentageRate,
    double? adminFeePercentageRate,
    double? transactionFee,
    bool? paymentProcessor,
    bool? isDefaultBooth,
    double? managementFee,
    double? fundsAdvanceFeeRate,
    String? workerHireDate,
    String? workerTerminateDate,
    String? dateOfBirth,
    double? regularRate,
    bool? isRecruiterComission,
    double? recruiterComission,
    double? billRate,
    String? tradeLicenseNo,
    int? paymentRuleId,
    String? workerFlagId,
    int? workerStatusId,
    String? languageId,
    String? workPermitNo,
    bool? ownTransport,
    bool? englishFluency,
    String? notes,
    bool? clientPayWSIB,
    double? wsibRate,
    int? tradeOptionId,
    String? certificationId,
    String? certificationNotes,
    String? unionAffilation,
    String? unionAffilationNotes,
    String? emergencyContact1,
    double? overTimeRate,
    String? emergencyContact2,
    String? emergencyTele1,
    String? emergencyTele2,
    int? timeSheetType,
    List<int>? jobSites,
  }) async {
    try {
      FormData data = FormData.fromMap({
        "Id": workerID,
        "InternalWorkerID": internalWorkerID,
        "ClientWorkerID": clientWorkerID,
        "Age": age,
        "FirstName": firstName,
        "NameContact1": nameContact1,
        "MobileContact1": mobileContact1,
        "EmailContact1": emailContact1,
        "TitleContact1": titleContact1,
        "EmailAdminContact1": emailAdminContact1,
        "ContractorAdminPhone": constructorAdminPhone,
        "AdminEmail": adminEmail,
        "AdminExtention": adminExtension,
        "AddedDate": addedDate,
        "WorkerPickUpLocation": workerPickupLocation,
        "AssignedRecuriterId": recruiterAssingId,
        "LastName": lastName,
        "SocialInsuranceNumber": socialInsuranceNo,
        "BussinessName": businessName,
        "BussinessRegistrationNo": businessRegNo,
        "BussinessWSIBNo": businessWIBSno,
        "Address1": address1,
        "Address2": address2,
        "State": state,
        "Province": province,
        "PostalCode": postalCode,
        "Country": country,
        "City": city,
        "Fax": fax,
        "HomeTele": homeTele,
        "BusinessTele": businessTele,
        "Mobile": mobile,
        "Email": email,
        "PaymentNotes": paymentNotes,
        "WorkExperience": workExperience,
        "WorkExperienceNotes": workExperienceNotes,
        "EmployeeHistoryNotes": employeHistoryNotes,
        "UnionAffillationsId": unionAffliciationId,
        "UnionAffillationNotes": unionAffilationNotes,
        "PaymentDelivery": paymentDelivery,
        "SubmitsOwnHours": submitOwnHours,
        "PastWSIBClaim": pastWIBSClaim,
        "WSIBClaimNotes": wibsClaimNotes,
        "IsTeamLeader": isTeamLeader,
        "LegalToWork": legalToWork,
        "TwoRateSimple": twoRateSimple,
        "DollarFlatRate": dollarFlatRate,
        "PercentageRate": percentageRate,
        "AdminFeePercentageRate": adminFeePercentageRate,
        "TransactionFee": transactionFee,
        "Paymentprocessor": paymentProcessor,
        "IsDefaultBooth": isDefaultBooth,
        "ManagmentFee": managementFee,
        "FundsAdvanceFeeRate": fundsAdvanceFeeRate,
        "WorkerHireDate": workerHireDate,
        "WorkerTerminationDate": workerTerminateDate,
        "DateofBirth": dateOfBirth,
        "RegularRate": regularRate,
        "OverTimeRate": overTimeRate,
        "IsRecruiterCommission": isRecruiterComission,
        "RecruiterCommission": recruiterComission,
        "BillRate": billRate,
        "TradeLicenseNo": tradeLicenseNo,
        "PaymentRuleId": paymentRuleId,
        "WorkerFlagId": workerFlagId,
        "WorkerStatusId": workerStatusId,
        "LanaguageId": languageId,
        "WorkPermitNo": workPermitNo,
        "OwnTransportation": ownTransport,
        "EnglishFluency": englishFluency,
        "Notes": notes,
        "ClientPaysWSIB": clientPayWSIB,
        "WSIBRate": wsibRate,
        "TradeOptionId": tradeOptionId,
        "CertificationId": certificationId,
        "CertificationsNotes": certificationNotes,
        "UnionAffiliation": unionAffilation,
        "UnionAffiliationNotes": unionAffilationNotes,
        "EmergencyContact1": emergencyContact1,
        "EmergencyContact2": emergencyContact2,
        "EmergencyTelephone1": emergencyTele1,
        "EmergencyTelephone2": emergencyTele2,
        "TimeSheettype": timeSheetType,
        "Jobsites": jobSites,
      });
      showLoadingIndicator(context: context);
      final response =
          await API().postRequestHeader(context, ApiUrl.saveWorker, data);
      if (response.statusCode == 200) {
        hideOpenDialog(context: context);
        print("Add Worker Successfully");
      } else {
        hideOpenDialog(context: context);
      }
    } catch (e) {
      hideOpenDialog(context: context);
    }
  }
}
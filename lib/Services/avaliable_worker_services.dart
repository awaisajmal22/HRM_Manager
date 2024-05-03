import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrm_manager/Model/filtration_response_model.dart';
import 'package:hrm_manager/Model/worker_status_and_flag_model.dart';
import 'package:hrm_manager/Network/api_services.dart';
import 'package:hrm_manager/Network/api_url.dart';

class AvaliableWorkerServices {
  Future<List<StatusAndFlagModel>> getWorkerStatus(
      {required BuildContext context}) async {
    List<StatusAndFlagModel> statusModelList = <StatusAndFlagModel>[];
    try {
      final response = await API().getRequest(context, ApiUrl.workerStatusUrl);
      if (response.statusCode == 200) {
        response.data.forEach(
            (dt) => statusModelList.add(StatusAndFlagModel.fromJson(dt)));
      }
    } catch (e) {}

    return statusModelList;
  }

  Future<List<StatusAndFlagModel>> getWorkerFlag(
      {required BuildContext context}) async {
    List<StatusAndFlagModel> statusModelList = <StatusAndFlagModel>[];
    try {
      final response = await API().getRequest(context, ApiUrl.workerFlagUrl);
      if (response.statusCode == 200) {
        response.data.forEach(
            (dt) => statusModelList.add(StatusAndFlagModel.fromJson(dt)));
      }
    } catch (e) {}

    return statusModelList;
  }

  Future<List<Datum>> getFiltrationData({
    required BuildContext context,
    int? tradeID,
    String? city,
    int? statusID,
    int? flagID,
    String? startPrice,
    String? endPrice,
  }) async {
    List<Datum> filtrationResponseModel = <Datum>[];
    var data = {
      'TradeId': tradeID,
      "City": city,
      "StatusId": statusID,
      "FlagId": flagID,
      "StartPrice": startPrice == null ? null : double.parse(startPrice),
      "EndPrice": endPrice == null ? null : double.parse(endPrice)
    };

    try {
      final response =
          await API().postRequest(context, ApiUrl.filterationUrl, data);
      if (response.statusCode == 200) {
        print(response.statusCode);
        print(response.data);

        response.data['data'].forEach((element) {
          filtrationResponseModel.add(Datum.fromJson(element));
        });
      }
    } catch (e) {}
    return filtrationResponseModel;
  }
}

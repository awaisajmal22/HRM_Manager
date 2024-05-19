import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hrm_manager/Model/worker_by_id_model.dart';
import 'package:hrm_manager/Model/worker_doc_model.dart';
import 'package:hrm_manager/Network/api_services.dart';
import 'package:hrm_manager/Network/api_url.dart';

class WorkerServices {
  Future<WorkerByIdModel> getWorkerData(
      {required BuildContext context, required int id}) async {
    WorkerByIdModel model = WorkerByIdModel();
    try {
      final response =
          await API().getRequestHeader(context, "${ApiUrl.getWorkerByIdUrl}/$id");
      if (response.statusCode == 200) {
        print(response.data);
        model = WorkerByIdModel.fromJson(response.data);

        print("Worker name ${model.id}");
      }
    } catch (e) {}
    return model;
  }

  Future<WorkerDocModel> getFiles({
    required String api,
    required BuildContext context,
  }) async {
    WorkerDocModel data = WorkerDocModel();
    try {
      print(api);
      final response = await API().getRequestHeader(context, api);
      print("Status is There ${response.statusCode}");
      if (response.statusCode == 200) {
        data = WorkerDocModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return data;
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hrm_manager/Model/worker_by_id_model.dart';
import 'package:hrm_manager/Network/api_services.dart';
import 'package:hrm_manager/Network/api_url.dart';

class WorkerServices {
  Future<WorkerByIdModel> getWorkerData(
      {required BuildContext context, required int id}) async {
    WorkerByIdModel model = WorkerByIdModel();
    try {
      final response =
          await API().getRequest(context, "${ApiUrl.getWorkerByIdUrl}/$id");
      if (response.statusCode == 200) {
print(response.data);
        model = WorkerByIdModel.fromJson(response.data);

        print("Worker name ${model.firstName}");
      }
    } catch (e) {}
    return model;
  }

  
}

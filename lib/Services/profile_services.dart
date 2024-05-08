import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hrm_manager/Model/profile_model.dart';
import 'package:hrm_manager/Network/api_services.dart';
import 'package:hrm_manager/Network/api_url.dart';
import 'package:hrm_manager/constant/back.dart';

class ProfileServices {
  Future<ProfileModel> getProfileData({required BuildContext context}) async {
    ProfileModel model = ProfileModel();

    try {
      final response =
          await API().getRequestHeader(context, ApiUrl.getProfileDataUrl);
      if (response.statusCode == 200) {
        model = ProfileModel.fromJson(response.data);
        print(" Email is there ${model.data!.email}");
      }
    } catch (e) {}
    return model;
  }

  Future<bool> changePassword(
      {required BuildContext context,
      required String currentPassword,
      required String newPassword}) async {
    bool isSuccess = false;
    Map<String, dynamic> formData = {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
    };
    try {
      final res = await API()
          .getRequestHeaderQuery(context, ApiUrl.changePasswordUrl, formData);
      print("StatusCode is ${res.statusCode}");
      if (res.statusCode == 200) {
        isSuccess = true;
        back(context: context);
      }
    } catch (e) {
      isSuccess = false;
    }
    return isSuccess;
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  Future<bool> changeProfileImage({
    required BuildContext context,
    required String profileImage,
  })async {
    bool isSuccess = false;
    try{
       FormData data = FormData.fromMap({
       
        "File": await MultipartFile.fromFile(
          profileImage,
        ),
      });
final response = await API().postRequestHeader(context, ApiUrl.updateProfileManagerImageUrl, data);
if(response.statusCode == 200){
isSuccess =true;
}else{
  isSuccess = false;
}
    }catch(e){
isSuccess = false;
    }
    return isSuccess;
  }
  Future<String> getProfileImage({
    required BuildContext context,
  
  })async {
    String isSuccess = '';
    try{
      
final response = await API().getRequestHeader(context, ApiUrl.getProfileManagerImageUrl,);
if(response.statusCode == 200){
// final decoded = jsonDecode(response.data);
isSuccess = response.data['wasabiBytes'];
}else{
  
  isSuccess = '';
}
    }catch(e){
isSuccess = '';
    }
    return isSuccess;
  }
}
  

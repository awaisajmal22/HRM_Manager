import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hrm_manager/Model/login_response_model.dart';
import 'package:hrm_manager/Network/api_services.dart';
import 'package:hrm_manager/Network/api_url.dart';
import 'package:hrm_manager/constant/spinkit_view.dart';
class LoginServices{
Future<LoginResponseModel> userLogin({required BuildContext context,required String email,required String password}) async{
 LoginResponseModel loginResponseModel = LoginResponseModel();
  try{
var data ={
  "username": email,
  "password": password
};

var response = await API().postRequest(context, ApiUrl.loginUrl, jsonEncode(data));
if(response.statusCode == 200){
  
  print(response.data);
  loginResponseModel = LoginResponseModel.fromJson(response.data);
}
  }catch(e){
 hideOpenDialog(context: context);
  }
  return loginResponseModel;
}
}
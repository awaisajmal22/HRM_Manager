import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hrm_manager/Network/api_services.dart';
import 'package:hrm_manager/Network/api_url.dart';
import 'package:hrm_manager/constant/toast.dart';

class ForgetPasswordServices {
  Future<bool> forgetPassword({
    required BuildContext context,
    required String email,
  }) async {
    bool isSuccess = false;
    var data = {"Email": email};
    try {
      final response = await API()
          .postRequestWithParam(context, ApiUrl.forgetPasswordUrl, data);
      if (response.statusCode == 200) {
        isSuccess = true;
        toast(
            msg: 'Please check your email for Password',
            context: context);
      } else {
        isSuccess = false;
      }
    } catch (e) {
      isSuccess = false;
    }
    return isSuccess;
  }
}

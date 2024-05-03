import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:hrm_manager/constant/app_text.dart';

toast({required String msg,required BuildContext context}){
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: appText(context: context, title: msg,textColor: AppColor.whiteColor)));
}
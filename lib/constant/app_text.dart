import 'package:flutter/material.dart';
import 'package:hrm_manager/extensions/font_size_extension.dart';

appText({
  required BuildContext context,
  required String title,
  String fontFamily = "Roboto",
  double fontSize = 14,
 FontWeight fontWeight = FontWeight.w400,
 TextAlign textAlign = TextAlign.center,
 Color textColor = Colors.black,
}){
  return Text(title,
  textAlign: textAlign,
  style: textStyle(context: context,fontSize: fontSize,fontWeight: fontWeight,textColor: textColor),);
}

TextStyle textStyle({
  required BuildContext context,

  String fontFamily = "Roboto",
  double fontSize = 14,
 FontWeight fontWeight = FontWeight.w400,

 Color textColor = Colors.black,
}) {
  return TextStyle(
  color: textColor,
  fontFamily: fontFamily,
  fontSize:context.fontSize(fontSize),
  fontWeight: fontWeight,
);
}
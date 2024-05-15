
  import 'package:flutter/material.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/app_color.dart';

Widget richText({
    required BuildContext context,
    required String title,
    required String subtitle,
    double fontSize =16,
    FontWeight fontWeight1 = FontWeight.w600,
    FontWeight fontWeight2 = FontWeight.w400,
    Color twoendTextColor = AppColor.blackColor,
  }) {
    return RichText(
        text: TextSpan(
            style: textStyle(
              context: context,
              fontSize: fontSize,
              fontWeight: fontWeight1,
              textColor: AppColor.blackColor,
            ),
            text: title,
            children: [
          TextSpan(
              style: textStyle(
                context: context,
                fontSize: fontSize,
                fontWeight: fontWeight2,
                textColor: twoendTextColor,
              ),
              text: subtitle)
        ]));
  }
Widget richText2({
    required BuildContext context,
    required String title,
    required List<String> subtitle,
    double fontSize =16,
    FontWeight fontWeight1 = FontWeight.w600,
    FontWeight fontWeight2 = FontWeight.w400,
    Color twoendTextColor = AppColor.blackColor,
  }) {
    return RichText(
        text: TextSpan(
            style: textStyle(
              context: context,
              fontSize: fontSize,
              fontWeight: fontWeight1,
              textColor: AppColor.blackColor,
            ),
            text: title,
            children: List.generate(subtitle.length, (index) {
              return TextSpan(
              style: textStyle(
                context: context,
                fontSize: fontSize,
                fontWeight: fontWeight2,
                textColor: twoendTextColor,
              ),
              text: "${subtitle[index]}, ");
            })
          
        ));
  }

  import 'package:flutter/material.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/utils/app_color.dart';

Widget richText({
    required BuildContext context,
    required String title,
    required String subtitle,
  }) {
    return RichText(
        text: TextSpan(
            style: textStyle(
              context: context,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              textColor: AppColor.blackColor,
            ),
            text: title,
            children: [
          TextSpan(
              style: textStyle(
                context: context,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                textColor: AppColor.blackColor,
              ),
              text: subtitle)
        ]));
  }
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/utils/app_color.dart';

textButton({
  required BuildContext context,
  required VoidCallback onTap,
  double hPadding = 0.020,
  double vPadding = 0.010,
  Color color = AppColor.purpleColor,
  double radius = 8,
  required String title,
  Color textColor = AppColor.whiteColor,
  double fontSize = 14,
  double? width,
  FontWeight fontWeight = FontWeight.w500,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width ?? context.getSize.width,
      padding: EdgeInsets.symmetric(
        horizontal: context.getSize.width * hPadding,
        vertical: context.getSize.height * vPadding,
      ),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(radius)),
      child: appText(
        context: context,
        title: title,
        textColor: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    ),
  );
}

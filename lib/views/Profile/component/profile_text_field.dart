import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:ionicons/ionicons.dart';

typedef OnChanged = Function(String);
typedef OpenFilter = Function();
profileTextField({
  required BuildContext context,
  required String hintText,
  required TextEditingController controller,
  required double height,
  double horizontalPadding = 0,
  required OnChanged onChanged,
  TextAlign textAlign = TextAlign.start,
  bool readOnly = true,
  double? width,
  bool isBorder = false,
}) {
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.transparent));
  final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.black.withOpacity(0.06)));
  return SizedBox(
    height: height,
    width: width ?? context.getSize.width,
    child: TextFormField(
      readOnly: readOnly,
      onChanged: onChanged,
      style: textStyle(
        context: context,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        textColor: AppColor.littleBlackColor,
        fontFamily: "Roboto",
      ),
      textAlign: textAlign,
      controller: controller,
      decoration: InputDecoration(
        hintStyle: textStyle(
          context: context,
          fontSize: 16,
          textColor: AppColor.littleBlackColor,
          fontWeight: FontWeight.w400,
          fontFamily: "Roboto",
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        hintText: hintText,
        border: border,
        errorBorder: isBorder == false ? border : outlineBorder,
        enabledBorder: isBorder == false ? border : outlineBorder,
        focusedBorder: isBorder == false ? border : outlineBorder,
        disabledBorder: isBorder == false ? border : outlineBorder,
        focusedErrorBorder: isBorder == false ? border : outlineBorder,
        filled: true,
        fillColor: AppColor.whiteColor,
      ),
    ),
  );
}

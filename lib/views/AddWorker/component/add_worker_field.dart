import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/app_color.dart';

typedef OnChanged = Function(String);
typedef OnTap = Function();
addWorkerTextField({
  required BuildContext context,
  required String hintText,
  required TextEditingController controller,
  double? height,
  TextInputAction textInputAction = TextInputAction.next,
  Color? color,
  OnTap? onTap,
  TextInputType textInputType = TextInputType.text,
  bool readOnly = false,
  bool isDecimal = false,
  int? maxLines,
  List<TextInputFormatter>? formatter,
  OnChanged? onChanged,
}) {
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.transparent));
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    decoration: BoxDecoration(
        color: color ?? AppColor.whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.black.withOpacity(0.06),
          width: 1,
        )),
    height: height,
    child: TextFormField(
      
       inputFormatters:formatter,
      maxLines: maxLines ?? 1,
      textInputAction: textInputAction,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: textInputType,
      onChanged: onChanged,
      style: textStyle(
        context: context,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: "Roboto",
      ),
      controller: controller,
      decoration: InputDecoration(
        hintStyle: textStyle(
          context: context,
          fontSize: 14,
          textColor: AppColor.lightPurpleColor.withOpacity(0.67),
          fontWeight: FontWeight.w400,
          fontFamily: "Roboto",
        ),
        contentPadding: const EdgeInsets.all(0),
        hintText: hintText,
        border: border,
        errorBorder: border,
        enabledBorder: border,
        focusedBorder: border,
        disabledBorder: border,
        focusedErrorBorder: border,
        // filled: true,
        // fillColor: color ?? AppColor.whiteColor,
      ),
    ),
  );
}

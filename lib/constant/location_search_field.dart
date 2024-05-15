import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/app_color.dart';

typedef OnChanged = Function(String);
typedef Cancel = Function();
locationSearchField({
  required BuildContext context,
  required String hintText,
  required TextEditingController controller,
  required double height,
  required OnChanged onChanged,
  required Cancel cancel,
}) {
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.transparent));
  return SizedBox(
    height: height,
    child: TextFormField(
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
          textColor: AppColor.lightPurpleColor.withOpacity(0.67),
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: "Roboto",
        ),
        suffixIcon:
            GestureDetector(onTap: cancel, child: const Icon(Icons.close)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        hintText: hintText,
        border: border,
        errorBorder: border,
        enabledBorder: border,
        focusedBorder: border,
        disabledBorder: border,
        focusedErrorBorder: border,
        filled: true,
        fillColor: AppColor.whiteColor,
      ),
    ),
  );
}

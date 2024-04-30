import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/utils/app_color.dart';

typedef OnChanged = Function(String);
homeSearchField({
  required BuildContext context,
  required String hintText,
  required TextEditingController controller,
  required double height,
  required OnChanged onChanged,
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
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: "Roboto",
        ),
        prefixIcon: const Icon(Icons.search),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10,),
        hintText: hintText,
        border: border,
        errorBorder: border,
        enabledBorder: border,
        focusedBorder: border,
        disabledBorder: border,
        focusedErrorBorder: border,
        filled: true,
        fillColor: AppColor.purpleColor.withOpacity(0.08),
      ),
    ),
  );
}

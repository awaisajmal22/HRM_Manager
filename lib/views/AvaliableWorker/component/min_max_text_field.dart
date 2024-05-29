import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:ionicons/ionicons.dart';

typedef OnChanged = Function(String);
typedef OpenFilter = Function();
minMaxTextField({
  required BuildContext context,
  required String hintText,
  required TextEditingController controller,
  required OnChanged onChanged,
}) {
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(3),
      borderSide: const BorderSide(color: Colors.transparent));
  return SizedBox(
    height: context.getSize.height * 0.048,
    width: context.getSize.width * 0.180,
    child: TextFormField(
      inputFormatters: [FilteringTextInputFormatter.digitsOnly,
],
      readOnly: false,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      style: textStyle(
        context: context,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: "Roboto",
      ),
      controller: controller,
      decoration: InputDecoration(
        hintStyle: textStyle(
          context: context,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: "Roboto",
        ),
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

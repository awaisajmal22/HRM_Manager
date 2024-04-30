import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/utils/app_color.dart';
import 'package:ionicons/ionicons.dart';

typedef OnChanged = Function(String);
typedef OpenFilter = Function();
filterSearchField({
  required BuildContext context,
  required bool isOpenFilter,
  required String hintText,
  required TextEditingController controller,
  required double height,
  required OnChanged onChanged,
  required OpenFilter openFilter,
}) {
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.transparent));
  return SizedBox(
    height: height,
    child: TextFormField(
      readOnly: true,
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
        suffixIcon: GestureDetector(
          onTap: openFilter,
          child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isOpenFilter == true ? Color(0xffE7E0EC) : null),
              child: Icon(
                Ionicons.filter_outline,
                size: context.getSize.height * 0.024,
              )),
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

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/width_box.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/utils/app_color.dart';

customTextField(

    {bool isSufixIcon = false,
   required TextEditingController controller,
    bool isObsecureText = false,
      required BuildContext context, required String hintText, GestureDetector? saufixIcon}) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              obscureText: isObsecureText,
              style: textStyle(
                  context: context,
                  textColor: AppColor.lightPurpleColor.withOpacity(0.67)),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: textStyle(
                    context: context,
                    textColor: AppColor.lightPurpleColor.withOpacity(0.67)),
                contentPadding: const EdgeInsets.all(0),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
         isSufixIcon == false ? const SizedBox.shrink() :  getWidth(context: context, width: 0.030,),
          isSufixIcon == false ? SizedBox.fromSize(): saufixIcon!,
        ],
      ),
      getWidth(context: context, width: 0.010),
      Container(
        height: 1,
        width: context.getSize.width,
        color: AppColor.grayColor,
      )
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/height_box.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/constant/app_color.dart';
typedef OnTap = VoidCallback;
displayFile({required String title,required String path, required BuildContext context,required OnTap onTap}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
       appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title:title,
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: context.getSize.width,
          height: context.getSize.height * 0.050,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.black.withOpacity(0.06),
                width: 1,
              )),
          child: appText(
            context: context,
            title: path,
            textAlign: TextAlign.left,
          ),
        ),
      ),
    ],
  );
}

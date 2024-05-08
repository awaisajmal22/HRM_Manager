import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/back.dart';
import 'package:hrm_manager/constant/height_box.dart';
import 'package:hrm_manager/constant/text_button.dart';
import 'package:hrm_manager/constant/toast.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/profile_provider.dart';
import 'package:hrm_manager/views/Profile/component/profile_text_field.dart';
import 'package:provider/provider.dart';

showChangePassDialog({
  required BuildContext context,
}) {
  return showGeneralDialog(
    context: context,
    pageBuilder: ((context, animation, secondaryAnimation) =>
        const SizedBox.shrink()),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return Dialog(
        insetPadding: const EdgeInsets.all(0),
        child: Consumer<ProfileProvider>(builder: (context, provider, __) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.getSize.width * 0.040,
              vertical: context.getSize.height * 0.020,
            ),
            width: context.getSize.width,
            height: context.getSize.height * 0.5,
            decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    back(context: context);
                  },
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.close),
                  ),
                ),
                getHeight(context: context, height: 0.020),
                appText(
                  context: context,
                  title: 'Current Password',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textColor: AppColor.lightPurpleColor,
                ),
                getHeight(context: context, height: 0.005),
                profileTextField(
                  readOnly: false,
                  context: context,
                  horizontalPadding: 10,
                  hintText: '',
                  controller: provider.currentPassController,
                  height: context.getSize.height * 0.048,
                  onChanged: (val) {},
                  isBorder: true,
                ),
                getHeight(context: context, height: 0.010),
                appText(
                  context: context,
                  title: 'New Password',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textColor: AppColor.lightPurpleColor,
                ),
                getHeight(context: context, height: 0.005),
                profileTextField(
                  readOnly: false,
                  context: context,
                  horizontalPadding: 10,
                  hintText: '',
                  controller: provider.newPassController,
                  height: context.getSize.height * 0.048,
                  onChanged: (val) {},
                  isBorder: true,
                ),
                getHeight(context: context, height: 0.010),
                appText(
                  context: context,
                  title: 'Confirm Password',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textColor: AppColor.lightPurpleColor,
                ),
                getHeight(context: context, height: 0.005),
                profileTextField(
                  readOnly: false,
                  context: context,
                  horizontalPadding: 10,
                  hintText: '',
                  controller: provider.confirmPassController,
                  height: context.getSize.height * 0.048,
                  onChanged: (val) {},
                  isBorder: true,
                ),
                getHeight(context: context, height: 0.080),
                Align(
                  alignment: Alignment.center,
                  child: provider.isSuccess == false
                      ? SizedBox(
                          height: context.getSize.height * 0.05,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColor.lightPurpleColor,
                            ),
                          ),
                        )
                      : textButton(
                          radius: 100,
                          width: context.getSize.width * 0.3,
                          context: context,
                          onTap: () {
                            if (provider.currentPassController.text.isEmpty) {
                              toast(
                                  msg: 'Current password field is empty.',
                                  context: context);
                            }
                            if (provider.newPassController.text.length < 5) {
                              toast(
                                  msg:
                                      'Current password length must be greater than 5.',
                                  context: context);
                            }
                            if (provider.newPassController.text !=
                                provider.confirmPassController.text) {
                              toast(
                                  msg:
                                      'Your new password and confirm password not match',
                                  context: context);
                            } else {
                              provider.changePass(
                                  context: context,
                                  currentPass:
                                      provider.currentPassController.text,
                                  newPass: provider.newPassController.text);
                            }
                          },
                          title: 'Change',
                        ),
                ),
              ],
            ),
          );
        }),
      );
    },
  );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/back.dart';
import 'package:hrm_manager/constant/constant.dart';
import 'package:hrm_manager/constant/height_box.dart';
import 'package:hrm_manager/constant/text_button.dart';
import 'package:hrm_manager/constant/text_field.dart';
import 'package:hrm_manager/constant/toast.dart';
import 'package:hrm_manager/constant/width_box.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/forget_password_provider.dart';
import 'package:provider/provider.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgetPasswordProvider>(builder: (context, provider, __) {
      return Scaffold(
          body: SafeArea(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: context.getSize.width * 0.030,
                vertical: context.getSize.height * 0.016),
            // decoration:
            //     BoxDecoration(color: AppColor.purpleColor.withOpacity(0.08)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    back(context: context);
                  },
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    color: AppColor.iconColor,
                    size: context.getSize.height * 0.045,
                  ),
                ),
                getWidth(context: context, width: 0.010),
                appText(
                  context: context,
                  title: '',
                  fontSize: 18,
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.getSize.width * 0.060,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Constant.appLogo,
                  width: 81,
                  height: 81,
                ),
                getHeight(context: context, height: 0.02),
                appText(
                  context: context,
                  title: "Forget Password",
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
                getHeight(context: context, height: 0.02),
                Align(
                  alignment: Alignment.centerLeft,
                  child: appText(
                    context: context,
                    title: 'Email',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                getHeight(context: context, height: 0.005),
                customTextField(
                    isBorder: false,
                    controller: provider.emailController,
                    context: context,
                    hintText: 'Email'),
                getHeight(context: context, height: 0.050),
                provider.isSuccess == false
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.purpleColor,
                        ),
                      )
                    : textButton(
                        context: context,
                        onTap: () {
                          if (provider.emailController.text.isEmpty) {
                            toast(
                                msg: 'Please enter your email',
                                context: context);
                          } else if (!Constant.regExp
                              .hasMatch(provider.emailController.text)) {
                            toast(
                                msg: 'Please enter valid email',
                                context: context);
                          } else {
                            provider.postForgetPassword(
                                context: context,
                                email: provider.emailController.text);
                          }
                        },
                        title: "Submit",
                      ),
              ],
            ),
          ),
          getHeight(context: context, height: 0.15),
          const Spacer(),
        ],
      )));
    });
  }
}

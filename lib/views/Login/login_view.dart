import 'package:flutter/material.dart';
import 'package:hrm_manager/WidgetandBindings/app_routes.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/constant.dart';
import 'package:hrm_manager/constant/height_box.dart';
import 'package:hrm_manager/constant/text_button.dart';
import 'package:hrm_manager/constant/text_field.dart';
import 'package:hrm_manager/constant/toast.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/login_provider.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isOutLoginCheck = false;
  @override
  void initState() {
    if (_isOutLoginCheck == false) {
      Provider.of<LoginProvider>(
        context,
        listen: false,
      ).autoLogin(context: context).whenComplete(() => setState(() {
            _isOutLoginCheck = true;
          }));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<LoginProvider>(
    //   context,
    // );
    return Scaffold(
        body: Consumer<LoginProvider>(builder: (context, provider, __) {
      return SafeArea(
        child: Column(
          children: [
            // Container(
            //   padding: EdgeInsets.symmetric(
            //       horizontal: context.getSize.width * 0.030,
            //       vertical: context.getSize.height * 0.016),
            //   // decoration:
            //   //     BoxDecoration(color: AppColor.purpleColor.withOpacity(0.08)),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       appText(
            //         context: context,
            //         title: 'Login',
            //         fontSize: 18,
            //       ),
            //     ],
            //   ),
            // ),
            // getHeight(context: context, height: 0.1),
            const Spacer(),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.getSize.width * 0.060,
              ),
              child: Column(
                children: [
                  Image.asset(
                    Constant.appLogo,
                    width: 81,
                    height: 81,
                  ),
                  getHeight(context: context, height: 0.02),
                  appText(
                    context: context,
                    title: "Login",
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
                      hintText: 'Enter email'),
                  getHeight(context: context, height: 0.020),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: appText(
                      context: context,
                      title: 'Password',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  getHeight(context: context, height: 0.005),
                  customTextField(
                      isBorder: false,
                      textInputAction: TextInputAction.done,
                      controller: provider.passwordController,
                      context: context,
                      isObsecureText: provider.isObsecureText,
                      hintText: 'Enter password',
                      isSufixIcon: true,
                      saufixIcon: GestureDetector(
                        onTap: () {
                          provider.showPasword(!provider.isObsecureText);
                        },
                        child: Icon(
                          provider.isObsecureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(0xff49454F).withOpacity(0.67),
                        ),
                      )),
                  getHeight(context: context, height: 0.050),
                  textButton(
                    vPadding: 0.015,
                    context: context,
                    onTap: () {
                      if (provider.emailController.text.isEmpty) {
                        toast(msg: 'Please enter your email', context: context);
                      } else if (!provider.regExp
                          .hasMatch(provider.emailController.text)) {
                        toast(
                            msg: 'Please enter valid email', context: context);
                      } else if (provider.passwordController.text.isEmpty) {
                        toast(
                            msg: 'Please enter your password',
                            context: context);
                      } else if (provider.passwordController.text.length < 6) {
                        toast(
                            msg: 'Password must be greate than 6 characters',
                            context: context);
                      } else {
                        provider.userLoginFunc(
                            context: context,
                            email: provider.emailController.text,
                            password: provider.passwordController.text);
                      }
                    },
                    title: 'Login',
                  ),
                  getHeight(context: context, height: 0.04),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.forgetPasswordView);
                    },
                    child: appText(
                      context: context,
                      title: 'Forget Password?',
                      textColor: AppColor.grayColor,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      );
    }));
  }
}

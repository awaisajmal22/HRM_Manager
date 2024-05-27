import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/Model/profile_model.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/back.dart';
import 'package:hrm_manager/constant/constant.dart';
import 'package:hrm_manager/constant/divider.dart';
import 'package:hrm_manager/constant/height_box.dart';
import 'package:hrm_manager/constant/text_button.dart';
import 'package:hrm_manager/constant/width_box.dart';
import 'package:hrm_manager/extensions/nullable_string_extension.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:hrm_manager/provider/nav_bar_provider.dart';
import 'package:hrm_manager/provider/profile_provider.dart';
import 'package:hrm_manager/views/Profile/component/change_password_dialog.dart';
import 'package:hrm_manager/views/Profile/component/profile_text_field.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../WidgetandBindings/app_routes.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isSuccess = false;
  @override
  void initState() {
    _loadData();
    super.initState();
  }

  _loadData() async {
    final pv = Provider.of<ProfileProvider>(context, listen: false);
    if (isSuccess == false) {
      final data = await pv.getProfile(context: context);
      pv.getManagerProfileImage(context: context);
      if (data != null) {
        setState(() {
          isSuccess = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, provider, __) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: context.getSize.width * 0.040,
                vertical: context.getSize.height * 0.020),
            // color: const Color(0xffE7E0EC),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        final pv =
                            Provider.of<NavBarProvider>(context, listen: false);
                        pv.selectedIndex = 0;
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
                      title: 'Profile',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      textColor: AppColor.iconColor,
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.clear().whenComplete(() =>
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.loginView));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: context.getSize.width * 0.040,
                        vertical: context.getSize.height * 0.010),
                    child: appText(
                      context: context,
                      title: "Log out",
                      fontWeight: FontWeight.w500,
                      textColor: AppColor.purpleColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView(
            padding:
                EdgeInsets.symmetric(horizontal: context.getSize.width * 0.040),
            shrinkWrap: true,
            children: [
              getHeight(context: context, height: 0.030),
              Center(
                child: SizedBox(
                  height: context.getSize.height * 0.1,
                  width: context.getSize.width * 0.2,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        height: context.getSize.height * 0.1,
                        width: context.getSize.width * 0.2,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: provider.image != ''
                                ? DecorationImage(
                                    image: FileImage(File(provider.image)),
                                    fit: BoxFit.cover)
                                : const DecorationImage(
                                    image: AssetImage(Constant.dummyImage),
                                    fit: BoxFit.cover,
                                  )),
                      ),
                      Positioned(
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            provider.pickImage();
                          },
                          child: Container(
                            height: context.getSize.height * 0.04,
                            width: context.getSize.width * 0.08,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.lightPinkColor,
                            ),
                            child: Icon(
                              Ionicons.create_outline,
                              size: context.getSize.height * 0.020,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              getHeight(context: context, height: 0.010),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  profileTextField(
                    textAlign: TextAlign.center,
                    width: context.getSize.width * 0.4,
                    context: context,
                    hintText: '',
                    readOnly: provider.isWriteName,
                    controller: provider.nameController
                      ..text = provider.profileModel.data == null
                          ? ''
                          : "${provider.profileModel.data!.firstName.toString().isNotNullableString()} ${provider.profileModel.data!.lastName.toString().isNotNullableString()}",
                    height: context.getSize.height * 0.048,
                    onChanged: (val) {},
                  ),
                  // getWidth(
                  //   context: context,
                  //   width: 0.01,
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     provider.isWriteName = !provider.isWriteName;
                  //   },
                  //   child: Icon(provider.isWriteName == false
                  //       ? Icons.close
                  //       : Icons.edit_outlined),
                  // )
                ],
              ),
              getHeight(context: context, height: 0.030),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: profileTextField(
                    context: context,
                    hintText: '',
                    readOnly: provider.isWriteEmail,
                    controller: provider.emailController
                      ..text = provider.profileModel.data == null
                          ? ''
                          : "${provider.profileModel.data!.email}",
                    height: context.getSize.height * 0.048,
                    onChanged: (val) {},
                  )),
                  // getWidth(
                  //   context: context,
                  //   width: 0.01,
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     provider.isWriteEmail = !provider.isWriteEmail;
                  //   },
                  //   child: Icon(provider.isWriteEmail == false
                  //       ? Icons.close
                  //       : Icons.edit_outlined),
                  // )
                ],
              ),
              divider(color: AppColor.purpleColor.withOpacity(0.08)),
              getHeight(context: context, height: 0.010),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: profileTextField(
                    context: context,
                    hintText: '',
                    readOnly: provider.isWritePhone,
                    controller: provider.phoneController
                      ..text = provider.profileModel.data == null
                          ? ''
                          : '${provider.profileModel.data!.phoneNumber}',
                    height: context.getSize.height * 0.048,
                    onChanged: (val) {},
                  )),
                  // getWidth(
                  //   context: context,
                  //   width: 0.01,
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     provider.isWritePhone = !provider.isWritePhone;
                  //   },
                  //   child: Icon(provider.isWritePhone == false
                  //       ? Icons.close
                  //       : Icons.edit_outlined),
                  // )
                ],
              ),
              divider(color: AppColor.purpleColor.withOpacity(0.08)),
              getHeight(context: context, height: 0.010),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: profileTextField(
                    context: context,
                    hintText: '',
                    readOnly: true,
                    controller: provider.changePassController
                      ..text = 'Change Password',
                    height: context.getSize.height * 0.048,
                    onChanged: (val) {},
                  )),
                  getWidth(
                    context: context,
                    width: 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      showChangePassDialog(
                        context: context,
                      );
                    },
                    child: const Icon(Icons.edit_outlined),
                  )
                ],
              ),
              divider(color: AppColor.purpleColor.withOpacity(0.08)),
            ],
          )),
          SizedBox(
            height: context.getSize.height * 0.08,
            width: context.getSize.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                provider.isProfileImageUpdate == false
                    ? CircularProgressIndicator(
                        color: AppColor.lightPurpleColor,
                      )
                    : textButton(
                        radius: 100,
                        width: context.getSize.width * 0.3,
                        vPadding: 0.02,
                        context: context,
                        onTap: () {
                          provider.changeManagerProfile(
                              context: context, profileImage: provider.image);
                        },
                        title: 'Update',
                      )
              ],
            ),
          )
        ],
      );
    });
  }
}

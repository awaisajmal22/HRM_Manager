
  import 'package:flutter/material.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/width_box.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/utils/app_color.dart';
typedef OnTap = Function(int);
Widget checkWidget({required OnTap onTap, required BuildContext context,required int selectedIndex}) {
    return Row(
                          children: List.generate(
                              2,
                              (index) => Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: GestureDetector(
                                      onTap: (){
                                        onTap(index);
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: AppColor.purpleColor,
                                                  width: 1,
                                                )),
                                            child: Container(
                                              height: context.getSize.height *
                                                  0.012,
                                              width: context.getSize.width *
                                                  0.024,
                                              decoration: BoxDecoration(
                                                  color: selectedIndex == index ? AppColor.purpleColor : null,
                                                  shape: BoxShape.circle),
                                            ),
                                          ),
                                          getWidth(
                                              context: context, width: 0.020),
                                          appText(
                                              context: context,
                                              title:
                                                  index == 0 ? 'Yes' : "No",
                                              textColor:
                                                  AppColor.lightPurpleColor)
                                        ],
                                      ),
                                    ),
                                  )),
                        );
  }
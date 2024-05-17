import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/constant.dart';
import 'package:hrm_manager/constant/divider.dart';
import 'package:hrm_manager/constant/height_box.dart';
import 'package:hrm_manager/constant/width_box.dart';
import 'package:hrm_manager/extensions/nullable_string_extension.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:shimmer/shimmer.dart';

class WorkerWidget extends StatelessWidget {
  final String imageUrl;
  final String status;
  final String dateOfBirth;
  final bool isShimmer;
  final String name;
  final String price;
  final String trade;
  const WorkerWidget({
    super.key,
    this.isShimmer = false,
    this.dateOfBirth = '1979, Dec 2',
    this.name = 'Jovany Italiano',
    this.imageUrl = '',
    this.price = '\$47.00/hr',
    this.trade = 'Carpenter',
    this.status = 'Now on site',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color:
            isShimmer == true ? AppColor.whiteColor : const Color(0xffE7E0EC),
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
              color: AppColor.lightPinkColor,
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 1))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isShimmer == true
              ? _imageShimmer(context: context)
              : Container(
                  // margin: EdgeInsets.symmetric(
                  //   //   horizontal: context.getSize.width * 0.045,
                  //   // vertical: context.getSize.height * 0.010,
                  // ),
                  height: context.getSize.height * 0.08,
                  width: context.getSize.width * 0.12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: imageUrl == ''
                          ? const DecorationImage(
                              image: AssetImage(Constant.dummyImage),
                              fit: BoxFit.cover)
                          : DecorationImage(
                              image: FileImage(File(imageUrl)),
                              fit: BoxFit.cover,
                            )),
                ),
          getWidth(context: context, width: 0.020),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isShimmer == true
                    ? _rowShimmer(context: context)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: context.getSize.width * 0.5,
                            child: appText(
                              textAlign: TextAlign.start,
                              context: context,
                              title: name,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: context.getSize.width * 0.2,
                            child: appText(
                                textAlign: TextAlign.end,
                                context: context,
                                title: price.toString().isNotNullableString(),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                textColor: AppColor.lightPurpleColor),
                          )
                        ],
                      ),
      isShimmer == true ?const  SizedBox.shrink() :          divider(color: AppColor.lightPurpleColor.withOpacity(0.2)),
                isShimmer == true
                    ? _rowShimmer(context: context)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: context.getSize.width * 0.2,
                            child: appText(
                              textAlign: TextAlign.start,
                              context: context,
                              title: 'Trade',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              textColor: AppColor.lightPurpleColor,
                            ),
                          ),
                          SizedBox(
                            width: context.getSize.width * 0.5,
                            child: appText(
                                textAlign: TextAlign.end,
                                context: context,
                                title: trade,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                textColor: AppColor.lightPurpleColor),
                          )
                        ],
                      ),
       isShimmer == true ? const  SizedBox.shrink() :             divider(color: AppColor.lightPurpleColor.withOpacity(0.2)),
                isShimmer == true
                    ? _rowShimmer(context: context)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: context.getSize.width * 0.2,
                            child: appText(
                              textAlign: TextAlign.start,
                              context: context,
                              title: 'Status',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              textColor: AppColor.lightPurpleColor,
                            ),
                          ),
                          SizedBox(
                            width: context.getSize.width * 0.5,
                            child: appText(
                                textAlign: TextAlign.end,
                                context: context,
                                title: status,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                textColor: AppColor.lightPurpleColor),
                          )
                        ],
                      ),
      isShimmer == true ? const  SizedBox.shrink() :              divider(color: AppColor.lightPurpleColor.withOpacity(0.2)),
                isShimmer == true
                    ? _rowShimmer(context: context)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: context.getSize.width * 0.2,
                            child: appText(
                              textAlign: TextAlign.start,
                              context: context,
                              title: 'DOB',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              textColor: AppColor.lightPurpleColor,
                            ),
                          ),
                          SizedBox(
                            width: context.getSize.width * 0.5,
                            child: appText(
                                textAlign: TextAlign.end,
                                context: context,
                                title: dateOfBirth,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                textColor: AppColor.lightPurpleColor),
                          )
                        ],
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _imageShimmer({required BuildContext context}) {
    return Shimmer.fromColors(
      child: Container(
        height: context.getSize.height * 0.14,
        width: context.getSize.width * 0.22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.whiteColor,
        ),
      ),
      baseColor: AppColor.purpleColor.withOpacity(0.1),
      highlightColor: AppColor.lightPinkColor,
    );
  }

  _rowShimmer({required BuildContext context, bool isLeft = true}) {
    return Column(
      children: [
        Shimmer.fromColors(
          child: Container(
            width: context.getSize.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColor.whiteColor,
            ),
            child: appText(context: context, title: '', fontSize: 16),
          ),
          baseColor: AppColor.purpleColor.withOpacity(0.1),
          highlightColor: AppColor.lightPinkColor,
        ),
        getHeight(context: context, height: 0.01),
      ],
    );
  }
}

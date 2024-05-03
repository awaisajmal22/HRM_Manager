import 'package:flutter/material.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/constant.dart';
import 'package:hrm_manager/constant/width_box.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/constant/app_color.dart';

class WorkerWidget extends StatelessWidget {
  final String imageUrl;
  final String status;
  final String dateOfBirth;

  final String name;
  final String price;
  final String trade;
  const  WorkerWidget({
    super.key,
    this.dateOfBirth = '1979, Dec 2',
    this.name = 'Jovany Italiano',
    this.imageUrl = Constant.dummyImage,
    this.price = '\$47.00/hr',
    this.trade = 'Carpenter',
    this.status = 'Now on site',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            //   horizontal: context.getSize.width * 0.045,
            vertical: context.getSize.height * 0.010,
          ),
          height: context.getSize.height * 0.12,
          width: context.getSize.width * 0.166,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              )),
        ),
        getWidth(context: context, width: 0.020),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
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
                      title: price,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      textColor: AppColor.lightPurpleColor),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: context.getSize.width * 0.5,
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
                  width: context.getSize.width * 0.2,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: context.getSize.width * 0.5,
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
                  width: context.getSize.width * 0.2,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: context.getSize.width * 0.5,
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
                  width: context.getSize.width * 0.2,
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
        )
      ],
    );
  }
}

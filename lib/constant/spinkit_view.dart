import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:hrm_manager/constant/app_text.dart';


void showLoadingIndicator(
    {required BuildContext context, bool isDark = false}) {
  showDialog(
    barrierDismissible: false,
    useRootNavigator: false,
    context: context,
    builder: (BuildContext context) {
      return  Padding(
        padding: EdgeInsets.all(0),
        child: Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: SizedBox(
            child: SpinKitCircle(
                        itemBuilder: (BuildContext context, int index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
          ),
        ),
      );
    },
  );
}

void showLoadingMessage(
    {required BuildContext context,
    bool isDark = false,
    required String message}) {
  showDialog(
    barrierDismissible: false,
    useRootNavigator: false,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Dialog(
          insetPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
              height: 50,
              padding: const EdgeInsets.all(15),
              color: isDark ? AppColor.blackColor : Colors.white,
              // width: 50,
              child: FittedBox(
                child: appText(
                  context: context,
                    title: message,
                    textColor: AppColor.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              )),
        ),
      );
    },
  );
}

void hideOpenDialog({
  required BuildContext context,
}) {
  Navigator.of(context).pop();
}

Widget spinKitButton(
    BuildContext context, double height, double width, Color color) {
  return Container(
    height: height,
    width: width,
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: color),
    child: const Center(
      child:
          // SpinKitFadingCircle(
          SpinKitSpinningLines(
        // SpinKitRipple(
        // SpinKitThreeBounce(
        // child: SpinKitFadingCircle(
        size: 25,
        color: Colors.white,
      ),
    ),
  );
}
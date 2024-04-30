import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/WidgetandBindings/app_routes.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/back.dart';
import 'package:hrm_manager/constant/constant.dart';
import 'package:hrm_manager/constant/height_box.dart';
import 'package:hrm_manager/constant/rich_text.dart';
import 'package:hrm_manager/constant/text_button.dart';
import 'package:hrm_manager/constant/width_box.dart';
import 'package:hrm_manager/constant/worker_widget.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/wroker_profile_provider.dart';
import 'package:hrm_manager/utils/app_color.dart';
import 'package:provider/provider.dart';

class WorkerProfileView extends StatelessWidget {
  const WorkerProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WorkerProfileProvider>(builder: (context, provider, __) {
        return SafeArea(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: context.getSize.width * 0.040,
                  vertical: context.getSize.height * 0.020),
              color: const Color(0xffE7E0EC),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                        title: 'Worker Profile',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        textColor: AppColor.iconColor,
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.editWorkerDetailView);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: context.getSize.width * 0.040,
                          vertical: context.getSize.height * 0.010),
                      decoration: BoxDecoration(
                          color: AppColor.purpleColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: appText(
                        context: context,
                        title: "Edit",
                        fontWeight: FontWeight.w500,
                        textColor: AppColor.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView(
              padding: EdgeInsets.symmetric(
                vertical: context.getSize.height * 0.020,
                horizontal: context.getSize.width * 0.040,
              ),
              shrinkWrap: true,
              children: [
                WorkerWidget(),
                getHeight(context: context, height: 0.01),
                richText(
                  context: context,
                  title: 'Experience: ',
                  subtitle:
                      '6 Years of high rise, 5 commercial, 2 years drywall',
                ),
                getHeight(context: context, height: 0.01),
                richText(
                  context: context,
                  title: 'Previous Employment: ',
                  subtitle: 'MCF, Structform, \nSupplier',
                ),
                getHeight(context: context, height: 0.01),
                richText(
                  context: context,
                  title: 'Union Affiliation: ',
                  subtitle: '183, Local 27',
                ),
                getHeight(context: context, height: 0.01),
                richText(
                  context: context,
                  title: 'Flag: ',
                  subtitle: 'No papers',
                ),
                getHeight(context: context, height: 0.01),
                richText(
                  context: context,
                  title: 'Transportation: ',
                  subtitle: 'Yes',
                ),
                getHeight(context: context, height: 0.01),
                richText(
                  context: context,
                  title: 'Home: ',
                  subtitle: 'Toronto (King & Young)',
                ),
                getHeight(context: context, height: 0.01),
                richText(
                  context: context,
                  title: 'Certificates: ',
                  subtitle: '',
                ),
                getHeight(context: context, height: 0.01),
                richText(
                  context: context,
                  title: 'Special Tickets: ',
                  subtitle: 'No',
                ),
                getHeight(context: context, height: 0.01),
                richText(
                  context: context,
                  title: 'Note: ',
                  subtitle: '',
                ),
                getHeight(context: context, height: 0.020),
                Align(
                  alignment: Alignment.centerLeft,
                  child: appText(
                    context: context,
                    title: 'Your documents',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                getHeight(context: context, height: 0.010),
                Wrap(
                  runAlignment: WrapAlignment.center,
                  alignment: WrapAlignment.center,
                  children: List.generate(
                      provider.documentList.length,
                      (index) => GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.pdfView,
                                  arguments: [
                                    provider.documentList[index],
                                    Constant.pdfFile,
                                  ]);
                            },
                            child: SizedBox(
                              width: context.getSize.width * 0.22,
                              child: Column(
                                children: [
                                  Image.asset(
                                    Constant.pdfIcon,
                                    width: context.getSize.width * 0.086,
                                    height: context.getSize.height * 0.048,
                                  ),
                                  appText(
                                    context: context,
                                    title: provider.documentList[index],
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ),
                          )),
                ),
                getHeight(context: context, height: 0.030),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.getSize.width * 0.30),
                  child: textButton(
                    radius: 100,
                    context: context,
                    onTap: () {},
                    title: 'Export CSV',
                  ),
                )
              ],
            )
          ],
        ));
      }),
    );
  }
}

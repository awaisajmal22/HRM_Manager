import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/Network/api_url.dart';
import 'package:hrm_manager/WidgetandBindings/app_routes.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/back.dart';
import 'package:hrm_manager/constant/constant.dart';
import 'package:hrm_manager/constant/height_box.dart';
import 'package:hrm_manager/constant/rich_text.dart';
import 'package:hrm_manager/constant/text_button.dart';
import 'package:hrm_manager/constant/width_box.dart';
import 'package:hrm_manager/constant/worker_widget.dart';
import 'package:hrm_manager/extensions/date_of_birth_format.dart';
import 'package:hrm_manager/extensions/nullable_string_extension.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/wroker_profile_provider.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:provider/provider.dart';

class WorkerProfileView extends StatefulWidget {
  final int id;
  WorkerProfileView({super.key, required this.id});

  @override
  State<WorkerProfileView> createState() => _WorkerProfileViewState();
}

class _WorkerProfileViewState extends State<WorkerProfileView> {
  bool _isLoaded = false;
  @override
  void initState() {
    if (_isLoaded == false) {
      _load();
    }
    super.initState();
  }

  _load() {
    final pv = Provider.of<WorkerProfileProvider>(context, listen: false);
    print("Worker ID is ${widget.id}");
    pv.getWorkerData(context: context, id: widget.id);
    pv.getFileData(
        api: "${ApiUrl.getProfileImage}/${widget.id}", context: context);
    pv.getFileData(
        api: "${ApiUrl.getProfileImage}/${widget.id}", context: context);
    print(pv.workerByIdModel.firstName);
    setState(() {
      _isLoaded = true;
    });
  }

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
                          context, AppRoutes.editWorkerDetailView,
                          arguments: provider.workerByIdModel);
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
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  vertical: context.getSize.height * 0.020,
                  horizontal: context.getSize.width * 0.040,
                ),
                shrinkWrap: true,
                children: [
                  WorkerWidget(
                    name:
                        "${provider.workerByIdModel.firstName.toString().isNotNullableString()} ${provider.workerByIdModel.lastName.toString().isNotNullableString()}",
                    //  provider.workerProfileModel.name!,
                    status: provider.workerByIdModel.workerStatus
                        .toString()
                        .isNotNullableString(),
                    // provider.workerProfileModel.status!,
                    dateOfBirth: dateFormater(
                        provider.workerByIdModel.dateofBirth.toString() ?? ''),
                    // provider.workerProfileModel.dob!,
                    price:
                        "\$${provider.workerByIdModel.regularRate.toString().isNotNullableString()}/hr",
                    // provider.workerProfileModel.price!,
                    trade: provider.workerByIdModel.trade
                        .toString()
                        .isNotNullableString(),
                    // provider.workerProfileModel.trade!,
                  ),
                  getHeight(context: context, height: 0.01),
                  richText(
                    context: context,
                    title: 'Experience: ',
                    subtitle: provider.workerByIdModel.workExperience
                        .toString()
                        .isNotNullableString(),
                    // provider.workerProfileModel.experience!,
                  ),
                  getHeight(context: context, height: 0.01),
                  richText(
                    context: context,
                    title: 'Previous Employment: ',
                    subtitle: provider.workerProfileModel.previousEmployment!,
                  ),
                  getHeight(context: context, height: 0.01),
                  richText(
                    context: context,
                    title: 'Union Affiliation: ',
                    subtitle: provider.workerProfileModel.unionAffiliation!,
                  ),
                  getHeight(context: context, height: 0.01),
                  richText(
                    context: context,
                    title: 'Flag: ',
                    subtitle: provider.workerProfileModel.flag!,
                  ),
                  getHeight(context: context, height: 0.01),
                  richText(
                      context: context,
                      title: 'Transportation: ',
                      subtitle: provider.workerByIdModel.ownTransportation
                              .toString() ??
                          "false"
                      // provider.workerProfileModel.transportation!,
                      ),
                  getHeight(context: context, height: 0.01),
                  richText(
                      context: context,
                      title: 'Home: ',
                      subtitle: provider.workerByIdModel.address1
                          .toString()
                          .isNotNullableString()
                      //  provider.workerProfileModel.home!,
                      ),
                  getHeight(context: context, height: 0.01),
                  richText(
                      context: context,
                      title: 'Certificates: ',
                      subtitle: provider.workerByIdModel.certificationsNotes
                          .toString()
                          .isNotNullableString()
                      // provider.workerProfileModel.certificate!,
                      ),
                  getHeight(context: context, height: 0.01),
                  richText(
                    context: context,
                    title: 'Special Tickets: ',
                    subtitle: provider.workerProfileModel.specialTickets!,
                  ),
                  getHeight(context: context, height: 0.01),
                  richText(
                    context: context,
                    title: 'Note: ',
                    subtitle: provider.workerByIdModel.notes
                        .toString()
                        .isNotNullableString(),
                    // provider.workerProfileModel.note!,
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
                      onTap: () {
                        provider.generateCsvFile(context: context);
                      },
                      title: 'Export CSV',
                    ),
                  )
                ],
              ),
            )
          ],
        ));
      }),
    );
  }
}

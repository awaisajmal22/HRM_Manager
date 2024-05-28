import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/Network/api_url.dart';
import 'package:hrm_manager/WidgetandBindings/app_routes.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/back.dart';
import 'package:hrm_manager/constant/constant.dart';
import 'package:hrm_manager/constant/divider.dart';
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
import 'package:ionicons/ionicons.dart';
import 'package:open_file_plus/open_file_plus.dart';

import 'package:provider/provider.dart';

class WorkerProfileView extends StatefulWidget {
  final int id;

  WorkerProfileView({super.key, required this.id});

  @override
  State<WorkerProfileView> createState() => _WorkerProfileViewState();
}

class _WorkerProfileViewState extends State<WorkerProfileView> {
  bool _isLoaded = false;
  late WorkerProfileProvider pv;
  @override
  void initState() {
    if (_isLoaded == false) {
      _load();
    }
    super.initState();
  }

  _load() {
    pv = Provider.of<WorkerProfileProvider>(context, listen: false);
    print("Worker ID is ${widget.id}");
    pv
        .getWorkerData(context: context, id: widget.id)
        .whenComplete(() => _loadData());
    pv.getFileData(
        id: widget.id,
        title: 'profile',
        index: 0,
        isProfile: true,
        api: "${ApiUrl.getProfileImage}/${widget.id}",
        context: context);

    pv
        .getFileData(
            title: 'WHIMS',
            index: 1,
            api: "${ApiUrl.getWHIMSById}/${widget.id}",
            context: context)
        .whenComplete(() {
      pv
          .getFileData(
              title: 'Working From Height',
              index: 2,
              api: "${ApiUrl.getWorkingHeightsById}/${widget.id}",
              context: context)
          .whenComplete(() {
        pv
            .getFileData(
                title: 'First Aid',
                index: 4,
                api: "${ApiUrl.getFirstAidById}/${widget.id}",
                context: context)
            .whenComplete(() {
          pv
              .getFileData(
                  title: 'Terms of Employment',
                  index: 6,
                  api: "${ApiUrl.getTermsEmployeementById}/${widget.id}",
                  context: context)
              .whenComplete(() {
            pv
                .getFileData(
                    title: 'Employement Release',
                    index: 3,
                    api: "${ApiUrl.getEmployeementReleaseById}/${widget.id}",
                    context: context)
                .whenComplete(() {
              pv.getFileData(
                  title: 'Others',
                  index: 5,
                  api: "${ApiUrl.getOthersById}/${widget.id}",
                  context: context);
            });
          });
        });
      });
    });

    print(pv.files.length);
    setState(() {
      _isLoaded = true;
    });
  }

  Future _loadData() async {
    final pv = Provider.of<WorkerProfileProvider>(context, listen: false);
    pv.getExperienceData(context: context).whenComplete(() {
      List<int> workExpIDList = pv.workerByIdModel.workExperience
          .toString()
          .isNotNullableString()
          .split(',')
          .map(int.parse)
          .toList();
      for (int i = 0; i < workExpIDList.length; i++) {
        for (var data in pv.workerExperienceList) {
          if (data.id == workExpIDList[i]) {
            if (!pv.selectedWorkExpIDList.contains(workExpIDList[i])) {
              pv.selectWorkExperience(data.name!, data.id!);
            }
          }
        }
      }
    });
    pv.getUnionAffliciationData(context: context).whenComplete(() {
      List<int> unionAfList = pv.workerByIdModel.unionAffillationsId
          .toString()
          .isNotNullableString()
          .split(',')
          .map(int.parse)
          .toList();
      for (int i = 0; i < unionAfList.length; i++) {
        for (var data in pv.unionAfflicationList) {
          if (data.id == unionAfList[i]) {
            if (!pv.selectedUnionAfflicationIdList.contains(unionAfList[i])) {
              pv.selectUnionAffiliation(data.name!, data.id!);
            }
          }
        }
      }
    });
    pv.getFlagData(context: context).whenComplete(() {
      List<int> flagIDList = pv.workerByIdModel.workerFlagId
          .toString()
          .isNotNullableString()
          .split(',')
          .map(int.parse)
          .toList();
      for (int i = 0; i < flagIDList.length; i++) {
        for (var data in pv.workerFlagList) {
          if (data.id == flagIDList[i]) {
            if (!pv.selectedWorkerFlagIdList.contains(flagIDList[i])) {
              pv.selectWorkerFlag(data.name!, flagIDList[i]);
            }
          }
        }
      }
    });

    pv.getCertificationList(context: context).whenComplete(() {
      List<int> certificatIDList = pv.workerByIdModel.certificationId
          .toString()
          .isNotNullableString()
          .split(',')
          .map(int.parse)
          .toList();
      for (int i = 0; i < certificatIDList.length; i++) {
        for (var data in pv.certificationList) {
          if (data.id == certificatIDList[i]) {
            if (!pv.selectedcertificateIdList.contains(certificatIDList[i])) {
              pv.selectCertificate(data.name!, certificatIDList[i]);
            }
          }
        }
      }
    });
    pv.getStatusData(context: context).whenComplete(() {
      for (var status in pv.workerStatusList) {
        if (status.id == pv.workerByIdModel.workerStatusId) {
          pv.selectStatus(status.name!, status.id!);
        }
      }
    });
    pv.getTradeOption(context: context).whenComplete(() {
      for (var data in pv.tradeOptionList) {
        if (data.id == pv.workerByIdModel.tradeOptionId) {
          pv.selectTradeOption(data.tradeOptionName!, data.id!);
        }
      }
    });
  }

  @override
  void dispose() {
    pv.clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkerProfileProvider>(builder: (context, provider, __) {
      return Scaffold(
        bottomSheet: SizedBox(
            height: context.getSize.height * 0.08,
            width: context.getSize.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                textButton(
                  vPadding: 0.020,
                  width: context.getSize.width * 0.3,
                  radius: 100,
                  context: context,
                  onTap: () {
                    provider.generateCsvFile(
                        context: context,
                        flags: provider.selectedWorkerFlagList
                            .join(', ')
                            .toString(),
                        experience:
                            provider.selectedWorkExpList.join(', ').toString(),
                        afflication: provider.selectedUnionAfflicationList
                            .join(', ')
                            .toString(),
                        certificate: provider.selectedcertificateList
                            .join(', ')
                            .toString(),
                        status: provider.selectedStatus,
                        trade: provider.selectedTrade);
                  },
                  title: 'Export CSV',
                ),
              ],
            )),
        body: SafeArea(
            child: Column(
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
                          context, AppRoutes.editWorkerDetailView, arguments: [
                        provider.workerByIdModel,
                        provider.profileImage
                      ]);
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
                    imageUrl: provider.profileImage,
                    name:
                        "${provider.workerByIdModel.firstName.toString().isNotNullableString()} ${provider.workerByIdModel.lastName.toString().isNotNullableString()}",
                    //  provider.workerProfileModel.name!,
                    status: provider.selectedStatus
                        .toString()
                        .isNotNullableString(),
                    // provider.workerProfileModel.status!,
                    dateOfBirth: dateFormater(
                        provider.workerByIdModel.dateofBirth.toString() ?? ''),
                    // provider.workerProfileModel.dob!,
                    price: provider.workerByIdModel.regularRate == null
                        ? '0.00'
                        : "\$${double.parse(provider.workerByIdModel.regularRate.toString()).toStringAsFixed(2).isNotNullableString()}/hr",
                    // provider.workerProfileModel.price!,
                    trade:
                        provider.selectedTrade.toString().isNotNullableString(),
                    // provider.workerProfileModel.trade!,
                  ),
                  getHeight(context: context, height: 0.02),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffE7E0EC)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getHeight(context: context, height: 0.01),
                        richText2(
                          context: context,
                          title: 'Experience: ',
                          subtitle: provider.selectedWorkExpList,
                          // provider.workerProfileModel.experience!,
                        ),
                        divider(
                            color: AppColor.lightPurpleColor.withOpacity(0.2)),
                        getHeight(context: context, height: 0.01),
                        richText(
                          context: context,
                          title: 'Previous Employment: ',
                          subtitle: provider
                              .workerByIdModel.employeeHistoryNotes
                              .toString()
                              .isNotNullableString(),
                        ),
                        divider(
                            color: AppColor.lightPurpleColor.withOpacity(0.2)),
                        getHeight(context: context, height: 0.01),
                        richText2(
                          context: context,
                          title: 'Union Affiliation: ',
                          subtitle: provider.selectedUnionAfflicationList,
                        ),
                        divider(
                            color: AppColor.lightPurpleColor.withOpacity(0.2)),
                        getHeight(context: context, height: 0.01),
                        richText2(
                          context: context,
                          title: 'Flag: ',
                          subtitle: provider.selectedWorkerFlagList,
                        ),
                        divider(
                            color: AppColor.lightPurpleColor.withOpacity(0.2)),
                        getHeight(context: context, height: 0.01),
                        richText(
                          context: context,
                          title: 'Transportation: ',
                          subtitle: provider.workerByIdModel.ownTransportation
                                      .toString()
                                      .isNotNullableString()
                                      .toLowerCase() ==
                                  "true"
                              ? "Yes"
                              : "No",
                          // provider.workerProfileModel.transportation!,
                        ),
                        divider(
                            color: AppColor.lightPurpleColor.withOpacity(0.2)),
                        getHeight(context: context, height: 0.01),
                        richText(
                            context: context,
                            title: 'Home: ',
                            subtitle: provider.workerByIdModel.address1
                                .toString()
                                .isNotNullableString()
                            //  provider.workerProfileModel.home!,
                            ),
                        divider(
                            color: AppColor.lightPurpleColor.withOpacity(0.2)),
                        getHeight(context: context, height: 0.01),
                        richText2(
                          context: context,
                          title: 'Certificates: ',
                          subtitle: provider.selectedcertificateList,
                          // provider.workerProfileModel.certificate!,
                        ),
                        divider(
                            color: AppColor.lightPurpleColor.withOpacity(0.2)),
                        getHeight(context: context, height: 0.01),
                        richText(
                          context: context,
                          title: 'Special Tickets: ',
                          subtitle: provider.workerProfileModel.specialTickets!,
                        ),
                        divider(
                            color: AppColor.lightPurpleColor.withOpacity(0.2)),
                        getHeight(context: context, height: 0.01),
                        richText(
                          context: context,
                          title: 'Note: ',
                          subtitle: provider.workerByIdModel.notes
                              .toString()
                              .isNotNullableString(),
                          // provider.workerProfileModel.note!,
                        ),
                        divider(
                            color: AppColor.lightPurpleColor.withOpacity(0.2)),
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
                        provider.files.isEmpty
                            ? Center(
                                child: appText(
                                    context: context,
                                    title: 'No Documment Yet',
                                    textColor: Colors.black))
                            : Wrap(
                                runSpacing: 10,
                                runAlignment: WrapAlignment.center,
                                alignment: WrapAlignment.center,
                                children: List.generate(
                                    provider.files.length,
                                    (index) => GestureDetector(
                                          onTap: () async {
                                            OpenFile.open(provider
                                                .files[index].wasabiBytes);
                                            // Navigator.pushNamed(context, AppRoutes.pdfView,
                                            //     arguments: [
                                            //       '',
                                            //       // index.toString(),
                                            //       provider.files[index],
                                            //       // Constant.pdfFile,
                                            //     ]);
                                          },
                                          child: SizedBox(
                                            width: context.getSize.width * 0.22,
                                            child: Column(
                                              children: [
                                                if (provider
                                                    .files[index].contentType!
                                                    .contains('pdf'))
                                                  Image.asset(
                                                    Constant.pdfIcon,
                                                    width:
                                                        context.getSize.width *
                                                            0.086,
                                                    height:
                                                        context.getSize.height *
                                                            0.048,
                                                  ),
                                                if (provider.files[index]
                                                        .contentType!
                                                        .contains(
                                                            'officedocument') ||
                                                    provider.files[index]
                                                        .contentType!
                                                        .contains('text/plain'))
                                                  Icon(
                                                    Ionicons.document,
                                                    color: Colors.blue,
                                                    size:
                                                        context.getSize.height *
                                                            0.048,
                                                  ),
                                                if (provider.files[index]
                                                        .contentType!
                                                        .contains('png') ||
                                                    provider.files[index]
                                                        .contentType!
                                                        .contains('jpeg'))
                                                  Icon(
                                                    Ionicons.image,
                                                    color: Colors.blue,
                                                    size:
                                                        context.getSize.height *
                                                            0.048,
                                                  ),
                                                appText(
                                                  context: context,
                                                  title: provider
                                                      .files[index].title
                                                      .toString()
                                                      .isNotNullableString(),
                                                  fontSize: 12,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                              ),
                        getHeight(context: context, height: 0.030),
                      ],
                    ),
                  )
                ],
              ),
            ),
            getHeight(context: context, height: 0.08)
          ],
        )),
      );
    });
  }
}

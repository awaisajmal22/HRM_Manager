import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/Model/add_worker_drop_down_model.dart';
import 'package:hrm_manager/Model/worker_by_id_model.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/back.dart';
import 'package:hrm_manager/constant/check_widget.dart';
import 'package:hrm_manager/constant/constant.dart';
import 'package:hrm_manager/constant/height_box.dart';
import 'package:hrm_manager/constant/rich_text.dart';
import 'package:hrm_manager/constant/text_button.dart';
import 'package:hrm_manager/constant/toast.dart';
import 'package:hrm_manager/constant/width_box.dart';
import 'package:hrm_manager/extensions/nullable_string_extension.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/add_worker_provider.dart';
import 'package:hrm_manager/provider/edit_worker_detail_provider.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:hrm_manager/views/AddWorker/component/add_worker_field.dart';
import 'package:hrm_manager/views/AddWorker/component/custom_two_textField_widget.dart';
import 'package:hrm_manager/views/AddWorker/component/file_displayer.dart';
import 'package:hrm_manager/views/AddWorker/component/select_certification_widget.dart';
import 'package:hrm_manager/views/AddWorker/component/select_language_widget.dart';
import 'package:hrm_manager/views/AddWorker/component/select_recruiter.dart';
import 'package:hrm_manager/views/AddWorker/component/select_timesheet_type_widget.dart';
import 'package:hrm_manager/views/AddWorker/component/select_union_affiliation.dart';
import 'package:hrm_manager/views/AddWorker/component/select_worker_pickup_location_widget.dart';
import 'package:hrm_manager/views/AddWorker/component/trade_option_widget.dart';
import 'package:hrm_manager/views/AddWorker/component/work_experience_widget.dart';
import 'package:hrm_manager/views/AddWorker/component/worker_flag_widget.dart';
import 'package:hrm_manager/views/AddWorker/component/worker_status.dart';
import 'package:hrm_manager/views/EditWorkerDetial/component/edit_select_language_widget.dart';
import 'package:hrm_manager/views/EditWorkerDetial/component/edit_trade_option_widget.dart';
import 'package:hrm_manager/views/EditWorkerDetial/component/edit_worker_status.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import 'component/edit_add_worker_field.dart';
import 'component/edit_custom_two_textField_widget.dart';
import 'component/edit_file_diplayer.dart';
import 'component/edit_select_certification_widget.dart';
import 'component/edit_select_job_site_widget.dart';
import 'component/edit_select_recruiter.dart';
import 'component/edit_select_timesheet_type_widget.dart';
import 'component/edit_select_union_affiliation.dart';
import 'component/edit_select_worker_pickup_location_widget.dart';
import 'component/edit_work_experience_widget.dart';
import 'component/edit_worker_flag_widget.dart';

class EditWorkerDetailView extends StatefulWidget {
  final WorkerByIdModel workerModel;
  final String profileImage;
  const EditWorkerDetailView(
      {super.key, required this.workerModel, required this.profileImage});

  @override
  State<EditWorkerDetailView> createState() => _EditWorkerDetailViewState();
}

class _EditWorkerDetailViewState extends State<EditWorkerDetailView> {
  late EditWorkerDetailProvider pv;

  bool isSuccess = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Call your function here
      if (isSuccess == false) {
        loadData();
      }
    });
  }

  loadData() {
    pv = Provider.of<EditWorkerDetailProvider>(context, listen: false);

    pv.getExperienceData(context: context).whenComplete(() {
      List<int> workExpIDList = widget.workerModel.workExperience
          .toString()
          .isNotNullableString()
          .split(',')
          .map(int.parse)
          .toList();
      for (int i = 0; i < workExpIDList.length; i++) {
        for (var data in pv.workerExperienceList) {
          if (data.id == workExpIDList[i]) {
            if (!pv.selectedWorkExperienceIdList.contains(workExpIDList[i])) {
              pv.selectWorkExperience(data.name!, data.id!);
            }
          }
        }
      }
    });
    pv.getJobSiteData(context: context).whenComplete(() {
      pv
          .getJobsiteByIdData(id: widget.workerModel.id, context: context)
          .then((value) {
        for (int i = 0; i < value.length; i++) {
          for (var job in pv.jobSitesList) {
            if (job.id == value[i].jobsiteId) {
              pv.selectJobSite(job.name!, job.id!);
            }
          }
        }
      });
    });
    pv.getRecruiterData(context: context).whenComplete(() async {
      await pv
          .getAssignRecruiterById(id: widget.workerModel.id, context: context)
          .then((value) {
        for (var data in pv.recruiterList) {
          if (data.id == value) {
            pv.selectRecruiter(data.name!, data.id!);
          }
        }
      });
    });
    pv.getUnionAffliciationData(context: context).whenComplete(() {
      List<int> unionAfList = widget.workerModel.unionAffillationsId
          .toString()
          .isNotNullableString()
          .split(',')
          .map(int.parse)
          .toList();
      print("Union List ${widget.workerModel.unionAffillationsId}");
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
    pv.getLanguagesData(context: context).whenComplete(() {
      List<int> languageIDList = widget.workerModel.lanaguageId
          .toString()
          .isNotNullableString()
          .split(',')
          .map(int.parse)
          .toList();
      print("Language ID List ${widget.workerModel.lanaguageId}");
      for (int i = 0; i < languageIDList.length; i++) {
        for (var data in pv.languagesList) {
          if (data.id == languageIDList[i]) {
            if (!pv.selectedLanguageIDList.contains(languageIDList[i])) {
              pv.selectLanguage(data.name!, data.id!);
            }
          }
        }
      }
    });

    pv.getCertificationList(context: context).whenComplete(() {
      List<int> certificatIDList = widget.workerModel.certificationId
          .toString()
          .isNotNullableString()
          .split(',')
          .map(int.parse)
          .toList();
      print("Language ID List ${widget.workerModel.certificationId}");
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
    pv.getWorkerPickupLocationData(context: context).whenComplete(() {
      for (var location in pv.workerPickUpLocationList) {
        if (location.id == widget.workerModel.workerPickUpLocation) {
          pv.selectWorkerPickupLocation(location.name!, location.id!);
        }
      }
    });
    pv.getTimeSheetTypeData(context: context).whenComplete(() {
      for (var timesheet in pv.timeSheetTypeList) {
        if (timesheet.id == widget.workerModel.timeSheettype) {
          pv.changeTimeSheetType(timesheet.name!, timesheet.id!);
        }
      }
    });
    pv.getStatusData(context: context).whenComplete(() {
      for (var status in pv.workerStatusList) {
        if (status.id == widget.workerModel.workerStatusId) {
          pv.selectStatus(status.name!, status.id!);
        }
      }
    });
    pv.getFlagData(context: context).whenComplete(() {
      List<int> flagIDList = widget.workerModel.workerFlagId
          .toString()
          .isNotNullableString()
          .split(',')
          .map(int.parse)
          .toList();
      print("Language ID List ${widget.workerModel.workerFlagId}");
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
    ;
    pv.getTradeOption(context: context).whenComplete(() {
      for (var data in pv.tradeOptionList) {
        if (data.id == widget.workerModel.tradeOptionId) {
          pv.selectTradeOption(data.tradeOptionName!, data.id!);
        }
      }
    });
    pv.changeProfileImage(widget.profileImage);
    checkTrueFalse();
    setState(() {
      isSuccess = true;
    });
  }

  checkTrueFalse() async {
    final isEnglishFluense = widget.workerModel.englishFluency;
    await pv.changeEnglishFLunecy(isEnglishFluense == false ? 1 : 0);
    final isLegalToWork = widget.workerModel.legalToWork;
    await pv.changeLegalToWork(isLegalToWork == true ? 0 : 1);
    final isOwnTransport = widget.workerModel.ownTransportation;
    await pv.changeOwnTransport(isOwnTransport == true ? 0 : 1);
    final isRecruiterPaymentDelivery = widget.workerModel.paymentDelivery;
    await pv.changeRecruiterPaymentDelivery(
        isRecruiterPaymentDelivery == true ? 0 : 1);
    final pastWIBSClaim = widget.workerModel.pastWsibClaim;
    await pv.changePastWSIBClaim(pastWIBSClaim == true ? 0 : 1);
    final submitOwnHours = widget.workerModel.submitsOwnHours;
    await pv.changeSubmitOwnHours(submitOwnHours == true ? 0 : 1);
    final clientPayWIBS = widget.workerModel.clientPaysWsib;
    await pv.changeClientPaysWSIB(clientPayWIBS == true ? 0 : 1);
  }

  @override
  void dispose() {
    pv.clearData();
    super.dispose();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Consumer<EditWorkerDetailProvider>(builder: (context, provider, __) {
        print(widget.workerModel.lastName.toString().isNotNullableString());
        if (isLoading == false) {
          provider.lastNameController.text =
              widget.workerModel.lastName.toString().isNotNullableString();
          provider.firstNameController.text =
              widget.workerModel.firstName.toString().isNotNullableString();
          AddWorkerDropDownModel recruiter = provider.recruiterList.firstWhere(
            (e) => e.id == widget.workerModel.assignedRecuriterId,
            orElse: () {
              return AddWorkerDropDownModel();
            },
          );
          if (recruiter.id != null) {
            provider.selectRecruiter(recruiter.name!, recruiter.id!);
          }
          provider.emergencyContact1Controller.text = widget
              .workerModel.emergencyContact1
              .toString()
              .isNotNullableString();
          provider.emergencyContact2Controller.text = widget
              .workerModel.emergencyContact2
              .toString()
              .isNotNullableString();
          provider.address1Controller.text =
              widget.workerModel.address1.toString().isNotNullableString();
          provider.address2Controller.text =
              widget.workerModel.address2.toString().isNotNullableString();
          provider.ageController.text =
              widget.workerModel.age.toString().isNotNullableString();
          provider.businessNameController.text =
              widget.workerModel.bussinessName.toString().isNotNullableString();
          provider.workerIdController.text = widget.workerModel.internalWorkerId
              .toString()
              .isNotNullableString();
          provider.clientIdController.text =
              widget.workerModel.workerId.toString().isNotNullableString();
        }
        provider.socialInsuranceController.text = widget
            .workerModel.socialInsuranceNumber
            .toString()
            .isNotNullableString();
        final pickableDate =
            widget.workerModel.workerHireDate.toString().isNotNullableString();
        provider.workPermitController.text =
            widget.workerModel.workPermitNo.toString().isNotNullableString();
        provider.hireDateController.text = pickableDate == ''
            ? ''
            : "${DateFormat.LLLL().format(DateTime.parse(pickableDate))} ${DateFormat.d().format(DateTime.parse(pickableDate))}, ${DateFormat.y().format(DateTime.parse(pickableDate))}";
        final dob =
            widget.workerModel.dateofBirth.toString().isNotNullableString();
        provider.dobController.text = dob == ''
            ? ''
            : "${DateFormat.LLLL().format(DateTime.parse(dob))} ${DateFormat.d().format(DateTime.parse(dob))}, ${DateFormat.y().format(DateTime.parse(dob))}";
        final terminateDate = widget.workerModel.workerTerminationDate
            .toString()
            .isNotNullableString();
        provider.terminationDateController.text = terminateDate == null ||
                terminateDate == ""
            ? ''
            : "${DateFormat.LLLL().format(DateTime.parse(terminateDate))} ${DateFormat.d().format(DateTime.parse(terminateDate))}, ${DateFormat.y().format(DateTime.parse(terminateDate))}";
        provider.flagNotesController.text =
            widget.workerModel.notes.toString().isNotNullableString();
        provider.businessWSIBNoController.text =
            widget.workerModel.bussinessWsibNo.toString().isNotNullableString();
        provider.wSIBClaimNoteController.text =
            widget.workerModel.wsibClaimNotes.toString().isNotNullableString();
        provider.businessTelephoneController.text =
            widget.workerModel.businessTele.toString().isNotNullableString();
        provider.cityController.text =
            widget.workerModel.city.toString().isNotNullableString();
        provider.provinceController.text =
            widget.workerModel.province.toString().isNotNullableString();
        provider.postalCodeController.text =
            widget.workerModel.postalCode.toString().isNotNullableString();
        provider.countryController.text =
            widget.workerModel.country.toString().isNotNullableString();
        provider.mobileTelephoneController.text =
            widget.workerModel.mobile.toString().isNotNullableString();
        provider.homeTelephoneController.text =
            widget.workerModel.homeTele.toString().isNotNullableString();

        provider.emergencyTelephone1Controller.text = widget
            .workerModel.emergencyTelephone1
            .toString()
            .isNotNullableString();
        provider.emergencyTelephone2Controller.text = widget
            .workerModel.emergencyTelephone2
            .toString()
            .isNotNullableString();
        provider.regularRateController.text =
            widget.workerModel.regularRate.toString().isNotNullableString();
        provider.overTimeRateController.text =
            widget.workerModel.overTimeRate.toString().isNotNullableString();
        provider.clientRateController.text =
            widget.workerModel.billRate.toString().isNotNullableString();
        provider.tradeLicenseNoController.text =
            widget.workerModel.tradeLicenseNo.toString().isNotNullableString();
        provider.workExperienceNoteController.text = widget
            .workerModel.workExperienceNotes
            .toString()
            .isNotNullableString();
        provider.certificationNotesController.text = widget
            .workerModel.certificationsNotes
            .toString()
            .isNotNullableString();
        provider.recruiterCommissionController.text = widget
            .workerModel.recruiterCommission
            .toString()
            .isNotNullableString();
        provider.paymentNotesController.text =
            widget.workerModel.paymentNotes.toString().isNotNullableString();
        provider.unionAffiliationNotesController.text = widget
            .workerModel.unionAffiliationNotes
            .toString()
            .isNotNullableString();
        provider.emailController.text =
            widget.workerModel.email.toString().isNotNullableString();
        provider.employmentHistoryNoteController.text = widget
            .workerModel.employeeHistoryNotes
            .toString()
            .isNotNullableString();

        return SafeArea(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: context.getSize.height * 0.020),
              // color: const Color(0xffE7E0EC),
              child: Row(
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
                    title: 'Edit Worker Detail',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    textColor: AppColor.iconColor,
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                  horizontal: context.getSize.width * 0.040,
                ),
                children: [
                  getHeight(context: context, height: 0.020),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: context.getSize.height * 0.1,
                        width: context.getSize.width * 0.2,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              height: context.getSize.height * 0.1,
                              width: context.getSize.width * 0.2,
                              decoration: BoxDecoration(
                                  border: provider.pickedImage != ''
                                      ? null
                                      : Border.all(
                                          color: AppColor.lightPurpleColor
                                              .withOpacity(0.67),
                                        ),
                                  shape: BoxShape.circle,
                                  image: provider.pickedImage != ''
                                      ? DecorationImage(
                                          image: FileImage(
                                              File(provider.pickedImage)),
                                          fit: BoxFit.cover)
                                      : const DecorationImage(
                                          image:
                                              AssetImage(Constant.dummyImage),
                                          fit: BoxFit.cover)),
                            ),
                            GestureDetector(
                              onTap: () {
                                provider.pickImage();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: context.getSize.height * 0.04,
                                width: context.getSize.width * 0.08,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.lightPinkColor,
                                ),
                                child: Icon(
                                  Ionicons.create_outline,
                                  size: context.getSize.height * 0.020,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      getWidth(context: context, width: 0.020),
                      appText(
                        context: context,
                        title: 'Edit Profile image',
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  getHeight(context: context, height: 0.020),
                  appText(
                    textAlign: TextAlign.left,
                    context: context,
                    title: 'Internal Worker ID:',
                    fontWeight: FontWeight.w500,
                  ),
                  getHeight(context: context, height: 0.005),
                  editAddWorkerTextField(
                    context: context,
                    hintText: 'WR000001',
                    controller: provider.workerIdController,
                    height: context.getSize.height * 0.050,
                  ),
                  getHeight(context: context, height: 0.010),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          richText(
                              context: context,
                              title: 'Assigned To Recruiter',
                              subtitle: '*',
                              fontSize: 14,
                              twoendTextColor: Colors.red,
                              fontWeight1: FontWeight.w500,
                              fontWeight2: FontWeight.w500),
                          getHeight(context: context, height: 0.005),
                          const EditSelectRecruiter()
                        ],
                      )),
                      getWidth(context: context, width: 0.030),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          richText(
                              context: context,
                              title: 'Client Worker ID',
                              subtitle: '*',
                              fontSize: 14,
                              twoendTextColor: Colors.red,
                              fontWeight1: FontWeight.w500,
                              fontWeight2: FontWeight.w500),
                          getHeight(context: context, height: 0.005),
                          editAddWorkerTextField(
                            context: context,
                            hintText: 'WR1',
                            controller: provider.clientIdController,
                            height: context.getSize.height * 0.050,
                          ),
                        ],
                      )),
                    ],
                  ),
                  getHeight(
                    context: context,
                    height: 0.010,
                  ),
                  appText(
                    textAlign: TextAlign.left,
                    context: context,
                    title: 'Now On Job Site',
                    fontWeight: FontWeight.w500,
                  ),
                  getHeight(context: context, height: 0.005),
                  const EditSelectJobSite(),
                  getHeight(context: context, height: 0.010),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          richText(
                              context: context,
                              title: 'Worker First Name',
                              subtitle: '*',
                              fontSize: 14,
                              twoendTextColor: Colors.red,
                              fontWeight1: FontWeight.w500,
                              fontWeight2: FontWeight.w500),
                          getHeight(context: context, height: 0.005),
                          editAddWorkerTextField(
                            context: context,
                            hintText: 'Enter First Name',
                            controller: provider.firstNameController,
                            height: context.getSize.height * 0.050,
                          ),
                        ],
                      )),
                      getWidth(context: context, width: 0.030),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          richText(
                              context: context,
                              title: 'Worker Last Name',
                              subtitle: '*',
                              fontSize: 14,
                              twoendTextColor: Colors.red,
                              fontWeight1: FontWeight.w500,
                              fontWeight2: FontWeight.w500),
                          getHeight(context: context, height: 0.005),
                          editAddWorkerTextField(
                            context: context,
                            hintText: 'Enter Last Name',
                            controller: provider.lastNameController,
                            height: context.getSize.height * 0.050,
                          ),
                        ],
                      )),
                    ],
                  ),
                  getHeight(context: context, height: 0.010),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Date of Birth',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          editAddWorkerTextField(
                            readOnly: true,
                            onTap: () {
                              provider.pickDateOfBirth(context: context);
                            },
                            context: context,
                            hintText: 'mm/dd/yyyy',
                            controller: provider.dobController,
                            height: context.getSize.height * 0.050,
                          ),
                        ],
                      )),
                      getWidth(context: context, width: 0.030),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Age',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          editAddWorkerTextField(
                            readOnly: true,
                            textInputType: TextInputType.number,
                            color: Color(0xffF5F5F5),
                            context: context,
                            hintText: 'Age',
                            controller: provider.ageController,
                            height: context.getSize.height * 0.050,
                          ),
                        ],
                      )),
                    ],
                  ),
                  getHeight(context: context, height: 0.010),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'English Fluency',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          checkWidget(
                            onTap: (index) {
                              provider.changeEnglishFLunecy(index);
                            },
                            context: context,
                            selectedIndex: provider.isEnglishFluence,
                          )
                        ],
                      )),
                      getWidth(context: context, width: 0.030),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Other Languages',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          const EditSelectLanguageWidget()
                        ],
                      )),
                    ],
                  ),
                  getHeight(context: context, height: 0.010),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Legal To Work',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          checkWidget(
                            onTap: (index) {
                              provider.changeLegalToWork(index);
                            },
                            context: context,
                            selectedIndex: provider.islegalToWork,
                          )
                        ],
                      )),
                      getWidth(context: context, width: 0.030),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Own Transportation',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          checkWidget(
                            onTap: (index) {
                              provider.changeOwnTransport(index);
                            },
                            context: context,
                            selectedIndex: provider.isOwnTransport,
                          )
                        ],
                      )),
                    ],
                  ),
                  getHeight(context: context, height: 0.010),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Social Insurance Number',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          editAddWorkerTextField(
                            context: context,
                            hintText: 'Enter Social Insurance Number',
                            controller: provider.socialInsuranceController,
                            height: context.getSize.height * 0.050,
                          ),
                        ],
                      )),
                      getWidth(context: context, width: 0.030),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Work Permit No',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          editAddWorkerTextField(
                            context: context,
                            hintText: 'Enter Work Permit No',
                            controller: provider.workPermitController,
                            height: context.getSize.height * 0.050,
                          ),
                        ],
                      )),
                    ],
                  ),
                  getHeight(context: context, height: 0.010),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Worker Hire Date',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          editAddWorkerTextField(
                            readOnly: true,
                            onTap: () {
                              provider.pickHireDate(context: context);
                            },
                            context: context,
                            hintText: 'mm/dd/yyyy',
                            controller: provider.hireDateController,
                            height: context.getSize.height * 0.050,
                          ),
                        ],
                      )),
                      getWidth(context: context, width: 0.030),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Worker Termination Date',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          editAddWorkerTextField(
                            readOnly: true,
                            onTap: () {
                              provider.pickTerminationDate(context: context);
                            },
                            context: context,
                            hintText: 'mm/dd/yyyy',
                            controller: provider.terminationDateController,
                            height: context.getSize.height * 0.050,
                          ),
                        ],
                      )),
                    ],
                  ),
                  getHeight(context: context, height: 0.010),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          richText(
                              context: context,
                              title: 'Worker Status',
                              subtitle: '*',
                              fontSize: 14,
                              twoendTextColor: Colors.red,
                              fontWeight1: FontWeight.w500,
                              fontWeight2: FontWeight.w500),
                          getHeight(context: context, height: 0.005),
                          const EditWorkerStatus()
                        ],
                      )),
                      getWidth(context: context, width: 0.030),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Worker Flag',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          const EditWorkerFlagWidget()
                        ],
                      )),
                    ],
                  ),
                  getHeight(context: context, height: 0.010),
                  appText(
                    textAlign: TextAlign.left,
                    context: context,
                    title: 'Worker/Status/Flag/Notes',
                    fontWeight: FontWeight.w500,
                  ),
                  getHeight(context: context, height: 0.005),
                  editAddWorkerTextField(
                    maxLines: 2,
                    context: context,
                    hintText: '',
                    controller: provider.flagNotesController,
                    height: null,
                  ),
                  getHeight(context: context, height: 0.010),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Business WSIB Number',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          editAddWorkerTextField(
                            context: context,
                            hintText: 'Enter Business WSIB Number',
                            controller: provider.businessWSIBNoController,
                            height: context.getSize.height * 0.050,
                          ),
                        ],
                      )),
                      getWidth(context: context, width: 0.030),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Past WSIB Claim',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          checkWidget(
                            onTap: (index) {
                              provider.changePastWSIBClaim(index);
                            },
                            context: context,
                            selectedIndex: provider.pastWSIBClaim,
                          )
                        ],
                      )),
                    ],
                  ),
                  getHeight(context: context, height: 0.010),
                  appText(
                    textAlign: TextAlign.left,
                    context: context,
                    title: 'WSIB Claim Notes',
                    fontWeight: FontWeight.w500,
                  ),
                  getHeight(context: context, height: 0.005),
                  editAddWorkerTextField(
                    maxLines: 2,
                    context: context,
                    hintText: '',
                    controller: provider.wSIBClaimNoteController,
                    height: null,
                  ),
                  getHeight(context: context, height: 0.010),
                  EditCustomTwoTextFieldWidget(
                    controllerLeft: provider.businessNameController,
                    controllerRight: provider.businessTelephoneController,
                    titleLeft: 'Business Name',
                    titleRight: 'Business Telephone',
                    hintLeft: 'Enter Business Name',
                    hintRight: 'Enter Business Telephone',
                  ),
                  getHeight(context: context, height: 0.010),
                  EditCustomTwoTextFieldWidget(
                    controllerLeft: provider.address1Controller,
                    controllerRight: provider.address2Controller,
                    titleLeft: 'Address Line 1',
                    titleRight: 'Address Line 2',
                    hintLeft: 'Enter Address Line 1',
                    hintRight: 'Enter Address Line 2',
                  ),
                  getHeight(context: context, height: 0.010),
                  EditCustomTwoTextFieldWidget(
                    controllerLeft: provider.cityController,
                    controllerRight: provider.provinceController,
                    titleLeft: 'City',
                    titleRight: 'Province',
                    hintLeft: 'Enter City',
                    hintRight: 'Enter Province',
                  ),
                  getHeight(context: context, height: 0.010),
                  EditCustomTwoTextFieldWidget(
                    rightReadOnly: true,
                    controllerLeft: provider.postalCodeController,
                    controllerRight: provider.countryController,
                    titleLeft: 'Postal Code',
                    titleRight: 'Country',
                    hintLeft: 'Enter Postal Code',
                    hintRight: 'Enter Country',
                  ),
                  getHeight(context: context, height: 0.010),
                  EditCustomTwoTextFieldWidget(
                    controllerLeft: provider.mobileTelephoneController,
                    controllerRight: provider.homeTelephoneController,
                    titleLeft: 'Mobile Telephone',
                    titleRight: 'Home Telephone',
                    hintLeft: 'Enter Mobile Telephone',
                    hintRight: 'Enter Home Telephone',
                  ),
                  getHeight(context: context, height: 0.010),
                  richText(
                      context: context,
                      title: 'Email',
                      subtitle: '*',
                      fontSize: 14,
                      twoendTextColor: Colors.red,
                      fontWeight1: FontWeight.w500,
                      fontWeight2: FontWeight.w500),
                  getHeight(context: context, height: 0.005),
                  editAddWorkerTextField(
                    context: context,
                    hintText: 'Enter Email Address',
                    controller: provider.emailController,
                    height: context.getSize.height * 0.050,
                  ),
                  getHeight(context: context, height: 0.010),
                  EditCustomTwoTextFieldWidget(
                    controllerLeft: provider.emergencyContact1Controller,
                    controllerRight: provider.emergencyTelephone1Controller,
                    titleLeft: 'Emergency Contact 1',
                    titleRight: 'Emergency Telephone 1',
                    hintLeft: 'Enter Emergency Contact 1',
                    hintRight: 'Enter Emergency Telephone 1',
                  ),
                  getHeight(context: context, height: 0.010),
                  EditCustomTwoTextFieldWidget(
                    controllerLeft: provider.emergencyContact2Controller,
                    controllerRight: provider.emergencyTelephone2Controller,
                    titleLeft: 'Emergency Contact 2',
                    titleRight: 'Emergency Telephone 2',
                    hintLeft: 'Enter Emergency Contact 2',
                    hintRight: 'Enter Emergency Telephone 2',
                  ),
                  getHeight(context: context, height: 0.010),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Trade Options',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          const EditSelectTradeOption()
                        ],
                      )),
                      getWidth(context: context, width: 0.030),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Regular Rate',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          editAddWorkerTextField(
                            isDecimal: true,
                            textInputType: TextInputType.number,
                            context: context,
                            hintText: 'Enter Regular Rate',
                            controller: provider.regularRateController,
                            height: context.getSize.height * 0.050,
                          ),
                        ],
                      )),
                    ],
                  ),
                  getHeight(context: context, height: 0.010),
                  EditCustomTwoTextFieldWidget(
                    textInputTypeLeft: TextInputType.number,
                    textInputTypeRight: TextInputType.number,
                    controllerLeft: provider.overTimeRateController,
                    controllerRight: provider.clientRateController,
                    titleLeft: 'Over Time Rate',
                    titleRight: 'Client Rate',
                    hintLeft: 'Enter Over Time Rate',
                    hintRight: 'Enter Client Rate',
                  ),
                  getHeight(context: context, height: 0.010),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Work Experience',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          const EditSelectWorkExperience()
                        ],
                      )),
                      getWidth(context: context, width: 0.030),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Work Experience Note',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          editAddWorkerTextField(
                            textInputType: TextInputType.text,
                            context: context,
                            hintText: 'Enter Work Experience Note',
                            controller: provider.workExperienceNoteController,
                            height: context.getSize.height * 0.050,
                          ),
                        ],
                      )),
                    ],
                  ),
                  getHeight(context: context, height: 0.010),
                  appText(
                    textAlign: TextAlign.left,
                    context: context,
                    title: 'Trade License No',
                    fontWeight: FontWeight.w500,
                  ),
                  getHeight(context: context, height: 0.005),
                  editAddWorkerTextField(
                    context: context,
                    hintText: 'Enter Trade License No',
                    controller: provider.tradeLicenseNoController,
                    height: context.getSize.height * 0.050,
                  ),
                  getHeight(context: context, height: 0.010),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Union Affiliation',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          const EditSelectUnionAffiliation()
                        ],
                      )),
                      getWidth(context: context, width: 0.030),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Union Affiliation Notes',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          editAddWorkerTextField(
                            textInputType: TextInputType.text,
                            context: context,
                            hintText: 'Enter Union Affiliation Notes',
                            controller:
                                provider.unionAffiliationNotesController,
                            height: context.getSize.height * 0.050,
                          ),
                        ],
                      )),
                    ],
                  ),
                  getHeight(context: context, height: 0.010),
                  appText(
                    textAlign: TextAlign.left,
                    context: context,
                    title: 'Employment History Notes',
                    fontWeight: FontWeight.w500,
                  ),
                  getHeight(context: context, height: 0.005),
                  editAddWorkerTextField(
                    maxLines: 2,
                    context: context,
                    hintText: 'Enter Employment History Notes',
                    controller: provider.employmentHistoryNoteController,
                    height: null,
                  ),
                  getHeight(context: context, height: 0.010),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Certifications',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          const EditSelectCertification()
                        ],
                      )),
                      getWidth(context: context, width: 0.030),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Certifications Notes',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          editAddWorkerTextField(
                            textInputType: TextInputType.text,
                            context: context,
                            hintText: 'Enter Certifications Notes',
                            controller: provider.certificationNotesController,
                            height: context.getSize.height * 0.050,
                          ),
                        ],
                      )),
                    ],
                  ),
                  getHeight(context: context, height: 0.010),
                  editDisplayFile(
                    title: "WHIMS",
                    path: provider.wHIMSFileName,
                    context: context,
                    onTap: () {
                      provider.pickWHIMS();
                    },
                  ),
                  getHeight(context: context, height: 0.010),
                  editDisplayFile(
                    title: "Working Form Heights",
                    path: provider.workingFormHeightName,
                    context: context,
                    onTap: () {
                      provider.pickWorkingFormHeightFile();
                    },
                  ),
                  getHeight(context: context, height: 0.010),
                  editDisplayFile(
                    title: "First Aid",
                    path: provider.firstAidName,
                    context: context,
                    onTap: () {
                      provider.pickFirstAidFile();
                    },
                  ),
                  getHeight(context: context, height: 0.010),
                  editDisplayFile(
                    title: "Terms Of Employeement",
                    path: provider.termsOfEmpName,
                    context: context,
                    onTap: () {
                      provider.pickTermsOfEmpFile();
                    },
                  ),
                  getHeight(context: context, height: 0.010),
                  editDisplayFile(
                    title: "mployeement Release",
                    path: provider.empReleaseName,
                    context: context,
                    onTap: () {
                      provider.pickEmpReleaseFile();
                    },
                  ),
                  getHeight(context: context, height: 0.010),
                  editDisplayFile(
                    title: "Other",
                    path: provider.otherFileName,
                    context: context,
                    onTap: () {
                      provider.pickOtherFile();
                    },
                  ),
                  getHeight(context: context, height: 0.010),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          richText(
                              context: context,
                              title: 'Recruiter Payment Delivery',
                              subtitle: '*',
                              fontSize: 14,
                              twoendTextColor: Colors.red,
                              fontWeight1: FontWeight.w500,
                              fontWeight2: FontWeight.w500),
                          getHeight(context: context, height: 0.005),
                          checkWidget(
                            onTap: (index) {
                              provider.changeRecruiterPaymentDelivery(index);
                            },
                            context: context,
                            selectedIndex: provider.recruiterPaymentDelivery,
                          )
                        ],
                      )),
                      getWidth(context: context, width: 0.030),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          richText(
                              context: context,
                              title: 'Worker Pick Up Location',
                              subtitle: '*',
                              fontSize: 14,
                              twoendTextColor: Colors.red,
                              fontWeight1: FontWeight.w500,
                              fontWeight2: FontWeight.w500),
                          getHeight(context: context, height: 0.005),
                          const EditSelectWorkerPickUpLocationWidget()
                        ],
                      )),
                    ],
                  ),
                  getHeight(context: context, height: 0.010),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          richText(
                              context: context,
                              title: 'Recruiter Commission',
                              subtitle: '*',
                              fontSize: 14,
                              twoendTextColor: Colors.red,
                              fontWeight1: FontWeight.w500,
                              fontWeight2: FontWeight.w500),
                          getHeight(context: context, height: 0.005),
                          editAddWorkerTextField(
                            context: context,
                            hintText: 'Enter Recruiter Commission',
                            controller: provider.recruiterCommissionController,
                            height: context.getSize.height * 0.050,
                          ),
                        ],
                      )),
                      getWidth(context: context, width: 0.030),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          richText(
                              context: context,
                              title: 'Submits Own Hours',
                              subtitle: '*',
                              fontSize: 14,
                              twoendTextColor: Colors.red,
                              fontWeight1: FontWeight.w500,
                              fontWeight2: FontWeight.w500),
                          getHeight(context: context, height: 0.005),
                          checkWidget(
                            onTap: (index) {
                              provider.changeSubmitOwnHours(index);
                            },
                            context: context,
                            selectedIndex: provider.submitOwnHours,
                          )
                        ],
                      )),
                    ],
                  ),
                  getHeight(context: context, height: 0.010),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          richText(
                              context: context,
                              title: 'TimeSheet Type',
                              subtitle: '*',
                              fontSize: 14,
                              twoendTextColor: Colors.red,
                              fontWeight1: FontWeight.w500,
                              fontWeight2: FontWeight.w500),
                          getHeight(context: context, height: 0.005),
                          const EditSelectTimeSheetTypeWidget(),
                        ],
                      )),
                      getWidth(context: context, width: 0.030),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Client Pays WSIB',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          checkWidget(
                            onTap: (index) {
                              provider.changeClientPaysWSIB(index);
                            },
                            context: context,
                            selectedIndex: provider.clientPaysWSIB,
                          )
                        ],
                      )),
                    ],
                  ),
                  getHeight(context: context, height: 0.010),
                  appText(
                    textAlign: TextAlign.left,
                    context: context,
                    title: 'Payment Notes',
                    fontWeight: FontWeight.w500,
                  ),
                  getHeight(context: context, height: 0.005),
                  editAddWorkerTextField(
                    maxLines: 2,
                    context: context,
                    hintText: 'Enter Payment Notes',
                    controller: provider.paymentNotesController,
                    height: null,
                  ),
                  getHeight(context: context, height: 0.010),
                ],
              ),
            ),
            getHeight(context: context, height: 0.08),
          ],
        ));
      }),
      bottomSheet:
          Consumer<EditWorkerDetailProvider>(builder: (context, provider, __) {
        return SizedBox(
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
                  if (provider.recruiterId == null) {
                    toast(msg: 'Kindly assign recruiter', context: context);
                  } else if (provider.clientIdController.text.isEmpty ||
                      provider.clientIdController.text == '') {
                    toast(msg: 'Client id cannot be empty', context: context);
                  } else if (provider.firstNameController.text.isEmpty ||
                      provider.firstNameController.text == '') {
                    toast(
                        msg: 'Please enter worker first name',
                        context: context);
                  } else if (provider.lastNameController.text.isEmpty ||
                      provider.lastNameController.text == '') {
                    toast(
                        msg: 'Please enter worker last name', context: context);
                  } else if (provider.selectedStatusID == null) {
                    toast(msg: 'please select worker status', context: context);
                  } else if (provider.emailController.text.isEmpty ||
                      provider.emailController.text == '') {
                    toast(
                        msg: 'Please enter worker email address',
                        context: context);
                  } else if (!Constant.regExp
                      .hasMatch(provider.emailController.text)) {
                    toast(
                        msg: 'Please enter valid email address',
                        context: context);
                  } else if (provider.workerPickUpId == null) {
                    toast(
                        msg: 'Please select worker pickup location',
                        context: context);
                  } else if (provider
                          .recruiterCommissionController.text.isEmpty ||
                      provider.recruiterCommissionController.text == '') {
                    toast(
                        msg: 'Please enter recruiter commission',
                        context: context);
                  } else if (provider.timeSheetTypeId == null) {
                    toast(
                        msg: "Please select TimeSheet Type", context: context);
                  } else {
                    provider.addWorkerData(
                      context: context,
                      workerID: int.parse(widget.workerModel.id.toString()),
                      internalWorkerID: provider.workerIdController.text,
                      clientWorkerID: provider.clientIdController.text,
                      age: provider.ageController.text.isEmpty
                          ? null
                          : int.parse(provider.ageController.text),
                      firstName: provider.firstNameController.text,
                      lastName: provider.lastNameController.text,
                      jobSites: provider.selectedJobSitesIDList,
                      recruiterAssingId: provider.recruiterId,
                      dateOfBirth: provider.dobController.text,
                      englishFluency:
                          provider.isEnglishFluence == 0 ? true : false,
                      languageId:
                          provider.selectedLanguageIDList.join(',').toString(),
                      legalToWork: provider.islegalToWork == 0 ? true : false,
                      ownTransport: provider.isOwnTransport == 0 ? true : false,
                      socialInsuranceNo:
                          provider.socialInsuranceController.text,
                      workPermitNo: provider.workPermitController.text,
                      workerHireDate: provider.hireDateController.text,
                      workerTerminateDate:
                          provider.terminationDateController.text,
                      workerStatusId: provider.selectedStatusID,
                      workerFlagId: provider.selectedWorkerFlagIdList
                          .join(',')
                          .toString(),
                      businessWIBSno: provider.businessWSIBNoController.text,
                      pastWIBSClaim: provider.pastWSIBClaim == 0 ? true : false,
                      wibsClaimNotes: provider.wSIBClaimNoteController.text,
                      businessName: provider.businessNameController.text,
                      businessTele: provider.businessTelephoneController.text,
                      address1: provider.address1Controller.text,
                      address2: provider.address2Controller.text,
                      city: provider.cityController.text,
                      province: provider.provinceController.text,
                      postalCode: provider.postalCodeController.text,
                      country: provider.countryController.text,
                      mobile: provider.mobileTelephoneController.text,
                      homeTele: provider.homeTelephoneController.text,
                      email: provider.emailController.text,
                      emergencyContact1:
                          provider.emergencyContact1Controller.text,
                      emergencyContact2:
                          provider.emergencyContact2Controller.text,
                      emergencyTele1:
                          provider.emergencyTelephone1Controller.text,
                      emergencyTele2:
                          provider.emergencyTelephone2Controller.text,
                      tradeOptionId: provider.tradeOptionId,
                      regularRate: provider.regularRateController.text.isEmpty
                          ? null
                          : double.parse(provider.regularRateController.text),
                      overTimeRate: provider.overTimeRateController.text.isEmpty
                          ? null
                          : double.parse(provider.overTimeRateController.text),
                      // clientPayWSIB: provider.clientRateController.text.isEmpty ? null : double.parse(provider.clientRateController.text),
                      workExperience: provider.selectedWorkExperienceIdList
                          .join(',')
                          .toString(),
                      workExperienceNotes:
                          provider.workExperienceNoteController.text,
                      tradeLicenseNo: provider.tradeLicenseNoController.text,
                      unionAffilation: provider.selectedUnionAfflicationIdList
                          .join(',')
                          .toString(),
                      unionAffilationNotes:
                          provider.unionAffiliationNotesController.text,
                      employeHistoryNotes:
                          provider.employmentHistoryNoteController.text,
                      certificationId: provider.selectedcertificateIdList
                          .join(',')
                          .toString(),
                      certificationNotes:
                          provider.certificationNotesController.text,
                      isRecruiterComission:
                          provider.recruiterPaymentDelivery == 0 ? true : false,
                      workerPickupLocation: provider.workerPickUpId,
                      recruiterComission:
                          provider.recruiterCommissionController.text.isEmpty
                              ? null
                              : double.parse(
                                  provider.recruiterCommissionController.text),
                      billRate: provider.clientRateController.text.isEmpty
                          ? null
                          : double.parse(provider.clientRateController.text),
                      submitOwnHours:
                          provider.submitOwnHours == 0 ? true : false,
                      timeSheetType: provider.timeSheetTypeId,
                      paymentNotes: provider.paymentNotesController.text,
                      clientPayWSIB:
                          provider.clientPaysWSIB == 0 ? true : false,
                      whimsFilePath: provider.wHIMSFilePath,
                      otherFilePath: provider.otherFilePath,
                      unionAffliciationId: provider
                          .selectedUnionAfflicationIdList
                          .join(',')
                          .toString(),
                      termsOfEmployeFilePath: provider.termsOfEmpPath,
                      employementReleaseFilePath: provider.empReleasePath,
                      profileImage: provider.pickedImage,
                      workingFormHeightFilePath: provider.workingFormHeightPath,
                      firstAidFilePath: provider.firstAidPath,
                      notes: provider.flagNotesController.text,
                      whimsFileName: provider.wHIMSFileName,
                      profileImageName: provider.pickedImageName,
                      workingFormHeightFileName: provider.workingFormHeightName,
                      otherFileName: provider.otherFileName,
                      termsOfEmployeFileName: provider.termsOfEmpName,
                      firstAidFileName: provider.firstAidName,
                      employementReleaseFileName: provider.empReleaseName,
                    );
                  }
                },
                title: "Update",
              ),
            ],
          ),
        );
      }),
    );
  }
}

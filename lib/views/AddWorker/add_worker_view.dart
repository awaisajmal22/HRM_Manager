import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/back.dart';
import 'package:hrm_manager/constant/check_widget.dart';
import 'package:hrm_manager/constant/constant.dart';
import 'package:hrm_manager/constant/height_box.dart';
import 'package:hrm_manager/constant/rich_text.dart';
import 'package:hrm_manager/constant/text_button.dart';
import 'package:hrm_manager/constant/toast.dart';
import 'package:hrm_manager/constant/width_box.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/add_worker_provider.dart';
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
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import 'component/select_job_site_widget.dart';

class AddWorkerView extends StatefulWidget {
  const AddWorkerView({super.key});

  @override
  State<AddWorkerView> createState() => _AddWorkerViewState();
}

class _AddWorkerViewState extends State<AddWorkerView> {
  late AddWorkerProvider pv;
  bool isSuccess = false;
  @override
  void initState() {
    if (isSuccess == false) {
      loadData();
    }
    super.initState();
  }

  loadData() {
    pv = Provider.of<AddWorkerProvider>(context, listen: false);
    pv.getExperienceData(context: context);
    pv.getJobSiteData(context: context);
    pv.getRecruiterData(context: context);
    pv.getUnionAffliciationData(context: context);
    pv.getLanguagesData(context: context);
    pv.getCertificationList(context: context);
    pv.getWorkerPickupLocationData(context: context);
    pv.getTimeSheetTypeData(context: context);
    pv.getStatusData(context: context);
    pv.getFlagData(context: context);
    pv.getTradeOption(context: context);
    setState(() {
      isSuccess = true;
    });
  }

  @override
  void dispose() {
    pv.clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddWorkerProvider>(builder: (context, provider, __) {
      return Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: context.getSize.height * 0.020),
              color: const Color(0xffE7E0EC),
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
                    title: 'Add Worker',
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
                        height: context.getSize.height * 0.084,
                        width: context.getSize.width * 0.168,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              height: context.getSize.height * 0.084,
                              width: context.getSize.width * 0.168,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: provider.pickedImage != ''
                                      ? DecorationImage(
                                          image: FileImage(
                                              File(provider.pickedImage)),
                                          fit: BoxFit.cover)
                                      : const DecorationImage(
                                          image:
                                              NetworkImage(Constant.dummyImage),
                                          fit: BoxFit.cover)),
                            ),
                            GestureDetector(
                              onTap: () {
                                provider.pickImage();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: context.getSize.height * 0.018,
                                width: context.getSize.width * 0.036,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.whiteColor),
                                child: Icon(
                                  Ionicons.create_outline,
                                  size: context.getSize.height * 0.014,
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
                  addWorkerTextField(
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
                          const SelectRecruiter()
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
                          addWorkerTextField(
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
                  const SelectJobSite(),
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
                          addWorkerTextField(
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
                          addWorkerTextField(
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
                          addWorkerTextField(
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
                          addWorkerTextField(
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
                          const SelectLanguageWidget()
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
                              print(index);
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
                          addWorkerTextField(
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
                          addWorkerTextField(
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
                          addWorkerTextField(
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
                          addWorkerTextField(
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
                          const WorkerStatus()
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
                          const WorkerFlagWidget()
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
                  addWorkerTextField(
                    maxLines: 2,
                    context: context,
                    hintText: 'Enter Notes',
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
                          addWorkerTextField(
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
                  addWorkerTextField(
                    maxLines: 2,
                    context: context,
                    hintText: 'Enter WSIB Claim Notes',
                    controller: provider.wSIBClaimNoteController,
                    height: null,
                  ),
                  getHeight(context: context, height: 0.010),
                  CustomTwoTextFieldWidget(
                    hintLeft: 'Enter Business Name',
                    hintRight: 'Enter Business Telephone',
                    controllerLeft: provider.businessNameController,
                    controllerRight: provider.businessTelephoneController,
                    titleLeft: 'Business Name',
                    titleRight: 'Business Telephone',
                  ),
                  getHeight(context: context, height: 0.010),
                  CustomTwoTextFieldWidget(
                    controllerLeft: provider.address1Controller,
                    controllerRight: provider.address2Controller,
                    titleLeft: 'Address Line 1',
                    titleRight: 'Address Line 2',
                    hintLeft: 'Enter Address Line 1',
                    hintRight: 'Enter Address Line 2',
                  ),
                  getHeight(context: context, height: 0.010),
                  CustomTwoTextFieldWidget(
                    controllerLeft: provider.cityController,
                    controllerRight: provider.provinceController,
                    titleLeft: 'City',
                    titleRight: 'Province',
                    hintLeft: 'Enter City',
                    hintRight: 'Enter Province',
                  ),
                  getHeight(context: context, height: 0.010),
                  CustomTwoTextFieldWidget(
                    rightReadOnly: false,
                    controllerLeft: provider.postalCodeController,
                    controllerRight: provider.countryController,
                    titleLeft: 'Postal Code',
                    titleRight: 'Country',
                    hintLeft: 'Enter Postal Code',
                    hintRight: 'Enter Country',
                  ),
                  getHeight(context: context, height: 0.010),
                  CustomTwoTextFieldWidget(
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
                  addWorkerTextField(
                    context: context,
                    hintText: 'Enter Email Address',
                    controller: provider.emailController,
                    height: context.getSize.height * 0.050,
                  ),
                  getHeight(context: context, height: 0.010),
                  CustomTwoTextFieldWidget(
                    controllerLeft: provider.emergencyContact1Controller,
                    controllerRight: provider.emergencyTelephone1Controller,
                    titleLeft: 'Emergency Contact 1',
                    titleRight: 'Emergency Telephone 1',
                    hintLeft: 'Enter Emergency Contact 1',
                    hintRight: 'Enter Emergency Telephone 1',
                  ),
                  getHeight(context: context, height: 0.010),
                  CustomTwoTextFieldWidget(
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
                          const SelectTradeOption()
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
                          addWorkerTextField(
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
                  CustomTwoTextFieldWidget(
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
                          const SelectWorkExperience()
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
                          addWorkerTextField(
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
                  addWorkerTextField(
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
                          const SelectUnionAffiliation()
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
                          addWorkerTextField(
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
                  addWorkerTextField(
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
                          const SelectCertification()
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
                          addWorkerTextField(
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
                  displayFile(
                    title: "WHIMS",
                    path: provider.wHIMSFileName,
                    context: context,
                    onTap: () {
                      provider.pickWHIMS();
                    },
                  ),
                  getHeight(context: context, height: 0.010),
                  displayFile(
                    title: "Working Form Heights",
                    path: provider.workingFormHeightName,
                    context: context,
                    onTap: () {
                      provider.pickWorkingFormHeightFile();
                    },
                  ),
                  getHeight(context: context, height: 0.010),
                  displayFile(
                    title: "First Aid",
                    path: provider.firstAidName,
                    context: context,
                    onTap: () {
                      provider.pickFirstAidFile();
                    },
                  ),
                  getHeight(context: context, height: 0.010),
                  displayFile(
                    title: "Terms Of Employeement",
                    path: provider.termsOfEmpName,
                    context: context,
                    onTap: () {
                      provider.pickTermsOfEmpFile();
                    },
                  ),
                  getHeight(context: context, height: 0.010),
                  displayFile(
                    title: "mployeement Release",
                    path: provider.empReleaseName,
                    context: context,
                    onTap: () {
                      provider.pickEmpReleaseFile();
                    },
                  ),
                  getHeight(context: context, height: 0.010),
                  displayFile(
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
                              fontSize: 14,
                              title: 'Recruiter Payment Delivery',
                              subtitle: '*',
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
                          const SelectWorkerPickUpLocationWidget()
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
                          addWorkerTextField(
                            textInputType: TextInputType.number,
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
                          const SelectTimeSheetTypeWidget(),
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
                  addWorkerTextField(
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
        )),
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
                fontSize: 16,
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
                        languageId: provider.selectedLanguageIdList
                            .join(', ')
                            .toString(),
                        legalToWork: provider.islegalToWork == 0 ? true : false,
                        ownTransport:
                            provider.isOwnTransport == 0 ? true : false,
                        socialInsuranceNo:
                            provider.socialInsuranceController.text,
                        workPermitNo: provider.workPermitController.text,
                        workerHireDate: provider.hireDateController.text,
                        workerTerminateDate:
                            provider.terminationDateController.text,
                        workerStatusId: provider.selectedStatusID,
                        workerFlagId: provider.selectedWorkerFlagIdList
                            .join(', ')
                            .toString(),
                        businessWIBSno: provider.businessWSIBNoController.text,
                        pastWIBSClaim:
                            provider.pastWSIBClaim == 0 ? true : false,
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
                        billRate: provider.clientRateController.text.isEmpty
                            ? null
                            : double.parse(provider.clientRateController.text),
                        overTimeRate:
                            provider.overTimeRateController.text.isEmpty
                                ? null
                                : double.parse(
                                    provider.overTimeRateController.text),
                        // clientPayWSIB: provider.clientRateController.text.isEmpty ? null : double.parse(provider.clientRateController.text),
                        workExperience: provider.selectedWorkExpIDList
                            .join(', ')
                            .toString(),
                        // provider.workExperienceController.text,
                        workExperienceNotes:
                            provider.workExperienceNoteController.text,
                        tradeLicenseNo: provider.tradeLicenseNoController.text,
                        unionAffilation: provider.selectedUnionAfflicationIdList
                            .join(', ')
                            .toString(),
                        // provider.unionAffiliationController.text,
                        unionAffilationNotes:
                            provider.unionAffiliationNotesController.text,
                        employeHistoryNotes:
                            provider.employmentHistoryNoteController.text,
                        certificationId: provider.selectedcertificateIdList
                            .join(', ')
                            .toString(),
                        // provider.certificateId.toString(),
                        certificationNotes:
                            provider.certificationNotesController.text,
                        isRecruiterComission:
                            provider.recruiterPaymentDelivery == 0
                                ? true
                                : false,
                        workerPickupLocation: provider.workerPickUpId,
                        recruiterComission: provider
                                .recruiterCommissionController.text.isEmpty
                            ? null
                            : double.parse(
                                provider.recruiterCommissionController.text),
                        submitOwnHours:
                            provider.submitOwnHours == 0 ? true : false,
                        timeSheetType: provider.timeSheetTypeId,
                        paymentNotes: provider.paymentNotesController.text,
                        clientPayWSIB:
                            provider.clientPaysWSIB == 0 ? true : false,
                        whimsFilePath: provider.wHIMSFilePath,
                        otherFilePath: provider.otherFilePath,
                        termsOfEmployeFilePath: provider.termsOfEmpPath,
                        employementReleaseFilePath: provider.empReleasePath,
                        profileImage: provider.pickedImage,
                        workingFormHeightFilePath: provider.workingFormHeightPath,
                        firstAidFilePath: provider.firstAidPath,
                        notes: provider.flagNotesController.text);
                  }
                },
                title: "Update",
              ),
            ],
          ),
        ),
      );
    });
  }
}

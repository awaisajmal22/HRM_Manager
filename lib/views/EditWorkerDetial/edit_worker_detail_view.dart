import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/back.dart';
import 'package:hrm_manager/constant/check_widget.dart';
import 'package:hrm_manager/constant/constant.dart';
import 'package:hrm_manager/constant/height_box.dart';
import 'package:hrm_manager/constant/text_button.dart';
import 'package:hrm_manager/constant/width_box.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/add_worker_provider.dart';
import 'package:hrm_manager/provider/edit_worker_detail_provider.dart';
import 'package:hrm_manager/utils/app_color.dart';
import 'package:hrm_manager/views/AddWorker/component/add_worker_field.dart';
import 'package:hrm_manager/views/AddWorker/component/custom_two_textField_widget.dart';
import 'package:hrm_manager/views/AddWorker/component/file_diplayer.dart';
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

class EditWorkerDetailView extends StatelessWidget {
  const EditWorkerDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<EditWorkerDetailProvider>(builder: (context, provider, __) {
        return SafeArea(
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
                  editAddWorkerTextField(
                    context: context,
                    hintText: 'WR00001',
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
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Assigned To Recruiter*',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          const EditSelectRecruiter()
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
                            title: 'Client Worker ID*',
                            fontWeight: FontWeight.w500,
                          ),
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
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Worker First Name*',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          editAddWorkerTextField(
                            context: context,
                            hintText: 'Jovany',
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
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Worker Last Name',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          editAddWorkerTextField(
                            context: context,
                            hintText: 'Italiano',
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
                            textInputType: TextInputType.number,
                            color: Color(0xffF5F5F5),
                            context: context,
                            hintText: '',
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
                            hintText: '',
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
                            hintText: '',
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
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Worker Status*',
                            fontWeight: FontWeight.w500,
                          ),
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
                            hintText: '',
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
                  ),
                  getHeight(context: context, height: 0.010),
                  EditCustomTwoTextFieldWidget(
                    controllerLeft: provider.address1Controller,
                    controllerRight: provider.address2Controller,
                    titleLeft: 'Address Line 1',
                    titleRight: 'Address Line 2',
                  ),
                  getHeight(context: context, height: 0.010),
                 EditCustomTwoTextFieldWidget(
                    controllerLeft: provider.cityController,
                    controllerRight: provider.provinceController,
                    titleLeft: 'City',
                    titleRight: 'Province',
                  ),
                  getHeight(context: context, height: 0.010),
                  EditCustomTwoTextFieldWidget(
                    rightReadOnly: true,
                    controllerLeft: provider.postalCodeController,
                    controllerRight: provider.countryController,
                    titleLeft: 'Postal Code',
                    titleRight: 'Country',
                  ),
                  getHeight(context: context, height: 0.010),
                  EditCustomTwoTextFieldWidget(
                    controllerLeft: provider.mobileTelephoneController,
                    controllerRight: provider.homeTelephoneController,
                    titleLeft: 'Mobile Telephone',
                    titleRight: 'Home Telephone',
                  ),
                  getHeight(context: context, height: 0.010),
                  appText(
                    textAlign: TextAlign.left,
                    context: context,
                    title: 'Email*',
                    fontWeight: FontWeight.w500,
                  ),
                  getHeight(context: context, height: 0.005),
                  editAddWorkerTextField(
                    context: context,
                    hintText: '',
                    controller: provider.emailController,
                    height: context.getSize.height * 0.050,
                  ),
                  getHeight(context: context, height: 0.010),
                  EditCustomTwoTextFieldWidget(
                    controllerLeft: provider.emergencyContact1Controller,
                    controllerRight: provider.emergencyTelephone1Controller,
                    titleLeft: 'Emergency Contact 1',
                    titleRight: 'Emergency Telephone 1',
                  ),
                  getHeight(context: context, height: 0.010),
                  EditCustomTwoTextFieldWidget(
                    controllerLeft: provider.emergencyContact2Controller,
                    controllerRight: provider.emergencyTelephone2Controller,
                    titleLeft: 'Emergency Contact 2',
                    titleRight: 'Emergency Telephone 2',
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
                            textInputType: TextInputType.number,
                            context: context,
                            hintText: '',
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
                            hintText: '',
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
                    hintText: '',
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
                            hintText: '',
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
                    hintText: '',
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
                            hintText: '',
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
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Recruiter Payment Delivery*',
                            fontWeight: FontWeight.w500,
                          ),
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
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Worker Pick Up Location*',
                            fontWeight: FontWeight.w500,
                          ),
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
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Recruiter Commission*',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          editAddWorkerTextField(
                            context: context,
                            hintText: '',
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
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Submits Own Hours',
                            fontWeight: FontWeight.w500,
                          ),
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
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'TimeSheet Type*',
                            fontWeight: FontWeight.w500,
                          ),
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
                    hintText: '',
                    controller: provider.paymentNotesController,
                    height: null,
                  ),
                  getHeight(context: context, height: 0.010),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.getSize.width * 0.30),
                      child: textButton(
                        vPadding: 0.020,
                        radius: 100,
                        context: context,
                        onTap: () {},
                        title: "Update",
                      )),
                ],
              ),
            ),
          ],
        ));
      }),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/back.dart';
import 'package:hrm_manager/constant/check_widget.dart';
import 'package:hrm_manager/constant/height_box.dart';
import 'package:hrm_manager/constant/width_box.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/add_worker_provider.dart';
import 'package:hrm_manager/utils/app_color.dart';
import 'package:hrm_manager/views/AddWorker/component/add_worker_field.dart';
import 'package:hrm_manager/views/AddWorker/component/custom_two_textField_widget.dart';
import 'package:hrm_manager/views/AddWorker/component/select_language_widget.dart';
import 'package:hrm_manager/views/AddWorker/component/select_recruiter.dart';
import 'package:hrm_manager/views/AddWorker/component/trade_option_widget.dart';
import 'package:hrm_manager/views/AddWorker/component/work_experience_widget.dart';
import 'package:hrm_manager/views/AddWorker/component/worker_flag_widget.dart';
import 'package:hrm_manager/views/AddWorker/component/worker_status.dart';
import 'package:provider/provider.dart';

import 'component/select_job_site_widget.dart';

class AddWorkerView extends StatelessWidget {
  const AddWorkerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AddWorkerProvider>(builder: (context, provider, __) {
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
                  appText(
                    textAlign: TextAlign.left,
                    context: context,
                    title: 'Internal Worker ID:',
                    fontWeight: FontWeight.w500,
                  ),
                  getHeight(context: context, height: 0.005),
                  addWorkerTextField(
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
                          const SelectRecruiter()
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
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Worker First Name*',
                            fontWeight: FontWeight.w500,
                          ),
                          getHeight(context: context, height: 0.005),
                          addWorkerTextField(
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
                          addWorkerTextField(
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
                          SelectLanguageWidget()
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
                          addWorkerTextField(
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
                          addWorkerTextField(
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
                          appText(
                            textAlign: TextAlign.left,
                            context: context,
                            title: 'Worker Status*',
                            fontWeight: FontWeight.w500,
                          ),
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
                          addWorkerTextField(
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
                  addWorkerTextField(
                    maxLines: 2,
                    context: context,
                    hintText: '',
                    controller: provider.wSIBClaimNoteController,
                    height: null,
                  ),
                  getHeight(context: context, height: 0.010),
                  CustomTwoTextFieldWidget(
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
                  ),
                  getHeight(context: context, height: 0.010),
                  CustomTwoTextFieldWidget(
                    controllerLeft: provider.cityController,
                    controllerRight: provider.provinceController,
                    titleLeft: 'City',
                    titleRight: 'Province',
                  ),
                  getHeight(context: context, height: 0.010),
                  CustomTwoTextFieldWidget(
                    rightReadOnly: true,
                    controllerLeft: provider.postalCodeController,
                    controllerRight: provider.countryController,
                    titleLeft: 'Postal Code',
                    titleRight: 'Country',
                  ),
                  getHeight(context: context, height: 0.010),
                  CustomTwoTextFieldWidget(
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
                  addWorkerTextField(
                    context: context,
                    hintText: '',
                    controller: provider.emailController,
                    height: context.getSize.height * 0.050,
                  ),
                  getHeight(context: context, height: 0.010),
                  CustomTwoTextFieldWidget(
                    controllerLeft: provider.emergencyContact1Controller,
                    controllerRight: provider.emergencyTelephone1Controller,
                    titleLeft: 'Emergency Contact 1',
                    titleRight: 'Emergency Telephone 1',
                  ),
                  getHeight(context: context, height: 0.010),
                  CustomTwoTextFieldWidget(
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
                            hintText: '',
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
                            textInputType: TextInputType.number,
                            context: context,
                            hintText: '',
                            controller: provider.workExperienceNoteController,
                            height: context.getSize.height * 0.050,
                          ),
                        ],
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
      }),
    );
  }
}

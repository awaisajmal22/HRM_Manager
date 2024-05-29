import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/drop_down.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/add_worker_provider.dart';
import 'package:hrm_manager/views/AddWorker/component/add_worker_field.dart';
import 'package:provider/provider.dart';

class SelectWorkExperience extends StatelessWidget {
  const SelectWorkExperience({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddWorkerProvider>(builder: (context, provider, __) {
      return GestureDetector(
        onTap: () async {
          String value = provider.workerExperienceUnSelectedList.isEmpty
              ? ''
              : await customDropDown(
                  dataList: provider.workerExperienceUnSelectedList,
                  context: context,
                );
          if (value != '') {
            for (var data in provider.workerExperienceUnSelectedList) {
              if (data.name == value) {
                provider.selectWorkExperience(value, data.id!);
                provider.removeWorkExperienceFromUnselected(data.id!);
                break;
              }
            }
          }
        },
        child: Container(
          alignment: Alignment.centerLeft,
          height: provider.selectedWorkExpList.isEmpty
              ? context.getSize.height * 0.050
              : null,
          width: provider.selectedWorkExpList.isEmpty
              ? context.getSize.width
              : null,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color(0xffF5F5F5),
                width: 1,
              )),
          child: provider.selectedWorkExpList.isEmpty
              ? appText(
                  context: context,
                  title: 'Select',
                  textColor: AppColor.lightPurpleColor.withOpacity(0.67))
              : Wrap(
                  spacing: 10,
                  runSpacing: 0,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  alignment: WrapAlignment.start,
                  children: List.generate(
                    provider.selectedWorkExpList.length,
                    (index) => Chip(
                      onDeleted: () {
                        provider.removeWorkExperienceFromField(
                            provider.selectedWorkExpIDList[index],
                            provider.selectedWorkExpList[index]);
                      },
                      shape: const StadiumBorder(
                          side: BorderSide(color: Colors.transparent)),
                      backgroundColor: AppColor.lightPinkColor,
                      label: appText(
                        context: context,
                        title: provider.selectedWorkExpList[index],
                      ),
                    ),
                    growable: true,
                  ),
                ),
        ),
      );

      // addWorkerTextField(
      //   context: context,
      //   hintText: 'Select',
      //   controller: provider.workExperienceController,
      //   height: context.getSize.height * 0.050,
      //   readOnly: true,
      //   onTap: () async {
      //     final String workExp = await customDropDown(
      //       dataList: provider.workerExperienceList,
      //       context: context,
      //     );
      //     if (workExp != '') {
      //       provider.selectWorkExperience(workExp);
      //     }
      //   },
      // );
    });
  }
}

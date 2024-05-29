import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/drop_down.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/add_worker_provider.dart';
import 'package:hrm_manager/provider/edit_worker_detail_provider.dart';
import 'package:hrm_manager/views/EditWorkerDetial/component/edit_add_worker_field.dart';

import 'package:provider/provider.dart';

class EditSelectWorkExperience extends StatelessWidget {
  const EditSelectWorkExperience({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EditWorkerDetailProvider>(builder: (context, provider, __) {
      return GestureDetector(
        onTap: () async {
          String value = provider.workerExperienceList.isEmpty
              ? ''
              : await customDropDown(
                  dataList: provider.workerExperienceList,
                  context: context,
                );
          if (value != '') {
            for (var data in provider.workerExperienceList) {
              if (data.name == value) {
                provider.selectWorkExperience(value, data.id!);

                provider.removeSelectedWorkExperience(data.id!);
                break;
              }
            }
          }
        },
        child: Container(
          alignment: Alignment.centerLeft,
          height: provider.selectedWorkExperienceList.isEmpty
              ? context.getSize.height * 0.050
              : null,
          width: provider.selectedWorkExperienceList.isEmpty
              ? context.getSize.width
              : null,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color(0xffF5F5F5),
                width: 1,
              )),
          child: provider.selectedWorkExperienceList.isEmpty
              ? appText(
                  context: context,
                  title: 'Select',
                  textColor: AppColor.lightPurpleColor.withOpacity(
                    0.67,
                  ))
              : Wrap(
                  spacing: 10,
                  runSpacing: 0,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  alignment: WrapAlignment.start,
                  children: List.generate(
                    provider.selectedWorkExperienceList.length,
                    (index) => Chip(
                      onDeleted: () {
                        provider.removeWorkExperience(
                            provider.selectedWorkExperienceIdList[index],
                            provider.selectedWorkExperienceList[index]);
                      },
                      shape: const StadiumBorder(
                          side: BorderSide(color: Colors.transparent)),
                      backgroundColor: AppColor.lightPinkColor,
                      label: appText(
                        context: context,
                        title: provider.selectedWorkExperienceList[index],
                      ),
                    ),
                    growable: true,
                  ),
                ),
        ),
      );
      // editAddWorkerTextField(
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

import 'package:flutter/material.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/back.dart';
import 'package:hrm_manager/constant/drop_down.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/add_worker_provider.dart';
import 'package:hrm_manager/provider/edit_worker_detail_provider.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:hrm_manager/views/EditWorkerDetial/component/edit_add_worker_field.dart';
import 'package:provider/provider.dart';

class EditWorkerFlagWidget extends StatelessWidget {
  const EditWorkerFlagWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<EditWorkerDetailProvider>(builder: (context, provider, __) {
      return
//        editAddWorkerTextField(
//         context: context,
//         hintText: 'Select',
//         controller: provider.workExperienceController,
//         height: context.getSize.height * 0.050,
//         readOnly: true,
//         onTap: () async {
//           final String workExp = await customDropDown(
//             dataList: provider.workerFlagList,
//             context: context,
//           );
//           if (workExp != '') {
//             for(var data in provider.workerFlagList){
// if(data.name == workExp){
//   provider.selectWorkerFlag(workExp,data.id!);
// }
//             }
//             // provider.selectWorkExperience(workExp);
//           }
//         },
//       );
          // });
          GestureDetector(
        onTap: () async {
          String value = provider.workerFlagList.isEmpty
              ? ''
              : await customDropDown(
                  dataList: provider.workerFlagList,
                  context: context,
                );
          if (value != '') {
            for (var data in provider.workerFlagList) {
              if (data.name == value) {
                provider.selectWorkerFlag(value, data.id!);
                provider.removeSelectedFlag(data.id!);
                break;
              }
            }
          }
        },
        child: Container(
          alignment: Alignment.centerLeft,
          height: provider.selectedWorkerFlagList.isEmpty
              ? context.getSize.height * 0.050
              : null,
          width: provider.selectedWorkerFlagList.isEmpty
              ? context.getSize.width
              : null,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color(0xffF5F5F5),
                width: 1,
              )),
          child: provider.selectedWorkerFlagList.isEmpty
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
                    provider.selectedWorkerFlagList.length,
                    (index) => Chip(
                      onDeleted: () {
                        provider.removeWorkerFlag(
                            provider.selectedWorkerFlagIdList[index],
                            provider.selectedWorkerFlagList[index]);
                      },
                      shape: const StadiumBorder(
                          side: BorderSide(color: Colors.transparent)),
                      backgroundColor: AppColor.lightPinkColor,
                      label: appText(
                        context: context,
                        title: provider.selectedWorkerFlagList[index],
                      ),
                    ),
                    growable: true,
                  ),
                ),
        ),
      );
    });
  }
}

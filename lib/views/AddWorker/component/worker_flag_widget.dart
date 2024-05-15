import 'package:flutter/material.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/back.dart';
import 'package:hrm_manager/constant/drop_down.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/add_worker_provider.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:hrm_manager/views/AddWorker/component/add_worker_field.dart';
import 'package:provider/provider.dart';

class WorkerFlagWidget extends StatelessWidget {
  const WorkerFlagWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AddWorkerProvider>(builder: (context, provider, __) {
      return GestureDetector(
        onTap: () async {
          String flag = await customDropDown(
            dataList: provider.workerFlagList,
            context: context,
          );
          if (flag != '') {
            for (var data in provider.workerFlagList)
              if (data.name == flag) {
                provider.selectWorkerFlag(flag, data.id!);
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
                  textColor: AppColor.lightPurpleColor.withOpacity(0.67))
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
                        provider.removeWorkerFlag(index);
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

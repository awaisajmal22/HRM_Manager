import 'package:flutter/material.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/back.dart';
import 'package:hrm_manager/constant/drop_down.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/add_worker_provider.dart';
import 'package:hrm_manager/provider/edit_worker_detail_provider.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:hrm_manager/views/AddWorker/component/add_worker_field.dart';
import 'package:provider/provider.dart';

class EditSelectTimeSheetTypeWidget extends StatelessWidget {
  const EditSelectTimeSheetTypeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<EditWorkerDetailProvider>(builder: (context, provider, __) {
      return addWorkerTextField(
        context: context,
        hintText: 'Select TimeSheet Type',
        controller: provider.timeSheetTypeController,
        height: context.getSize.height * 0.050,
        readOnly: true,
        onTap: () async {
          final String timeSheet = await customDropDown(
            dataList: provider.timeSheetTypeList,
            context: context,
          );
          if (timeSheet != '') {
            for(var data in provider.timeSheetTypeList){
              if(data.name == timeSheet){
            provider.changeTimeSheetType(timeSheet,data.id!);
            }
            }
          }
        },
      );
    });
  }
}

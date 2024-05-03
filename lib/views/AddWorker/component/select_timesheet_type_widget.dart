import 'package:flutter/material.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/back.dart';
import 'package:hrm_manager/constant/drop_down.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/add_worker_provider.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:hrm_manager/views/AddWorker/component/add_worker_field.dart';
import 'package:provider/provider.dart';

class SelectTimeSheetTypeWidget extends StatelessWidget {
  const SelectTimeSheetTypeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AddWorkerProvider>(builder: (context, provider, __) {
      return addWorkerTextField(
        context: context,
        hintText: 'Select TimeSheet Tpe',
        controller: provider.timeSheetTypeController,
        height: context.getSize.height * 0.050,
        readOnly: true,
        onTap: () async {
          final String timeSheet = await customDropDown(
            dataList: provider.timeSheetTypeList,
            context: context,
          );
          if (timeSheet != '') {
            provider.changeTimeSheetType(timeSheet);
          }
        },
      );
    });
  }
}

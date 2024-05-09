import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrm_manager/constant/drop_down.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/add_worker_provider.dart';
import 'package:hrm_manager/provider/edit_worker_detail_provider.dart';
import 'package:hrm_manager/views/EditWorkerDetial/component/edit_add_worker_field.dart';

import 'package:provider/provider.dart';

class EditWorkerStatus extends StatelessWidget {
  const EditWorkerStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EditWorkerDetailProvider>(builder: (context, provider, __) {
      return editAddWorkerTextField(
        context: context,
        hintText: '',
        controller: provider.statusController,
        height: context.getSize.height * 0.050,
        readOnly: true,
        onTap: () async {
          final String status = await customDropDown(
            dataList: provider.workerStatusList,
            context: context,
          );
          if (status != '') {
            for(var data in provider.workerStatusList){
              if(data.name == status)
            provider.selectStatus(status,data.id!);
            }
          }
        },
      );
    });
  }
}

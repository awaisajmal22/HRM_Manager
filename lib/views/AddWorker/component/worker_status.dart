import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrm_manager/constant/drop_down.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/add_worker_provider.dart';
import 'package:hrm_manager/views/AddWorker/component/add_worker_field.dart';
import 'package:provider/provider.dart';

class WorkerStatus extends StatelessWidget {
  const WorkerStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddWorkerProvider>(builder: (context, provider, __) {
      return addWorkerTextField(
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
            for(var data in provider.workerStatusList)
            if(data.name == status){
            provider.selectStatus(status,data.id!);
            }
          }
        },
      );
    });
  }
}

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

class EditSelectWorkerPickUpLocationWidget extends StatelessWidget {
  const EditSelectWorkerPickUpLocationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<EditWorkerDetailProvider>(builder: (context, provider, __) {
      return editAddWorkerTextField(
        context: context,
        hintText: 'Select',
        controller: provider.workerPickUpLocationController,
        height: context.getSize.height * 0.050,
        readOnly: true,
        onTap: () async {
          final String location = await customDropDown(
            dataList: provider.workerPickUpLocationList,
            context: context,
          );
          if (location != '') {
            for(var data in provider.workerPickUpLocationList){
              if(data.name == location){
 provider.selectWorkerPickupLocation(location,data.id!);
              }
            }
           
          }
        },
      );
    });
  }
}

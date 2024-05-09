import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      return editAddWorkerTextField(
        context: context,
        hintText: 'Select',
        controller: provider.workExperienceController,
        height: context.getSize.height * 0.050,
        readOnly: true,
        onTap: () async {
          final String workExp = await customDropDown(
            dataList: provider.workerExperienceList,
            context: context,
          );
          if (workExp != '') {
            provider.selectWorkExperience(workExp);
          }
        },
      );
    });
  }
}

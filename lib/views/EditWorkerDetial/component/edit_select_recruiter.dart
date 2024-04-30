import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrm_manager/constant/drop_down.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/add_worker_provider.dart';
import 'package:hrm_manager/provider/edit_worker_detail_provider.dart';
import 'package:hrm_manager/views/AddWorker/component/add_worker_field.dart';
import 'package:provider/provider.dart';

class EditSelectRecruiter extends StatelessWidget {
  const EditSelectRecruiter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EditWorkerDetailProvider>(builder: (context, provider, __) {
      return addWorkerTextField(
        context: context,
        hintText: 'RC1',
        controller: provider.recruiterController,
        height: context.getSize.height * 0.050,
        readOnly: true,
        onTap: () async {
          final String recruiter = await customDropDown(
            dataList: provider.recruiterList,
            context: context,
          );
          if (recruiter != '') {
            provider.selectRecruiter(recruiter);
          }
        },
      );
    });
  }
}

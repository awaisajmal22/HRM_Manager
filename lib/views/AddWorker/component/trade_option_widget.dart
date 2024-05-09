import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrm_manager/constant/drop_down.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/add_worker_provider.dart';
import 'package:hrm_manager/views/AddWorker/component/add_worker_field.dart';
import 'package:provider/provider.dart';

class SelectTradeOption extends StatelessWidget {
  const SelectTradeOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddWorkerProvider>(builder: (context, provider, __) {
      return addWorkerTextField(
        context: context,
        hintText: 'Select',
        controller: provider.tradeOptionController,
        height: context.getSize.height * 0.050,
        readOnly: true,
        onTap: () async {
          final String tradeOption = await tradeDropDown(
            dataList: provider.tradeOptionList,
            context: context,
          );
          if (tradeOption != '') {
            for(var data in provider.tradeOptionList){
              if(data.tradeOptionName == tradeOption){
            provider.selectTradeOption(tradeOption,data.id!);
              }}
          }
        },
      );
    });
  }
}

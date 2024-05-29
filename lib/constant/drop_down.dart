
import 'package:flutter/material.dart';
import 'package:hrm_manager/Model/add_worker_drop_down_model.dart';
import 'package:hrm_manager/Model/all_trades_model.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/constant/app_color.dart';




customDropDown({
  required BuildContext context,
  required List<AddWorkerDropDownModel> dataList,

}) async {
  final menu = await showMenu(
      constraints: BoxConstraints(
        maxWidth: context.getSize.width * 1,
        minWidth: context.getSize.width * 1,
      ),
      context: context,
      position: RelativeRect.fromLTRB(0, context.getSize.height * 0.40, 0, 0),
      items: List.generate(
        dataList.length,
        (index) => PopupMenuItem(
          child: Text(dataList[index].name!),
          value: dataList[index].name,
        ),
      ),
      );
  return menu ?? '';
  
}


tradeDropDown({
  required BuildContext context,
  required List<AllTradeModel> dataList,

}) async {
  final menu = await showMenu(
      constraints: BoxConstraints(
        maxWidth: context.getSize.width * 1,
        minWidth: context.getSize.width * 1,
      ),
      context: context,
      position: RelativeRect.fromLTRB(0, context.getSize.height * 0.40, 0, 0),
      items: List.generate(
        dataList.length,
        (index) => PopupMenuItem(
          child: Text(dataList[index].tradeOptionName!),
          value: dataList[index].tradeOptionName,
        ),
      ));
  return menu ?? '';
  
}


import 'package:flutter/material.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/constant/app_color.dart';




customDropDown({
  required BuildContext context,
  required List<String> dataList,

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
          child: Text(dataList[index]),
          value: dataList[index],
        ),
      ));
  return menu ?? '';
  
}


import 'package:flutter/material.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/utils/app_color.dart';

typedef OnSelect = Function(String);
// showDropDown(
//     {required BuildContext context,
//     required List<String> dataList,
//     required OnSelect onSelect}) {
//   return showGeneralDialog(
//       pageBuilder: (context, animation, secondaryAnimation) =>
//           const SizedBox.shrink(),
//       // barrierColor: Colors.transparent,
//       context: context,
//       transitionBuilder: ((context, animation, secondaryAnimation, __) {
//         return Dialog(
//           insetPadding: const EdgeInsets.all(0),
//           child: Container(
//               height: context.getSize.height * 0.7,
//               width: context.getSize.width * 0.6,
//               padding: EdgeInsets.symmetric(
//                 horizontal: context.getSize.width * 0.020,
//                 vertical: context.getSize.height * 0.010,
//               ),
//               decoration: BoxDecoration(
//                 color: AppColor.lightPinkColor,
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: List.generate(
//                     dataList.length,
//                     (index) => GestureDetector(
//                           onTap: () {
//                             onSelect(dataList[index]);
//                           },
//                           child: Container(
//                             alignment: Alignment.centerLeft,
//                             padding: EdgeInsets.symmetric(
//                               horizontal: context.getSize.width * 0.020,
//                               vertical: context.getSize.height * 0.010,
//                             ),
//                             decoration: BoxDecoration(
//                                 border: index == 0
//                                     ? null
//                                     : Border.symmetric(
//                                         horizontal: BorderSide(
//                                         color:
//                                             AppColor.grayColor.withOpacity(0.1),
//                                         width: 1,
//                                       ))),
//                             child: appText(
//                                 context: context,
//                                 title: dataList[index],
//                                 fontSize: 18),
//                           ),
//                         )),
//               )),
//         );
//       }));
// }

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

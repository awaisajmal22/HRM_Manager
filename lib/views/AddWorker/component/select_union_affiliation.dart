import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/drop_down.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/add_worker_provider.dart';
import 'package:hrm_manager/views/AddWorker/component/add_worker_field.dart';
import 'package:provider/provider.dart';

class SelectUnionAffiliation extends StatelessWidget {
  const SelectUnionAffiliation({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddWorkerProvider>(builder: (context, provider, __) {
      return GestureDetector(
        onTap: () async {
          String value = await customDropDown(
            dataList: provider.unionAfflicationList,
            context: context,
          );
          if (value != '') {
            for (var data in provider.unionAfflicationList) {
              if (data.name == value) {
                provider.selectUnionAffiliation(value, data.id!);
              }
            }
          }
        },
        child: Container(
          alignment: Alignment.centerLeft,
          height: provider.selectedUnionAfflicationList.isEmpty
              ? context.getSize.height * 0.050
              : null,
          width: provider.selectedUnionAfflicationList.isEmpty
              ? context.getSize.width
              : null,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color(0xffF5F5F5),
                width: 1,
              )),
          child: provider.selectedUnionAfflicationList.isEmpty
              ? appText(
                  context: context,
                  title: 'Select',
                  textColor: AppColor.lightPurpleColor.withOpacity(0.67))
              :  Wrap(
            spacing: 10,
            runSpacing: 0,
            direction: Axis.horizontal,
            runAlignment: WrapAlignment.start,
            alignment: WrapAlignment.start,
            children: List.generate(
              provider.selectedUnionAfflicationList.length,
              (index) => Chip(
                onDeleted: () {
                  provider.removeUnionAfflication(index);
                },
                shape: const StadiumBorder(
                    side: BorderSide(color: Colors.transparent)),
                backgroundColor: AppColor.lightPinkColor,
                label: appText(
                  context: context,
                  title: provider.selectedUnionAfflicationList[index],
                ),
              ),
              growable: true,
            ),
          ),
        ),
      );

      // addWorkerTextField(
      //   context: context,
      //   hintText: 'Select',
      //   controller: provider.unionAffiliationController,
      //   height: context.getSize.height * 0.050,
      //   readOnly: true,
      //   onTap: () async {
      //     final String affiliation = await customDropDown(
      //       dataList: provider.unionAfflicationList,
      //       context: context,
      //     );
      //     if (affiliation != '') {
      //       provider.selectUnionAffiliation(affiliation);
      //     }
      //   },
      // );
    });
  }
}

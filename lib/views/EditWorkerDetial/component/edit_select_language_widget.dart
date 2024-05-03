import 'package:flutter/material.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/back.dart';
import 'package:hrm_manager/constant/drop_down.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/add_worker_provider.dart';
import 'package:hrm_manager/provider/edit_worker_detail_provider.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:provider/provider.dart';

class EditSelectLanguageWidget extends StatelessWidget {
  const EditSelectLanguageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<EditWorkerDetailProvider>(builder: (context, provider, __) {
      return GestureDetector(
        onTap: () async{
         String value = await customDropDown(
              dataList: provider.languagesList,
              context: context,
              );
              if(value != ''){
                provider.selectLanguage(value);
              }
        },
        child: Container(
          alignment: Alignment.centerLeft,
          height: provider.selectedLanguageList.isEmpty
              ? context.getSize.height * 0.050
              : null,
          width: provider.selectedLanguageList.isEmpty
              ? context.getSize.width
              : null,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color(0xffF5F5F5),
                width: 1,
              )),
          child: Wrap(
            spacing: 10,
            runSpacing: 0,
            direction: Axis.horizontal,
            runAlignment: WrapAlignment.start,
            alignment: WrapAlignment.start,
            children: List.generate(
              provider.selectedLanguageList.length,
              (index) => Chip(
                onDeleted: () {
                  provider.removeSelectedLanguage(index);
                },
                shape: const StadiumBorder(
                    side: BorderSide(color: Colors.transparent)),
                backgroundColor: AppColor.lightPinkColor,
                label: appText(
                  context: context,
                  title: provider.selectedLanguageList[index],
                ),
              ),
              growable: true,
            ),
          ),
        ),
      );
    });
  }
}

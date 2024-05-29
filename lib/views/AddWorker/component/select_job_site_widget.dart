import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/back.dart';
import 'package:hrm_manager/constant/drop_down.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/add_worker_provider.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:provider/provider.dart';

class SelectJobSite extends StatelessWidget {
  const SelectJobSite({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AddWorkerProvider>(builder: (context, provider, __) {
      return GestureDetector(
        onTap: () async {
          final String selectedSite = provider.jobSitesUnSelectedList.isEmpty ? '': await customDropDown(
            dataList: provider.jobSitesUnSelectedList,
            context: context,
          );
          if (selectedSite != '') {
            for (var job in provider.jobSitesUnSelectedList) {
              if (job.name == selectedSite) {
                provider.selectJobSite(selectedSite, job.id!);
                provider.removeWorkJobSiteFromUnselected(job.id!);
                break;
              }
            }
          }
        },
        child: Container(
          alignment: Alignment.centerLeft,
          height: provider.selectedJobSitesList.isEmpty
              ? context.getSize.height * 0.050
              : null,
          width: provider.selectedJobSitesList.isEmpty
              ? context.getSize.width
              : null,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.black.withOpacity(0.06),
                width: 1,
              )),
          child: provider.selectedJobSitesList.isEmpty
              ? appText(
                  context: context,
                  title: 'Select',
                  textColor: AppColor.lightPurpleColor.withOpacity(0.67))
              : Wrap(
                  spacing: 10,
                  runSpacing: 0,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  alignment: WrapAlignment.start,
                  children: List.generate(
                    provider.selectedJobSitesList.length,
                    (index) => Chip(
                      onDeleted: () {
                        provider.removeJobSiteFromField(
                            provider.selectedJobSitesIDList[index],
                            provider.selectedJobSitesList[index]);
                      },
                      shape: const StadiumBorder(
                          side: BorderSide(color: Colors.transparent)),
                      backgroundColor: AppColor.lightPinkColor,
                      label: appText(
                        context: context,
                        title: provider.selectedJobSitesList[index],
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

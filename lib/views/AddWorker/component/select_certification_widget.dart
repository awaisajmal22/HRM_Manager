import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/drop_down.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/add_worker_provider.dart';
import 'package:hrm_manager/views/AddWorker/component/add_worker_field.dart';
import 'package:provider/provider.dart';

class SelectCertification extends StatelessWidget {
  const SelectCertification({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddWorkerProvider>(builder: (context, provider, __) {
      return GestureDetector(
        onTap: () async {
          String value = provider.certificationUnSelectedList.isEmpty
              ? ''
              : await customDropDown(
                  dataList: provider.certificationUnSelectedList,
                  context: context,
                );
          if (value != '') {
            for (var data in provider.certificationUnSelectedList) {
              if (data.name == value) {
                print("${data.name}, ${data.id}");
                provider.selectCertificate(value, data.id!);
                provider.removeCertificateFromUnselected(data.id!);
                break;
              }
            }
          }
        },
        child: Container(
          alignment: Alignment.centerLeft,
          height: provider.selectedcertificateList.isEmpty
              ? context.getSize.height * 0.050
              : null,
          width: provider.selectedcertificateList.isEmpty
              ? context.getSize.width
              : null,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color(0xffF5F5F5),
                width: 1,
              )),
          child: provider.selectedcertificateList.isEmpty
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
                    provider.selectedcertificateList.length,
                    (index) => Chip(
                      onDeleted: () {
                        print(
                            "${provider.selectedcertificateIdList[index]},${provider.selectedcertificateList[index]}");
                        provider.removeCertificateFromField(
                            provider.selectedcertificateIdList[index],
                            provider.selectedcertificateList[index]);
                      },
                      shape: const StadiumBorder(
                          side: BorderSide(color: Colors.transparent)),
                      backgroundColor: AppColor.lightPinkColor,
                      label: appText(
                        context: context,
                        title: provider.selectedcertificateList[index],
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
      //   controller: provider.certificationController,
      //   height: context.getSize.height * 0.050,
      //   readOnly: true,
      //   onTap: () async {
      //     final String certificate = await customDropDown(
      //       dataList: provider.certificationList,
      //       context: context,
      //     );
      //     if (certificate != '') {
      //       for (var data in provider.certificationList) {
      //         if (data.name == certificate) {
      //           provider.selectCertificate(certificate, data.id!);
      //         }
      //       }
      //     }
      //   },
      // );
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrm_manager/Model/worker_status_and_flag_model.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/drop_down_form_field.dart';
import 'package:hrm_manager/constant/height_box.dart';
import 'package:hrm_manager/constant/location_search_field.dart';
import 'package:hrm_manager/constant/text_button.dart';
import 'package:hrm_manager/constant/toast.dart';
import 'package:hrm_manager/constant/width_box.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/avaliable_worker_provider.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:hrm_manager/views/AvaliableWorker/component/min_max_text_field.dart';
import 'package:provider/provider.dart';

class FilterWidget extends StatelessWidget {
  final String name;
  final int id;
  final String location;
  const FilterWidget(
      {super.key,
      required this.name,
      required this.id,
      required this.location});

  @override
  Widget build(BuildContext context) {
    return Consumer<AvaliableWorkerProvider>(builder: (context, provider, __) {
      return provider.isFilterOpen == false
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeight(context: context, height: 0.010),
                Wrap(
                  spacing: 10,
                  runSpacing: 0,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  alignment: WrapAlignment.start,
                  children: List.generate(
                    provider.filteredList.length,
                    (index) => Chip(
                      onDeleted: () {
                        provider.removeFilter(index, context);
                      },
                      deleteIconColor: AppColor.whiteColor,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.transparent,
                            width: 0,
                          ),
                          borderRadius: BorderRadius.circular(8.0)),
                      backgroundColor: AppColor.purpleColor,
                      label: appText(
                          context: context,
                          title: provider.filteredList[index],
                          textColor: AppColor.whiteColor),
                    ),
                    growable: true,
                  ),
                ),
                provider.filteredList.isNotEmpty
                    ? getHeight(context: context, height: 0.01)
                    : const SizedBox.shrink(),
                provider.filteredList.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          appText(
                              context: context,
                              title:
                                  '${provider.filtrationResponseList.length} results for "$name"',
                              textColor: AppColor.lightPurpleColor)
                        ],
                      )
                    : const SizedBox.shrink()
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeight(context: context, height: 0.010),
                locationSearchField(
                    context: context,
                    hintText: 'Toronto',
                    controller: provider.locationController..text = location,
                    height: context.getSize.height * 0.048,
                    onChanged: (val) {},
                    cancel: () {
                      provider.locationController.clear();
                    }),
                getHeight(context: context, height: 0.010),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.my_location,
                      color: AppColor.iconColor,
                    ),
                    getWidth(context: context, width: 0.010),
                    appText(
                      fontWeight: FontWeight.w500,
                      context: context,
                      title: 'Current Location',
                      fontSize: 16,
                      textColor: AppColor.iconColor,
                    )
                  ],
                ),
                getHeight(context: context, height: 0.010),
                appText(
                  fontWeight: FontWeight.w500,
                  context: context,
                  title: 'Status',
                  fontSize: 16,
                  textColor: AppColor.iconColor,
                ),
                getWidth(context: context, width: 0.005),
                AppDropdownInput(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      )),
                  value: provider.selectedStatus,
                  onChanged: (value) {
                    provider.selectNewStatus(value);
                  },
                  options: provider.workerStatusNameList,
                ),
                getHeight(context: context, height: 0.010),
                appText(
                  fontWeight: FontWeight.w500,
                  context: context,
                  title: 'Flag',
                  fontSize: 16,
                  textColor: AppColor.iconColor,
                ),
                getWidth(context: context, width: 0.005),
                AppDropdownInput(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      )),
                  value: provider.selectedFlag,
                  onChanged: (value) {
                    provider.selectNewFlag(value);
                  },
                  options: provider.workerFlagNameList,
                ),
                getHeight(context: context, height: 0.010),
                appText(
                  fontWeight: FontWeight.w500,
                  context: context,
                  title: 'Pricing',
                  fontSize: 16,
                  textColor: AppColor.iconColor,
                ),
                getWidth(context: context, width: 0.005),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    minMaxTextField(
                      context: context,
                      hintText: '\$  min',
                      controller: provider.minController,
                      onChanged: (val) {},
                    ),
                    getWidth(context: context, width: 0.020),
                    appText(
                      context: context,
                      title: '/hr',
                      fontSize: 12,
                    ),
                    getWidth(context: context, width: 0.030),
                    minMaxTextField(
                      context: context,
                      hintText: '\$  max',
                      controller: provider.maxController,
                      onChanged: (val) {},
                    ),
                    getWidth(context: context, width: 0.020),
                    appText(
                      context: context,
                      title: '/hr',
                      fontSize: 12,
                    ),
                  ],
                ),
                getHeight(context: context, height: 0.010),
                Align(
                  alignment: Alignment.centerRight,
                  child: textButton(
                      context: context,
                      onTap: () {
                        if (provider.minController.text.isNotEmpty &&
                            provider.maxController.text.isNotEmpty &&
                            double.parse(provider.minController.text) >
                                double.parse(provider.maxController.text)) {
                          toast(
                              msg: 'min price must be lower than max price',
                              context: context);
                        } 
                          if (provider.tradeOptionName != 'Select' ||
                              provider.tradeOptionName != '') {
                            provider.addFilter(provider.tradeOptionName);
                          }
                          if (provider.selectedStatus != 'Select' ||
                              provider.selectedStatus != '') {
                            provider.addFilter(
                              provider.selectedStatus,
                            );
                          }
                          provider.addFilter(
                            provider.selectedFlag,
                          );
                          if (provider.minController.text.isNotEmpty) {
                            provider.addFilter(
                              "min ${provider.minController.text}",
                            );
                          }
                          print("Location is $location");
                          if (location != '') {
                            provider.addFilter(location);
                          }
                          if (provider.maxController.text.isNotEmpty) {
                            provider.addFilter(
                                "max ${provider.maxController.text}");
                          }
                          provider.getFiltrationDataFunc(
                            city: location,
                            context: context,
                            tradeID: provider.tradeOptionId,
                            statusID: provider.selectedStatusID,
                            flagID: provider.selectedFalgID,
                            startPrice: provider.minController.text,
                            endPrice: provider.maxController.text,
                          );
                          provider.openFilter(false);
                          provider.clearTextField();
                        
                      },
                      title: "Apply",
                      width: context.getSize.width * 0.2),
                )
              ],
            );
    });
  }
}

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
import 'package:hrm_manager/provider/location_provider.dart';
import 'package:hrm_manager/views/AvaliableWorker/component/min_max_text_field.dart';
import 'package:provider/provider.dart';

@override
Widget filterWidget(
    {required BuildContext context,
    required String name,
    required int id,
    required String location,
    required AvaliableWorkerProvider provider}) {
  print(provider.filteredList.length);
  // final provider = Provider.of<AvaliableWorkerProvider>(context, listen: false);
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
                    provider
                        .removeFilter(provider.filteredList[index], context)
                        .whenComplete(() {
                      bool isFlag = provider.containsMatchingName2(
                        provider.filteredList,
                        provider.workerFlagList,
                        provider.selectedFlag,
                      );
                      bool isStatus = provider.containsMatchingName(
                          provider.filteredList,
                          provider.workerStatusList,
                          provider.selectedStatus);

                      bool isTrade = provider.containsMatchingTradeName(
                          provider.filteredList,
                          provider.tradeOptionList,
                          provider.tradeOptionName);
                      // if (!provider.filteredList
                      //     .contains(provider.locationController.text)) {
                      //   provider.locationController.clear();
                      // }
                      if (!provider.filteredList
                          .contains("min ${provider.minMainController.text}")) {
                        provider.changeminVal('');
                      }

                      if (!provider.filteredList
                          .contains(provider.locationvalController.text)) {
                        provider.changeLocationVal('');
                      }
                      if (!provider.filteredList
                          .contains("max ${provider.maxMainController.text}")) {
                        provider.changemaxVal('');
                      }
                      print(
                          "TRADE IS THIS${provider.tradeOptionId}, ${provider.minMainController.text}, ${provider.maxMainController.text}");
                      provider.getFiltrationDataFunc(
                        city: provider.locationController.text,
                        context: context,
                        tradeID: provider.tradeOptionId == 0
                            ? null
                            : provider.tradeOptionId,
                        statusID:
                            isStatus == true ? provider.selectedStatusID : null,
                        flagID: isFlag == true ? provider.selectedFalgID : null,
                        startPrice: provider.minMainController.text == ''
                            ? null
                            : provider.minMainController.text,
                        endPrice: provider.maxMainController.text == ''
                            ? null
                            : provider.maxMainController.text,
                      );
                    });
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
                hintText: 'City, postal code',
                controller: provider.locationController,
                height: context.getSize.height * 0.048,
                submit: (val) {
                  // final lcPv =
                  //     Provider.of<LocationProvider>(context, listen: false);
                  // if (lcPv.searchedList.isNotEmpty) {
                  //   // provider.locationController.text =
                  //   //     lcPv.searchedList[0].city!;
                  // }
                },
                onChanged: (val) {
                  if (val.isNotEmpty || val != '') {
                    bool containsMin = provider.filteredList.any((element) =>
                        element
                            .contains("${provider.locationController.text}"));
                    print("IsChange $containsMin");
                    if (containsMin == false) {
                      Provider.of<AvaliableWorkerProvider>(context,
                              listen: false)
                          .changeLocation(val);
                    }
                  }
                  // final lcPv =
                  //     Provider.of<LocationProvider>(context, listen: false);
                  // lcPv.searchQuery(val);
                },
                cancel: () {
                  provider.locationController.clear();
                  provider.locationMainController.clear();
                  // provider.locationvalController.clear();
                  if (provider.locationMainController.text.isEmpty ||
                      provider.locationMainController.text == '') {
                    List<String> loc = getValuesContainingLocation(
                        provider.filteredList,
                        provider.locationvalController.text);
                    provider.filteredList
                        .removeWhere((element) => element == loc[0]);
                    provider.locationvalController.clear();
                  }
                  final lcPv =
                      Provider.of<LocationProvider>(context, listen: false);
                  lcPv.clearSearchData();
                }),
            getHeight(context: context, height: 0.010),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     Icon(
            //       Icons.my_location,
            //       color: AppColor.iconColor,
            //     ),
            //     getWidth(context: context, width: 0.010),
            //     appText(
            //       fontWeight: FontWeight.w500,
            //       context: context,
            //       title: 'Current Location',
            //       fontSize: 16,
            //       textColor: AppColor.iconColor,
            //     )
            //   ],
            // ),
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
                if (value != 'Select') {
                  provider.selectNewStatus(value);
                }
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
                if (value != 'Select') {
                  provider.selectNewFlag(value);
                }
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
                  onChanged: (val) {
                    if (val.isNotEmpty || val != '') {
                      bool containsMin = provider.filteredList.any((element) =>
                          element
                              .contains("min ${provider.minController.text}"));
                      print("IsChange $containsMin");
                      if (containsMin == false) {
                        Provider.of<AvaliableWorkerProvider>(context,
                                listen: false)
                            .changeminVal(val);
                      }
                    }
                  },
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
                  onChanged: (val) {
                    if (val.isNotEmpty || val != '') {
                      bool containsMax = provider.filteredList.any((element) =>
                          element
                              .contains("max ${provider.maxController.text}"));
                      if (containsMax == false) {
                        Provider.of<AvaliableWorkerProvider>(context,
                                listen: false)
                            .changemaxVal(val);
                      }
                    }
                  },
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
                    if (provider.minMainController.text.isNotEmpty &&
                        provider.maxMainController.text.isNotEmpty &&
                        double.parse(provider.minMainController.text) >
                            double.parse(provider.maxMainController.text)) {
                      toast(
                          msg: 'min price must be lower than max price',
                          context: context);
                    }

                    if (provider.selectedStatus != 'Select' ||
                        provider.selectedStatus != '') {
                      print("Selected Satatus ${provider.selectedStatus}");
                      final isFound = provider.containsMatchingName(
                        provider.filteredList,
                        provider.workerStatusList,
                        provider.selectedStatus,
                      );
                      print(
                          "Selected Status ID Is ${provider.selectedStatusID}");
                      if (isFound == true) {
                      } else {
                        if (provider.selectedStatus.toLowerCase() ==
                            "Select".toLowerCase()) {
                          provider.changeSTatusID(-1);
                        } else {
                          print("Selected Satatus ${provider.selectedStatus}");
                          provider.addFilter(
                            provider.selectedStatus,
                          );
                        }
                      }
                    }
                    if (provider.selectedFlag != 'Select' ||
                        provider.selectedFlag != '') {
                      bool isFlagFound = provider.containsMatchingName2(
                        provider.filteredList,
                        provider.workerFlagList,
                        provider.selectedFlag,
                      );

                      if (isFlagFound == true) {
                      } else {
                        if (provider.selectedFlag.toLowerCase() ==
                            "Select".toLowerCase()) {
                          provider.changeFlagID(-1);
                        } else {
                          provider.addFilter(
                            provider.selectedFlag,
                          );
                        }
                      }
                    }
                    if (provider.minMainController.text.isNotEmpty) {
                      bool containsMin = provider.filteredList.any((element) =>
                          element.contains(
                              "min ${provider.minMainController.text}"));
                      if (containsMin == false) {
                        List<String> value =
                            getValuesContainingMin(provider.filteredList);
                        if (value.isNotEmpty) {
                          updateListWithFilter(
                              provider.filteredList,
                              "min ${provider.minMainController.text}",
                              value[0]);
                        } else {
                          provider.addFilter(
                              'min ${provider.minMainController.text}');
                        }
                      }
                    }
                    print(
                        "IS FALG FOUND ,${provider.selectedFlag},${provider.selectedStatus}");
                    if (provider.locationMainController.text.isNotEmpty) {
                      bool containsLocation = provider.filteredList.any(
                          (element) => element.contains(
                              "${provider.locationMainController.text}"));
                      if (containsLocation == false) {
                        List<String> value = getValuesContainingLocation(
                            provider.filteredList,
                            provider.locationvalController.text);
                        if (value.isNotEmpty) {
                          updateListWithFilter(
                              provider.filteredList,
                              "${provider.locationMainController.text}",
                              value[0]);
                          provider.changeLocationVal(
                              "${provider.locationMainController.text}");
                        } else {
                          provider.addFilter(
                              '${provider.locationMainController.text}');
                          provider.changeLocationVal(
                              "${provider.locationMainController.text}");
                        }
                      }
                    }

                    if (provider.maxMainController.text.isNotEmpty) {
                      bool containsMax = provider.filteredList.any((element) =>
                          element.contains(
                              "max ${provider.maxMainController.text}"));
                      if (containsMax == false) {
                        List<String> value =
                            getValuesContainingMax(provider.filteredList);
                        if (value.isNotEmpty) {
                          updateListWithFilter(
                              provider.filteredList,
                              "max ${provider.maxMainController.text}",
                              value[0]);
                        } else {
                          provider.addFilter(
                              "max ${provider.maxMainController.text}");
                        }
                      }
                    }
                    print("FLAG ID of ${provider.tradeOptionId}");
                    print(provider.selectedStatus);
                    provider.getFiltrationDataFunc(
                      city: provider.locationMainController.text,
                      context: context,
                      tradeID: provider.tradeOptionId,
                      statusID: provider.selectedStatusID,
                      flagID: provider.selectedFalgID,
                      startPrice: provider.minMainController.text == ''
                          ? null
                          : provider.minMainController.text,
                      endPrice: provider.maxMainController.text == ''
                          ? null
                          : provider.maxMainController.text,
                    );
                    print("Filter Length ${provider.filteredList.length}");
                    provider.openFilter(false);
                    // provider.clearTextField();
                  },
                  title: "Apply",
                  width: context.getSize.width * 0.2),
            )
          ],
        );
}

void updateListWithFilter(List<String> list, String newValue, String filter) {
  bool found = false;

  for (int i = 0; i < list.length; i++) {
    if (list[i].contains(filter)) {
      list[i] = newValue;
      found = true;
      break;
    }
  }

  if (!found) {
    list.add(newValue);
  }
}

List<String> getValuesContainingMin(List<String> list) {
  return list.where((element) => element.contains("min")).toList();
}

List<String> getValuesContainingMax(List<String> list) {
  return list.where((element) => element.contains("max")).toList();
}

List<String> getValuesContainingLocation(List<String> list, String location) {
  return list.where((element) => element == location).toList();
}

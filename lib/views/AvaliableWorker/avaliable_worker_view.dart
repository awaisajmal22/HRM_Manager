import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/Model/all_trades_model.dart';
import 'package:hrm_manager/Model/avaliable_worker_model.dart';
import 'package:hrm_manager/Model/filtration_response_model.dart';
import 'package:hrm_manager/Model/worker_status_and_flag_model.dart';
import 'package:hrm_manager/WidgetandBindings/app_routes.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/back.dart';
import 'package:hrm_manager/constant/constant.dart';
import 'package:hrm_manager/constant/drop_down.dart';
import 'package:hrm_manager/constant/height_box.dart';
import 'package:hrm_manager/constant/text_button.dart';
import 'package:hrm_manager/constant/width_box.dart';
import 'package:hrm_manager/constant/worker_widget.dart';
import 'package:hrm_manager/extensions/date_of_birth_format.dart';
import 'package:hrm_manager/extensions/nullable_string_extension.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/avaliable_worker_provider.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:hrm_manager/views/AvaliableWorker/component/avaliable_worker_field.dart';
import 'package:hrm_manager/views/AvaliableWorker/component/filter_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class AvaliableWorkerView extends StatefulWidget {
  final String name;
  final String location;
  final int id;
  AvaliableWorkerView(
      {super.key, this.name = '', required this.id, required this.location});

  @override
  State<AvaliableWorkerView> createState() => _AvaliableWorkerViewState();
}

class _AvaliableWorkerViewState extends State<AvaliableWorkerView> {
  late AvaliableWorkerProvider pv;
  bool _isFilterDataLoad = false;
  @override
  void initState() {
    pv = Provider.of<AvaliableWorkerProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      pv.changeLoadedData();
      if (_isFilterDataLoad == false) {
        _loadData();
      }
    });
    super.initState();
  }

  _loadData() {
    final pv = Provider.of<AvaliableWorkerProvider>(context, listen: false);
    pv.getStatusList(context: context);
    pv.locationController.text = widget.location;
    pv.locationvalController.text = widget.location;
    print("Location ${widget.location}");
    pv.locationMainController.text = widget.location;
    pv.getTradeOption(context: context).whenComplete(() {
      if (widget.name != '') {
        pv.selectTradeOption(widget.name, widget.id);
      }
    }).whenComplete(() {
      pv.getFiltrationDataFunc(
        context: context,
        tradeID: pv.tradeOptionId,
        city: widget.location,
      );
    });

    pv.getFlagList(context: context);

    print("Trade ID is ${widget.id}");
    // pv.addFilter(widget.name);
    // pv.getStatusList(context: context);

    setState(() {
      _isFilterDataLoad = true;
    });
  }

  @override
  void dispose() {
    pv.clearData();
    pv.clearMinMax();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomSheet: SizedBox(
        height: context.getSize.height * 0.08,
        width: context.getSize.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            textButton(
              vPadding: 0.02,
              width: context.getSize.width * 0.3,
              radius: 100,
              context: context,
              onTap: () {
                pv.generateCsvFile(context: context);
              },
              title: 'Export CSV',
            ),
            textButton(
              vPadding: 0.02,
              width: context.getSize.width * 0.3,
              radius: 100,
              context: context,
              onTap: () {
                pv.generateCsvFile(context: context, isShare: true);
              },
              title: 'Share CSV',
            )
          ],
        ),
      ),
      body: Consumer<AvaliableWorkerProvider>(builder: (context, provider, __) {
        provider.workerTypeController.text = widget.name;
        return SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.getSize.width * 0.040,
                  vertical: context.getSize.height * 0.020,
                ),
                decoration: BoxDecoration(color: Color(0xffE7E0EC)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            back(context: context);
                          },
                          child: Icon(
                            Icons.keyboard_arrow_left,
                            color: AppColor.iconColor,
                            size: context.getSize.height * 0.045,
                          ),
                        ),
                        getWidth(context: context, width: 0.010),
                        appText(
                          context: context,
                          title: 'Workers',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          textColor: AppColor.iconColor,
                        )
                      ],
                    ),
                    getHeight(context: context, height: 0.010),
                    filterSearchField(
                      tradeList: provider.tradeNameList,
                      // onTap: () async {
                      //   final String tradeOption = await tradeDropDown(
                      //     dataList: provider.tradeOptionList,
                      //     context: context,
                      //   );
                      //   if (tradeOption != '') {
                      //     for (var data in provider.tradeOptionList) {
                      //       if (data.tradeOptionName == tradeOption) {
                      //         provider.selectTradeOption(tradeOption, data.id!);
                      //       }
                      //     }
                      //   }
                      // },
                      isOpenFilter: provider.isFilterOpen,
                      context: context,
                      hintText: provider.tradeOptionName,
                      // controller: provider.workerTypeController,
                      height: context.getSize.height * 0.048,
                      onChanged: (val) {
                        bool isMatch = provider.containsMatchingTradeName(
                            provider.filteredList,
                            provider.tradeOptionList,
                            val);
                        if (isMatch == true) {
                          for (var data in provider.tradeOptionList) {
                            if (data.tradeOptionName == val) {
                              provider.selectTradeOption(
                                  data.tradeOptionName!, data.id!);
                              provider.getFiltrationDataFunc(
                                context: context,
                                tradeID: provider.tradeOptionId == 0
                                    ? null
                                    : provider.tradeOptionId,
                                city: provider.locationController.text,
                                statusID: provider.selectedStatusID,
                                flagID: provider.selectedFalgID,
                                startPrice:
                                    provider.minMainController.text == ''
                                        ? null
                                        : provider.minMainController.text,
                                endPrice: provider.maxMainController.text == ''
                                    ? null
                                    : provider.maxMainController.text,
                              );
                            }
                          }
                        } else {
                          for (var data in provider.tradeOptionList) {
                            if (data.tradeOptionName == val) {
                              provider.selectTradeOption(
                                  data.tradeOptionName!, data.id!);
                              provider.getFiltrationDataFunc(
                                context: context,
                                tradeID: provider.tradeOptionId == 0
                                    ? null
                                    : provider.tradeOptionId,
                                city: provider.locationController.text,
                                statusID: provider.selectedStatusID,
                                flagID: provider.selectedFalgID,
                                startPrice:
                                    provider.minMainController.text == ''
                                        ? null
                                        : provider.minMainController.text,
                                endPrice: provider.maxMainController.text == ''
                                    ? null
                                    : provider.maxMainController.text,
                              );
                            }
                          }
                        }
                      },
                      openFilter: () {
                        provider.openFilter(!provider.isFilterOpen);
                        if (provider.isFilterOpen == true) {
                          provider.clearFilterList();

                          // provider.getFiltrationDataFunc(context: context);
                        } else {
                          // provider.getFiltrationDataFunc(
                          //     context: context,
                          //     tradeID: provider.tradeOptionId == 0
                          //         ? null
                          //         : provider.tradeOptionId);
                        }
                      },
                    ),
                    filterWidget(
                      provider: provider,
                      context: context,
                      location: widget.location,
                      name: widget.name,
                      id: widget.id,
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: provider.imagesList.isEmpty &&
                          provider.isLoaded == false
                      ? _avaliableWorkerShimmer(context: context)
                      : provider.imagesList.isEmpty &&
                              provider.isLoaded == true
                          ? Center(
                              child: appText(
                                  context: context,
                                  title: 'No Worker Found',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            )
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: provider.filtrationResponseList.length,
                              padding: EdgeInsets.symmetric(
                                horizontal: context.getSize.width * 0.045,
                              ),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                Datum model =
                                    provider.filtrationResponseList[index];
                                StatusAndFlagModel status =
                                    provider.workerStatusList.firstWhere(
                                  (e) => e.id == model.statusId,
                                  orElse: () => StatusAndFlagModel(),
                                );
                                AllTradeModel trade =
                                    provider.tradeOptionList.firstWhere(
                                  (e) => e.id == model.tradeId,
                                  orElse: () => AllTradeModel(),
                                );
// model.profileBytes == null
//                                           ? null
//                                           : provider.saveUint8ListToFile(
//                                               context,
//                                               provider.stringToUint8List(
//                                                 model.profileBytes,
//                                               ),
//                                               true,
//                                               index,
//                                               model.profileType,
//                                               model.id.toString());
                                return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child:
                                        // FutureBuilder<String>(
                                        //     future:
                                        //  model.profileBytes == null
                                        //     ? null
                                        //     : provider.saveUint8ListToFile(
                                        //         context,
                                        //         provider.stringToUint8List(
                                        //           model.profileBytes,
                                        //         ),
                                        //         true,
                                        //         index,
                                        //         model.profileType,
                                        //         model.id.toString()),
                                        // builder: (context, snapshot) {
                                        // return
                                        GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            AppRoutes.workerProfileView,
                                            arguments:
                                                int.parse(model.id.toString()));
                                      },
                                      child: WorkerWidget(
                                        imageUrl: provider.imagesList[index]
                                                    .imageUrl ==
                                                'noPic'
                                            ? ''
                                            : provider.imagesList[index]
                                                    .imageUrl ??
                                                '',
                                        name:
                                            "${model.firstName.toString().isNotNullableString()} ${model.lastName.toString().isNotNullableString()}",
                                        dateOfBirth: model.dob == null
                                            ? ''
                                            : dateFormater(
                                                model.dob!.toString() ?? ''),
                                        price: model.regularRate == null
                                            ? '0.00'
                                            : "\$${double.parse(model.regularRate.toString()).toStringAsFixed(2).isNotNullableString()}/hr",
                                        trade: trade.tradeOptionName ?? '',
                                        status: status.name ?? '',
                                      ),
                                    ));
                                // }),
                                // );
                              })),
              getHeight(context: context, height: 0.080)
            ],
          ),
        );
      }),
    );
  }

  _avaliableWorkerShimmer({required BuildContext context, int count = 9}) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: context.getSize.width * 0.045,
        ),
        itemCount: count,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: WorkerWidget(
              isShimmer: true,
              name: '',
              price: '',
              status: '',
              trade: '',
              dateOfBirth: '',
            ),
          );
        });
  }
}

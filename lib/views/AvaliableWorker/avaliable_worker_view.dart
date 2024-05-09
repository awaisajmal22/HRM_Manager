import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/Model/avaliable_worker_model.dart';
import 'package:hrm_manager/Model/filtration_response_model.dart';
import 'package:hrm_manager/WidgetandBindings/app_routes.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/back.dart';
import 'package:hrm_manager/constant/constant.dart';
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

class AvaliableWorkerView extends StatefulWidget {
  final String name;
  final int id;
  AvaliableWorkerView({super.key, this.name = '', required this.id});

  @override
  State<AvaliableWorkerView> createState() => _AvaliableWorkerViewState();
}

class _AvaliableWorkerViewState extends State<AvaliableWorkerView> {
  late AvaliableWorkerProvider pv;
  bool _isFilterDataLoad = false;
  @override
  void initState() {
    pv = Provider.of<AvaliableWorkerProvider>(context, listen: false);
    if (_isFilterDataLoad == false) {
      _loadData();
    }
    super.initState();
  }

  _loadData() {
    final pv = Provider.of<AvaliableWorkerProvider>(context, listen: false);
    pv.getStatusList(context: context);
    pv.getFlagList(context: context);
    pv.getFiltrationDataFunc(
      context: context,
      tradeID: widget.id,
    );
  

    print("Trade ID is ${widget.id}");
    // pv.addFilter(widget.name);

    setState(() {
      _isFilterDataLoad = true;
    });
  }

  @override
  void dispose() {
    pv.clearData();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: context.getSize.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            textButton(
              width: context.getSize.width * 0.4,
              radius: 100,
              context: context,
              onTap: () {
                pv.generateCsvFile(context: context);
              },
              title: 'Export CSV',
            ),
            textButton(
              width: context.getSize.width * 0.4,
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
                      isOpenFilter: provider.isFilterOpen,
                      context: context,
                      hintText: '',
                      controller: provider.workerTypeController,
                      height: context.getSize.height * 0.048,
                      onChanged: (val) {},
                      openFilter: () {
                        provider.openFilter(!provider.isFilterOpen);
                      },
                    ),
                    FilterWidget(
                      name: widget.name,
                      id: widget.id,
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: provider.filtrationResponseList.length,
                      padding: EdgeInsets.symmetric(
                        horizontal: context.getSize.width * 0.045,
                      ),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Datum model = provider.filtrationResponseList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.workerProfileView,arguments:int.parse(model.id.toString()));
                          },
                          child: WorkerWidget(
                            name:
                                "${model.firstName.toString().isNotNullableString()} ${model.lastName.toString().isNotNullableString()}",
                            dateOfBirth: model.dateofBirth == null
                                ? ''
                                : dateFormater(model.dateofBirth!.toString() ??''),
                            price: "\$${model.regularRate.toString()}/hr",
                            trade: model.trade ?? '',
                            status: model.workerStatus ?? '',
                          ),
                        );
                      }))
            ],
          ),
        );
      }),
    );
  }
}

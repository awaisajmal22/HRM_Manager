import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/Model/avaliable_worker_model.dart';
import 'package:hrm_manager/WidgetandBindings/app_routes.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/back.dart';
import 'package:hrm_manager/constant/constant.dart';
import 'package:hrm_manager/constant/height_box.dart';
import 'package:hrm_manager/constant/text_button.dart';
import 'package:hrm_manager/constant/width_box.dart';
import 'package:hrm_manager/constant/worker_widget.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/avaliable_worker_provider.dart';
import 'package:hrm_manager/utils/app_color.dart';
import 'package:hrm_manager/views/AvaliableWorker/component/avaliable_worker_field.dart';
import 'package:hrm_manager/views/AvaliableWorker/component/filter_widget.dart';
import 'package:provider/provider.dart';

class AvaliableWorkerView extends StatefulWidget {
  final String name;
  AvaliableWorkerView({super.key, this.name = ''});

  @override
  State<AvaliableWorkerView> createState() => _AvaliableWorkerViewState();
}

class _AvaliableWorkerViewState extends State<AvaliableWorkerView> {
  late AvaliableWorkerProvider pv;

  @override
  void initState() {
    pv = Provider.of<AvaliableWorkerProvider>(context,listen: false);
    super.initState();
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
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.getSize.width * 0.33),
        child: textButton(
          radius: 100,
          context: context,
          onTap: () {
            pv.generateCsvFile(context: context);
          },
          title: 'Export CSV',
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
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                  itemCount: provider.avaliableWorkerList.length,
                      padding: EdgeInsets.symmetric(
                        horizontal: context.getSize.width * 0.045,
                      ),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        AvaliableWorkerModel model = provider.avaliableWorkerList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.workerProfileView);
                          },
                          child:  WorkerWidget(
                            name: model.name!,
                            dateOfBirth: model.dob!,
                            price: model.price!,
                            trade: model.trade!,
                            status: model.status!,
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

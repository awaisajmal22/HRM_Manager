import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/Model/all_trades_model.dart';
import 'package:hrm_manager/WidgetandBindings/app_routes.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/height_box.dart';
import 'package:hrm_manager/constant/width_box.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/avaliable_worker_provider.dart';
import 'package:hrm_manager/provider/home_provider.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:hrm_manager/views/Home/component/home_search_field.dart';
import 'package:hrm_manager/views/Home/component/select_location_widget.dart';
import 'package:ionicons/ionicons.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isDataFetch = false;
  @override
  void initState() {
   
    if (_isDataFetch == false) {
      Provider.of<HomeProvider>(context, listen: false)
          .getAllTradeFunc(context: context);
      setState(() {
        _isDataFetch = true;
      });
    }
    super.initState();
  }

 
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, __) {
      return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.getSize.width * 0.040),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getHeight(context: context, height: 0.01),
            SelectLocationWidget(),
            getHeight(context: context, height: 0.030),
            homeSearchField(
              onChanged: (val) {
                provider.searchTrading(val);
              },
              height: context.getSize.height * 0.055,
              context: context,
              hintText: 'Search the services you need',
              controller: provider.searchController,
            ),
            getHeight(context: context, height: 0.030),
            provider.searchController.text.isNotEmpty
                ? const SizedBox.shrink()
                : appText(
                    context: context,
                    title: 'All Trades',
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
            Expanded(
              child: provider.tradesList.isEmpty
                  ? _homeShimmer(context: context)
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: provider.searchController.text.isEmpty
                          ? provider.tradesList.length
                          : provider.searchedList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        AllTradeModel trade =
                            provider.searchController.text.isEmpty
                                ? provider.tradesList[index]
                                : provider.searchedList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.avaliableWorkerView,
                                arguments: [
                                  trade.tradeOptionName,
                                  trade.id,
                                  ''
                                ]);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: context.getSize.height * 0.010),
                            padding: EdgeInsets.symmetric(
                              horizontal: context.getSize.width * 0.020,
                              vertical: context.getSize.height * 0.015,
                            ),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: const [
                                BoxShadow(
                                    color: AppColor.lightPinkColor,
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    offset: Offset(0, 1))
                              ],
                              color: AppColor.purpleColor.withOpacity(0.08),
                            ),
                            child: appText(
                              context: context,
                              title: trade.tradeOptionName!,
                              fontSize: 16,
                            ),
                          ),
                        );
                      }),
            )
          ],
        ),
      );
    });
  }
}

_homeShimmer({required BuildContext context}) {
  return ListView.builder(
      itemCount: 9,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppColor.purpleColor.withOpacity(0.1),
          highlightColor: AppColor.lightPinkColor,
          child: Container(
            width: context.getSize.width,
            margin:
                EdgeInsets.symmetric(vertical: context.getSize.height * 0.010),
            padding: EdgeInsets.symmetric(
              horizontal: context.getSize.width * 0.020,
              vertical: context.getSize.height * 0.010,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColor.whiteColor),
            child: appText(context: context, title: '', fontSize: 16),
          ),
        );
      });
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/height_box.dart';
import 'package:hrm_manager/constant/width_box.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/home_provider.dart';
import 'package:hrm_manager/utils/app_color.dart';
import 'package:hrm_manager/views/Home/component/home_search_field.dart';
import 'package:hrm_manager/views/Home/component/select_location_widget.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
              height: context.getSize.height * 0.048,
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
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: provider.searchController.text.isEmpty
                      ? provider.tradesList.length
                      : provider.searchedList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String trade = provider.searchController.text.isEmpty
                        ? provider.tradesList[index]
                        : provider.searchedList[index];
                    return Container(
                      margin: EdgeInsets.symmetric(
                          vertical: context.getSize.height * 0.010),
                      padding: EdgeInsets.symmetric(
                        horizontal: context.getSize.width * 0.020,
                        vertical: context.getSize.height * 0.010,
                      ),

                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColor.purpleColor.withOpacity(0.08),
                      ),
                      child: appText(
                        context: context,
                        title: trade,
                        fontSize: 16,
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

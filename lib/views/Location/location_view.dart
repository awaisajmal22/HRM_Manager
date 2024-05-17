import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/WidgetandBindings/app_routes.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/back.dart';
import 'package:hrm_manager/constant/height_box.dart';
import 'package:hrm_manager/constant/width_box.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/location_provider.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:hrm_manager/constant/location_search_field.dart';
import 'package:provider/provider.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  late LocationProvider pv;
  bool isLoaded = false;
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Call your function here
      if (isLoaded == false) {
        _loaded();
      }
    });

    super.initState();
  }

  _loaded() {
    pv = Provider.of<LocationProvider>(context, listen: false);
    pv.getLocationData(context: context);
    setState(() {
      isLoaded = true;
    });
  }

  @override
  void dispose() {
    pv.clearSearch();
    pv.locationController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LocationProvider>(builder: (context, provider, __) {
        return SafeArea(
            child: Column(
          children: [
            Container(
              color: const Color(0xffE7E0EC),
              padding: EdgeInsets.only(
                left: context.getSize.width * 0.040,
                right: context.getSize.width * 0.040,
                top: context.getSize.height * 0.020,
                bottom: context.getSize.height * 0.010,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
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
                        title: 'Location',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        textColor: AppColor.iconColor,
                      )
                    ],
                  ),
                  getHeight(context: context, height: 0.020),
                  locationSearchField(
                    submit: (vl) {},
                    context: context,
                    hintText: 'City, postal code',
                    controller: provider.locationController,
                    height: context.getSize.height * 0.048,
                    onChanged: (val) {
                      provider.searchQuery(val);
                    },
                    cancel: () {
                      provider.locationController.clear();
                      provider.clearSearchData();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
                child: provider.searchedList.isEmpty
                    ? const SizedBox()
                    : ListView.builder(
                        itemCount: provider.searchedList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          String location = provider.searchedList[index].city!;
                          return GestureDetector(
                            onTap: () {
                              provider.selectLocation(location, index);
                              Navigator.pushNamed(
                                  context, AppRoutes.avaliableWorkerView,
                                  arguments: ['All Trades', 0, location]);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.getSize.width * 0.040,
                                  vertical: context.getSize.height * 0.010),
                              decoration: BoxDecoration(
                                  color: provider.seletcedLocationIndex == index
                                      ? Color(0xffE7E0EC)
                                      : Colors.white,
                                  border: Border.symmetric(
                                      horizontal: BorderSide(
                                    color: AppColor.grayColor.withOpacity(0.16),
                                    width: 1,
                                  ))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    provider.seletcedLocationIndex == index
                                        ? Icons.my_location
                                        : Icons.location_on_outlined,
                                    color: AppColor.iconColor,
                                  ),
                                  getWidth(context: context, width: 0.010),
                                  appText(
                                    context: context,
                                    title: location,
                                    fontSize: 16,
                                    textColor: AppColor.iconColor,
                                  )
                                ],
                              ),
                            ),
                          );
                        }))
          ],
        ));
      }),
    );
  }
}

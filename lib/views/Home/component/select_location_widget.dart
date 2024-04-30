import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/WidgetandBindings/app_routes.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/width_box.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/location_provider.dart';
import 'package:provider/provider.dart';

class SelectLocationWidget extends StatelessWidget {
  const SelectLocationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (context, provider, __) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.locationView);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_on,
              size: context.getSize.height * 0.025,
            ),
            getWidth(context: context, width: 0.010),
            appText(
              context: context,
              title: provider.selectedLocation,
            ),
          ],
        ),
      );
    });
  }
}

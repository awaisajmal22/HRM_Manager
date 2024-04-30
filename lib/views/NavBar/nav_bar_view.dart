import 'package:flutter/material.dart';
import 'package:hrm_manager/WidgetandBindings/app_routes.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/provider/nav_bar_provider.dart';
import 'package:hrm_manager/utils/app_color.dart';
import 'package:hrm_manager/views/Home/home_view.dart';
import 'package:hrm_manager/views/Profile/profile_view.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class NavBarView extends StatelessWidget {
  const NavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavBarProvider>(builder: (context, provider, __) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColor.whiteColor,
          selectedItemColor: const Color(0xff1C1B1F),
          unselectedItemColor: const Color(0xff49454F),
          selectedLabelStyle: textStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              context: context,
              textColor: const Color(0xff1C1B1F)),
          unselectedLabelStyle: textStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              context: context,
              textColor: const Color(0xff49454F)),
          currentIndex: provider.selectedIndex,
          onTap: (index) {
            provider.selectedIndex = index;
          },
          items: [
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: context.getSize.width * 0.040),
                decoration: provider.selectedIndex == 0
                    ? BoxDecoration(
                        color: const Color(0xffE8DEF8),
                        borderRadius: BorderRadius.circular(20))
                    : null,
                child: Icon(
                  provider.selectedIndex == 0
                      ? Icons.home
                      : Icons.home_outlined,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.getSize.width * 0.040),
                  decoration: provider.selectedIndex == 1
                      ? BoxDecoration(
                          color: const Color(0xffE8DEF8),
                          borderRadius: BorderRadius.circular(20))
                      : null,
                  child: Icon(
                    provider.selectedIndex == 1
                        ? Icons.account_circle
                        : Icons.account_circle_outlined,
                  )),
              label: 'Profile',
            ),
          ],
        ),
        floatingActionButton: provider.selectedIndex == 0
            ? FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                backgroundColor: AppColor.purpleColor,
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.addWorkerView); 
                },
                child: const Icon(
                  Icons.add,
                  size: 40,
                  color: AppColor.whiteColor,
                ),
              )
            : const SizedBox.shrink(),
        body: SafeArea(
            child: provider.selectedIndex == 0
                ? const HomeView()
                : const ProfileView()),
      );
    });
  }
}

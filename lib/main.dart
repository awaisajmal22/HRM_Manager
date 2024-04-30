import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrm_manager/WidgetandBindings/app_pages.dart';
import 'package:hrm_manager/WidgetandBindings/app_routes.dart';
import 'package:hrm_manager/provider/add_worker_provider.dart';
import 'package:hrm_manager/provider/avaliable_worker_provider.dart';
import 'package:hrm_manager/provider/edit_worker_detail_provider.dart';
import 'package:hrm_manager/provider/home_provider.dart';
import 'package:hrm_manager/provider/location_provider.dart';
import 'package:hrm_manager/provider/login_provider.dart';
import 'package:hrm_manager/provider/nav_bar_provider.dart';
import 'package:hrm_manager/provider/wroker_profile_provider.dart';
import 'package:hrm_manager/utils/app_color.dart';
import 'package:provider/provider.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();
   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown])
   .then((value) =>  runApp(const MyApp()));
 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor:AppColor.whiteColor,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColor.whiteColor),
    );

    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_)=>LoginProvider()),
        ChangeNotifierProvider(create: (_)=>NavBarProvider()),
        ChangeNotifierProvider(create: (_)=>HomeProvider()),
        ChangeNotifierProvider(create: (_)=>LocationProvider()),
        ChangeNotifierProvider(create: (_)=>AddWorkerProvider()),
        ChangeNotifierProvider(create: (_)=>AvaliableWorkerProvider()),
        ChangeNotifierProvider(create: (_)=>WorkerProfileProvider()),
        ChangeNotifierProvider(create: (_)=>EditWorkerDetailProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          splashColor: AppColor.whiteColor,
         
        scaffoldBackgroundColor: AppColor.whiteColor,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.loginView,
       onGenerateRoute: AppPages.generateRoute,
      ),
    );
  }
}

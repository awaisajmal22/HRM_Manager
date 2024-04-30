import 'package:flutter/material.dart';
import 'package:hrm_manager/WidgetandBindings/app_routes.dart';
import 'package:hrm_manager/views/AddWorker/add_worker_view.dart';
import 'package:hrm_manager/views/AvaliableWorker/avaliable_worker_view.dart';
import 'package:hrm_manager/views/EditWorkerDetial/edit_worker_detail_view.dart';
import 'package:hrm_manager/views/Location/location_view.dart';
import 'package:hrm_manager/views/Login/login_view.dart';
import 'package:hrm_manager/views/NavBar/nav_bar_view.dart';
import 'package:hrm_manager/views/PDF/pdf_view.dart';
import 'package:hrm_manager/views/WorkerProfile/wroker_profile_view.dart';

class AppPages{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case (AppRoutes.loginView): return MaterialPageRoute(builder: (context){
        return const LoginView();
      });
      case (AppRoutes.navBarView): return MaterialPageRoute(builder: (context){
        return const NavBarView();
      });
      case (AppRoutes.locationView): return MaterialPageRoute(builder: (context){
        return const LocationView();
      });
      case (AppRoutes.addWorkerView): return MaterialPageRoute(builder: (context){
        return const AddWorkerView();
      });
      case (AppRoutes.avaliableWorkerView): return MaterialPageRoute(builder: (context){
        final String argument = settings.arguments as String;
        return  AvaliableWorkerView(name: argument);
      });
      case (AppRoutes.workerProfileView): return MaterialPageRoute(builder: (context){

        return const WorkerProfileView();
      });
      case (AppRoutes.editWorkerDetailView): return MaterialPageRoute(builder: (context){

        return const EditWorkerDetailView();
      });
      case (AppRoutes.pdfView): return MaterialPageRoute(builder: (context){
        List<dynamic> args = settings.arguments as List<dynamic>;
        String title = args[0];
        String path = args[1];
        return  PDFView(title: title,pdfPath: path,);
      });
      default:
       return _errorRoute();
    }
  }
  
static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text(
            'Route Error..',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    });
  }
}
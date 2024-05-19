import 'package:flutter/material.dart';
import 'package:hrm_manager/Model/worker_by_id_model.dart';
import 'package:hrm_manager/Model/worker_doc_model.dart';
import 'package:hrm_manager/WidgetandBindings/app_routes.dart';
import 'package:hrm_manager/views/AddWorker/add_worker_view.dart';
import 'package:hrm_manager/views/AvaliableWorker/avaliable_worker_view.dart';
import 'package:hrm_manager/views/EditWorkerDetial/edit_worker_detail_view.dart';
import 'package:hrm_manager/views/ForgetPassword/forgert_password_view.dart';
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
      case (AppRoutes.locationView): return PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (_, __, ___) => LocationView(),
                transitionsBuilder: (_, animation, __, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(-1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );});
      //  MaterialPageRoute(builder: (context){
      //   return 
      //    const LocationView();
      // });
      case (AppRoutes.addWorkerView): return MaterialPageRoute(builder: (context){
        return const AddWorkerView();
      });
      case (AppRoutes.forgetPasswordView): return MaterialPageRoute(builder: (context){
        return const ForgetPasswordView();
      });
      case (AppRoutes.avaliableWorkerView): return MaterialPageRoute(builder: (context){
        List<dynamic> arguments = settings.arguments as List<dynamic>;
       
        return  AvaliableWorkerView(name: arguments[0],id: arguments[1],location: arguments[2],);
      });
      case (AppRoutes.workerProfileView): return MaterialPageRoute(builder: (context){
        int id = settings.arguments as int;
        return  WorkerProfileView(id:id);
      });
      case (AppRoutes.editWorkerDetailView): return MaterialPageRoute(builder: (context){
        List<dynamic> dataList = settings.arguments as dynamic;
WorkerByIdModel model = dataList[0];
String profileImage = dataList[1];
        return EditWorkerDetailView(
          profileImage: profileImage,
          workerModel: model,
        );
      });
      // case (AppRoutes.pdfView): return MaterialPageRoute(builder: (context){
      //   List<dynamic> args = settings.arguments as List<dynamic>;
      //   String title = args[0];
      //   WorkerDocModel path = args[1];
      //   return  PDFView(
      //     title: title,
      //     pdfPath: path,);
      // });
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


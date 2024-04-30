import 'package:flutter/material.dart';
import 'package:hrm_manager/WidgetandBindings/app_routes.dart';
import 'package:hrm_manager/views/AddWorker/add_worker_view.dart';
import 'package:hrm_manager/views/Location/location_view.dart';
import 'package:hrm_manager/views/Login/login_view.dart';
import 'package:hrm_manager/views/NavBar/nav_bar_view.dart';

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
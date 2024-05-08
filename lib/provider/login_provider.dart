import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/Services/login_services.dart';
import 'package:hrm_manager/constant/spinkit_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../WidgetandBindings/app_routes.dart';

class LoginProvider extends ChangeNotifier {
  bool _isObsecureText = true;
  bool get isObsecureText => _isObsecureText;
  showPasword(bool isShow) {
    _isObsecureText = isShow;
    notifyListeners();
  }

    RegExp regExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future userLoginFunc({required BuildContext context, required String email,required String password,}) async{
showLoadingIndicator(context: context);
final result = await LoginServices().userLogin(context: context, email: email, password: password,);
if(result != null){

  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('token', result.token!);
  pref.setString('email',email);
  pref.setString('password', password);
  hideOpenDialog(context: context);
                      Navigator.pushReplacementNamed(context, AppRoutes.navBarView);
}else{
  hideOpenDialog(context: context);
}
  }
Future  autoLogin({required BuildContext context}) async {
SharedPreferences pref = await SharedPreferences.getInstance();
if(!pref.containsKey('password') && !pref.containsKey('email')){
  
}else{
    final email = pref.getString('email');
  final password = pref. getString('password');
userLoginFunc(context: context, email: email!, password: password!);
}
}
}

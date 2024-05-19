import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/Services/forget_password_services.dart';

class ForgetPasswordProvider extends ChangeNotifier{
  TextEditingController emailController = TextEditingController();
  
bool _isSuccess = true;
bool get isSuccess => _isSuccess;

  postForgetPassword({
    required BuildContext context,
    required String email,
  })async{
    _isSuccess = false;
    final result = await ForgetPasswordServices().forgetPassword(context: context, email: email);
    if(result == true){
      _isSuccess = true;
    }else{
      _isSuccess = true;
    }
    notifyListeners();
  }
}
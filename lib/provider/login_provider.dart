import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _isObsecureText = true;
  bool get isObsecureText => _isObsecureText;
  showPasword(bool isShow) {
    _isObsecureText = isShow;
    notifyListeners();
  }
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
}

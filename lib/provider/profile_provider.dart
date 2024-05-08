import 'package:flutter/cupertino.dart';
import 'package:hrm_manager/Model/profile_model.dart';
import 'package:hrm_manager/Services/profile_services.dart';
import 'package:hrm_manager/constant/toast.dart';

class ProfileProvider extends ChangeNotifier {
  bool _isWirteName = true;
  bool get isWriteName => _isWirteName;
  set isWriteName(bool val) {
    _isWirteName = val;
    notifyListeners();
  }

  bool _isWriteEmail = true;
  bool get isWriteEmail => _isWriteEmail;
  set isWriteEmail(bool val) {
    _isWriteEmail = val;
    notifyListeners();
  }

  bool _isWritePhone = true;
  bool get isWritePhone => _isWritePhone;
  set isWritePhone(bool val) {
    _isWritePhone = val;
    notifyListeners();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController changePassController = TextEditingController();
  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  ProfileModel profileModel = ProfileModel();

  Future<ProfileModel> getProfile({required BuildContext context}) async {
    final res = await ProfileServices().getProfileData(context: context);
    if (res != null) {
      profileModel = res;
      notifyListeners();
    }

    return profileModel;
  }

  bool _isSuccess = true;
  bool get isSuccess => _isSuccess;
  changeIsSuccess(bool val){
_isSuccess = val;
notifyListeners();
  }
  Future changePass(
      {required BuildContext context,
      required String currentPass,
      required String newPass}) async {
        changeIsSuccess(false);
    final res = await ProfileServices().changePassword(
        context: context, currentPassword: currentPass, newPassword: newPass);
    print(res);
    if (res == true) {
     changeIsSuccess(true);
     currentPassController.clear();
     newPassController.clear();
     confirmPassController.clear();
    } else {
      changeIsSuccess(true);
      toast(msg: 'Something went wrong Please try again.', context: context);
    }
   
  }
}

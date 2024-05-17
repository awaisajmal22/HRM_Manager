import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrm_manager/Model/profile_model.dart';
import 'package:hrm_manager/Network/Server/permission_handler.dart';
import 'package:hrm_manager/Services/profile_services.dart';
import 'package:hrm_manager/constant/toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

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
  changeIsSuccess(bool val) {
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

  String _image = '';
  String get image => _image;
  pickImage() async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) {
      _image = result.path;
      notifyListeners();
    }
  }

  bool _isProfileImageUpdate = true;
  bool get isProfileImageUpdate => _isProfileImageUpdate;
  changeProfileImageUpdate(bool val) {
    _isProfileImageUpdate = val;
    notifyListeners();
  }

  changeManagerProfile({
    required BuildContext context,
    required String profileImage,
  }) async {
    changeProfileImageUpdate(false);
    final result = await ProfileServices()
        .changeProfileImage(context: context, profileImage: profileImage);
    if (result == true) {
      changeProfileImageUpdate(true);
      getManagerProfileImage(context: context);
      toast(msg: 'Profile Image Change Successfully', context: context);
    } else {
      changeProfileImageUpdate(true);

      toast(msg: 'Something went wrong', context: context);
    }
    notifyListeners();
  }

  getManagerProfileImage({required BuildContext context}) async {
    final result = await ProfileServices().getProfileImage(context: context);
    print("Profile Image is $result");
    if (result != '') {
      Uint8List pdfBytes = stringToUint8List(
        result,
      );
      final data = await saveUint8ListToFile(context, pdfBytes);
      if (data.isNotEmpty) {
        _image = data;
        notifyListeners();
      }
    }
  }

  Uint8List stringToUint8List(
    String input,
  ) {
    List<int> bytes = base64.decode(input);
    return Uint8List.fromList(bytes);
  }

  Directory? directory;
  Future<String> saveUint8ListToFile(
    BuildContext context,
    Uint8List data,
  ) async {
    if (Platform.isAndroid) {
      if (await requestPermission()) {
        directory = (await getExternalStorageDirectory())!;
        String newPath = "";

        print(directory);
        List<String> paths = directory!.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/$folder";
          } else {
            break;
          }
        }
        newPath = "$newPath/HRM";
        directory = Directory(newPath);
        print(directory!.path);
      } else {}
    } else if (Platform.isIOS) {
    if (await requestPermission()) {
      directory = await getTemporaryDirectory();
    } else {
      throw Exception("Photos permission denied");
    }
  } else {
    throw Exception("Unsupported platform");
  }

    String saveFile = '';

    saveFile = "${directory!.path}/workermanager.png";

    if (!await directory!.exists()) {
      await directory!
          .create(
            recursive: true,
          )
          .then((value) => File(saveFile).writeAsBytes(data));

      print('Directory Created');
    }
    if (await directory!.exists()) {
      File(saveFile).writeAsBytes(data);
    }
    return saveFile;
  }
}

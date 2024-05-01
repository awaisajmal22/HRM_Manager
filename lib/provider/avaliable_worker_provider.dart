import 'dart:io';

import 'package:csv/csv.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/utils/app_color.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Model/avaliable_worker_model.dart';

class AvaliableWorkerProvider extends ChangeNotifier {
  TextEditingController workerTypeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  bool _isFilterOpen = false;
  bool get isFilterOpen => _isFilterOpen;
  openFilter(bool value) {
    _isFilterOpen = value;
    notifyListeners();
  }

  List<String> workerStatusList = <String>[
    "Now On Site",
    "Candidate",
    "On Leave",
    "Ready To Work",
    "Inactive",
  ];
  String _selectedStatus = 'Now On Site';
  String get selectedStatus => _selectedStatus;

  selectNewStatus(String status) {
    _selectedStatus = status;
    notifyListeners();
  }

  List<String> workerFlagList = <String>[
    "No Papers",
    "Do Not Rehire",
    "Incomplete Info",
    "Poor Health",
    "Special Circumstances",
  ];
  String _selectedFlag = "No Papers";
  String get selectedFlag => _selectedFlag;
  selectNewFlag(String flag) {
    _selectedFlag = flag;
    notifyListeners();
  }

  List<String> _filteredList = <String>[];
  List<String> get filteredList => _filteredList;

  addFilter(String filterData) {
    if (filterData != '' || filterData.isNotEmpty) {
      if (!_filteredList.contains(filterData)) {
        _filteredList.add(filterData);
        notifyListeners();
      }
    }
  }

  removeFilter(int index) {
    _filteredList.removeAt(index);
    notifyListeners();
  }

  List<AvaliableWorkerModel> avaliableWorkerList = <AvaliableWorkerModel>[
    AvaliableWorkerModel(
      name: "Umer",
      price: '\$47.99/hr',
      trade: 'Carpenter',
      status: 'Now on Site',
      dob: '1797, Dec 10',
    ),
    AvaliableWorkerModel(
      name: "Ali",
      price: '\$47.99/hr',
      trade: 'Carpenter',
      status: 'Now on Site',
      dob: '1797, Dec 10',
    ),
    AvaliableWorkerModel(
      name: "Awais",
      price: '\$47.99/hr',
      trade: 'Carpenter',
      status: 'Now on Site',
      dob: '1797, Dec 10',
    )
  ];



  void clearData() {
    _filteredList.clear();
    filteredList.clear();
    print("dispoe true");
  }

  generateCsvFile({required BuildContext context}) async{
Directory directory;
 String dateTime = DateTime.now().toIso8601String();
    List<String> date = dateTime.split(':');
    String joinDate = date.join('');
    List<String> removeDot = joinDate.split('.');
    String join2 = removeDot.join('');
    print(join2);
    try {
      List<List<dynamic>> rows = [];

    List<dynamic> row = [];
    row.add("Name");
    row.add("Price");
    row.add("Trade");
    row.add("Status");
    row.add("Date of birth");
    rows.add(row);
    for (int i = 0; i < avaliableWorkerList.length; i++) {
      List<dynamic> row = [];
      // row.add(associateList[i]["number"] - 1);
      row.add(avaliableWorkerList[i].name!);
      row.add(avaliableWorkerList[i].price!);
      row.add(avaliableWorkerList[i].status!);
      row.add(avaliableWorkerList[i].trade!);
      row.add(avaliableWorkerList[i].dob!);

      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);

      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage) &&
            // access media location needed for android 10/Q
            await _requestPermission(Permission.accessMediaLocation) &&
            await _requestPermission(Permission.manageExternalStorage)) {
          directory = (await getExternalStorageDirectory())!;
          String newPath = "";
          
          print(directory);
          List<String> paths = directory.path.split("/");
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
          print(directory.path);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.manageExternalStorage)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File("${directory.path}/$join2-HRM.csv");
      if (!await directory.exists()) {
        await directory.create(
          recursive: true,
        ).then((value) =>  saveFile.writeAsString(csv).then((val)=>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: appText(
      context: context,
      title: 'File Exported Successfully',
      textColor: AppColor.whiteColor,
    )))));
        print('Directory Created');
      }
      if (await directory.exists()) {
        saveFile.writeAsString(csv).then((val)=>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: appText(
      context: context,
      title: 'File Exported Successfully',
      textColor: AppColor.whiteColor,
    ))));

        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
   Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }
}

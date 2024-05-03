import 'dart:io';

import 'package:csv/csv.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/Model/filtration_response_model.dart';
import 'package:hrm_manager/Model/worker_status_and_flag_model.dart';
import 'package:hrm_manager/Services/avaliable_worker_services.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Model/avaliable_worker_model.dart';

class AvaliableWorkerProvider extends ChangeNotifier {
  TextEditingController workerTypeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController minController = TextEditingController(text: '0.0');
  TextEditingController maxController = TextEditingController(text: '0.0');
  bool _isFilterOpen = false;
  bool get isFilterOpen => _isFilterOpen;
  openFilter(bool value) {
    _isFilterOpen = value;
    notifyListeners();
  }

  String _selectedStatus = 'Select';
  String get selectedStatus => _selectedStatus;
  int _selectedStatusID = -1;
  int get selectedStatusID => _selectedStatusID;

  selectNewStatus(String status) {
    _selectedStatus = status;
    StatusAndFlagModel? model = _workerStatusList
        .firstWhere((element) => element.name == status, orElse: () {
      return StatusAndFlagModel();
    });
    _selectedStatusID = model.id!;
    notifyListeners();
  }

  String _selectedFlag = "No Papers";
  String get selectedFlag => _selectedFlag;
  int _selectedFlagID = -1;
  int get selectedFalgID => _selectedFlagID;
  selectNewFlag(String flag) {
    _selectedFlag = flag;
    StatusAndFlagModel? model = _workerFlagList
        .firstWhere((element) => element.name == flag, orElse: () {
      return StatusAndFlagModel();
    });
    _selectedFlagID = model.id!;
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
    _isFilterOpen = false;

    print("dispoe true");
  }

  void clearTextField() {
    workerTypeController.clear();
    locationController.clear();
    maxController.text = '0.0';
    minController.text = '0.0';
  }

  generateCsvFile({required BuildContext context}) async {
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
        await directory
            .create(
              recursive: true,
            )
            .then((value) => saveFile.writeAsString(csv).then(
                (val) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: appText(
                      context: context,
                      title: 'File Exported Successfully',
                      textColor: AppColor.whiteColor,
                    )))));
        print('Directory Created');
      }
      if (await directory.exists()) {
        saveFile
            .writeAsString(csv)
            .then((val) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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

  List<StatusAndFlagModel> _workerStatusList = <StatusAndFlagModel>[];
  List<StatusAndFlagModel> get workerStatusList => _workerStatusList;
  List<String> _workerStatusNameList = <String>[];
  List<String> get workerStatusNameList => _workerStatusNameList;

  Future getStatusList({required BuildContext context}) async {
    _workerStatusList.clear();
    workerStatusList.clear();
    _workerStatusNameList.clear();
    workerStatusNameList.clear();
    final result =
        await AvaliableWorkerServices().getWorkerStatus(context: context);
    if (result.isNotEmpty) {
      _workerStatusList.insert(
          0,
          StatusAndFlagModel(
            id: -1,
            name: "Select",
            description: "Select",
          ));
      _workerStatusNameList.insert(0, "Select");
      result.forEach((element) => _workerStatusList.add(element));
      result.forEach((element) => _workerStatusNameList.add(element.name!));
    }
    notifyListeners();
  }

  List<StatusAndFlagModel> _workerFlagList = <StatusAndFlagModel>[];
  List<StatusAndFlagModel> get workerFlagList => _workerFlagList;
  List<String> _workerFlagNameList = <String>[];
  List<String> get workerFlagNameList => _workerFlagNameList;

  Future getFlagList({required BuildContext context}) async {
    _workerFlagList.clear();
    workerFlagList.clear();
    _workerFlagNameList.clear();
    workerFlagNameList.clear();
    final result =
        await AvaliableWorkerServices().getWorkerFlag(context: context);
    if (result.isNotEmpty) {
      _workerFlagList.insert(
          0,
          StatusAndFlagModel(
            id: -1,
            name: "Select",
            description: "Select",
          ));
      _workerFlagNameList.insert(0, "Select");
      result.forEach((element) => _workerFlagList.add(element));
      result.forEach((element) => _workerFlagNameList.add(element.name!));
    }
    notifyListeners();
  }

  List<Datum> _filtrationResponseList = <Datum>[];
  List<Datum> get filtrationResponseList => _filtrationResponseList;
  Future getFiltrationDataFunc({
    required BuildContext context,
    int? tradeID,
    String? city,
    int? statusID,
    int? flagID,
    String? startPrice,
    String? endPrice,
  }) async {
    final result = await AvaliableWorkerServices().getFiltrationData(
      context: context,
      tradeID: tradeID,
      city: city ?? '',
      statusID: statusID,
      flagID: flagID,
      startPrice: startPrice,
      endPrice: endPrice,
    );
    if (result  != null) {
      
      _filtrationResponseList = result;
      print("FIlterData ${_filtrationResponseList.length}");
    } else {
      print("Data not found");
    }
    notifyListeners();
  }
}

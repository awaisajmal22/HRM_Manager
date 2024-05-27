import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/Model/all_trades_model.dart';
import 'package:hrm_manager/Model/filtration_response_model.dart';
import 'package:hrm_manager/Model/worker_status_and_flag_model.dart';
import 'package:hrm_manager/Network/Server/permission_handler.dart';
import 'package:hrm_manager/Services/all_trades_Services.dart';
import 'package:hrm_manager/Services/avaliable_worker_services.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:hrm_manager/constant/toast.dart';
import 'package:hrm_manager/extensions/date_of_birth_format.dart';
import 'package:hrm_manager/extensions/nullable_string_extension.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

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

  String _selectedFlag = "Select";
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
      if (!_filteredList.contains(filterData) && filterData != "Select") {
        _filteredList.add(filterData);
      }
    }
    // notifyListeners();
  }

  Future removeFilter(int index, BuildContext context) async{
    _filteredList.removeAt(index);
    notifyListeners();
  }

  void clearData() {
    _filteredList.clear();
    filteredList.clear();
  _filtrationResponseList.clear();
  filtrationResponseList.clear();
    _isFilterOpen = false;

    print("dispoe true");
  }

  void clearTextField() {
    workerTypeController.clear();
    locationController.clear();
    maxController.clear();
    minController.clear();
    // selectTradeOption('Select', 0);
  }

  generateCsvFile({required BuildContext context, bool isShare = false}) async {
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
      row.add("First Name");
      row.add("Last Name");
      row.add("Price");
      row.add("Trade");
      row.add("Status");
      row.add("Date of birth");
      rows.add(row);
      for (int i = 0; i < filtrationResponseList.length; i++) {
        List<dynamic> row = [];
        // row.add(associateList[i]["number"] - 1);
        row.insert(
            0,
            filtrationResponseList[i]
                .firstName
                .toString()
                .isNotNullableString());
        row.add(filtrationResponseList[i]
            .lastName
            .toString()
            .isNotNullableString());
        row.add(filtrationResponseList[i]
            .regularRate
            .toString()
            .isNotNullableString());
        for (var data in tradeOptionList) {
          if (data.id == filtrationResponseList[i].tradeId) {
            row.add(data.tradeOptionName.toString().isNotNullableString());
          }
        }
        for (var data in workerStatusList) {
          if (data.id == filtrationResponseList[i].statusId) {
            row.add(data.name.toString().isNotNullableString());
          }
        }
        if (filtrationResponseList[i].dob == null) {
          row.add(' ');
        } else {
          row.add(dateFormater(
              filtrationResponseList[i].dob.toString().isNotNullableString() ??
                  ''));
        }
        rows.add(row);
      }

      String csv = const ListToCsvConverter().convert(rows);

      if (Platform.isAndroid) {
        if (await requestPermission()) {
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
        if (await requestPermission()
            // await requestPermission(Permission.manageExternalStorage) &&
            // await requestPermission(Permission.accessMediaLocation) &&await requestPermission(Permission.mediaLibrary)&&
            // await requestPermission(Permission.storage)
            ) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File("${directory.path}/$join2-HRM.csv");
      if (!await directory.exists()) {
        if (isShare == true) {
          await directory
              .create(
                recursive: true,
              )
              .then((value) => saveFile
                  .writeAsString(csv)
                  .then((value) => Share.shareXFiles([XFile(value.path)]))
                  .whenComplete(() =>
                      toast(msg: 'File Share Successfully', context: context)));
        }
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
        if (isShare == true) {
          saveFile
              .writeAsString(csv)
              .then((value) => Share.shareXFiles([XFile(value.path)]))
              .whenComplete(() =>
                  toast(msg: 'File Share Successfully', context: context));
        } else {
          saveFile.writeAsString(csv).then(
              (val) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: appText(
                    context: context,
                    title: 'File Exported Successfully',
                    textColor: AppColor.whiteColor,
                  ))));
        }

        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
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

bool _isLoaded = false;
bool get isLoaded => _isLoaded;
changeLoadedData(){
  _isLoaded = false;
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
    _isLoaded = false;
    _filtrationResponseList.clear();
    filtrationResponseList.clear();
    print("Trade ID $tradeID");
    final result = await AvaliableWorkerServices().getFiltrationData(
      context: context,
      tradeID: tradeID,
      city: city ?? '',
      statusID: statusID == -1 ? null : statusID,
      flagID: flagID == -1 ? null : flagID,
      startPrice: startPrice,
      endPrice: endPrice,
    );
    if (result != null) {
      print(tradeID);
      _filtrationResponseList = result;
      _isLoaded = true;
      // final List<Datum>
      // _filtrationResponseList = result
      //     .where((item) =>
      //         item.tradeOptionId == tradeID ||
      //         item.workerFlagId == flagID ||
      //         item.city == city ||
      //         item.workerStatusId == statusID)
      //     .toList();
      print("FIlterData ${_filtrationResponseList.length}");
    } else {
      _isLoaded = true;
      print("Data not found");
    }
    notifyListeners();
  }

  List<AllTradeModel> _tradeOptionList = <AllTradeModel>[];
  List<AllTradeModel> get tradeOptionList => _tradeOptionList;
  List<String> _tradeNameList = <String>[];
  List<String> get tradeNameList => _tradeNameList;
  Future getTradeOption({required BuildContext context}) async {
    // showLoadingIndicator(context: context);
    _tradeOptionList.clear();
    tradeOptionList.clear();
    _tradeNameList.clear();
    tradeNameList.clear();

    final result = await AllTradesServices().getAllTrade(context: context);
    if (result.isNotEmpty) {
      result.sort((a, b) => a.tradeOptionName!.compareTo(b.tradeOptionName!));
      result.add(
          AllTradeModel(id: 0, description: '', tradeOptionName: 'All Trades'));
      _tradeOptionList = result;

      for (var data in result) {
        _tradeNameList.add(data.tradeOptionName!);
      }
      print(_tradeOptionList.length);
    }

    notifyListeners();
  }

  String _tradeOptionName = 'All Trades';
  String get tradeOptionName => _tradeOptionName;

  int _tradeOptionId = 0;
  int get tradeOptionId => _tradeOptionId;
  selectTradeOption(String tradeOption, int id) {
    if (!tradeOptionName.contains(tradeOption)) {
      _tradeOptionName = tradeOption;
      _tradeOptionId = id;
      notifyListeners();
    }
  }

  Uint8List stringToUint8List(
    String input,
  ) {
    List<int> bytes = base64.decode(input);
    return Uint8List.fromList(bytes);
  }

  Directory? directory;
  Future<String> saveUint8ListToFile(BuildContext context, Uint8List data,
      bool isProfile, int index, String type, String title) async {
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
    if (isProfile) {
      saveFile = "${directory!.path}/$title.png";
    } else if (type.contains('png')) {
      saveFile = "${directory!.path}/${index}${title}_file.png";
    } else if (type.contains('jpeg')) {
      saveFile = "${directory!.path}/${index}${title}_file.jpeg";
    } else if (type.contains('pdf')) {
      saveFile = "${directory!.path}/${index}${title}_file.pdf";
    } else if (type.contains('.document')) {
      saveFile = "${directory!.path}/${index}${title}_file.docx";
    } else if (type.contains('text/plain')) {
      saveFile = "${directory!.path}/${index}${title}_file.cpp";
    } else if (type.contains('.sheet')) {
      saveFile = "${directory!.path}/${index}${title}_file.xlsx";
    }

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

  bool containsMatchingName(List<String> list1, List<StatusAndFlagModel> list2,
      String value ) {
    bool foundMatch = false;

    for (var model in list2) {
      for (int i = 0; i < list1.length; i++) {
        if (model.name == list1[i]) {
          list1[i] = value;

          foundMatch = true;
          break;
        }
      }
      if (foundMatch) {
        break;
      }
      
    }

    return foundMatch;
  }

  bool containsMatchingTradeName(
      List<String> list1, List<AllTradeModel> list2, String value) {
    bool foundMatch = false;

    for (var model in list2) {
      for (int i = 0; i < list1.length; i++) {
        if (model.tradeOptionName == list1[i]) {
          list1[i] = value;
          foundMatch = true;
          break;
        }
      }
      if (foundMatch) {
        break;
      }
    }

    return foundMatch;
  }

}

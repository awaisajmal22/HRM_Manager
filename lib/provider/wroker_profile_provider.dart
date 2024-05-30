import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/Model/add_worker_drop_down_model.dart';
import 'package:hrm_manager/Model/all_trades_model.dart';
import 'package:hrm_manager/Model/worker_by_id_model.dart';
import 'package:hrm_manager/Model/worker_doc_model.dart';
import 'package:hrm_manager/Model/worker_profile_model.dart';
import 'package:hrm_manager/Network/Server/permission_handler.dart';
import 'package:hrm_manager/Network/api_services.dart';
import 'package:hrm_manager/Network/api_url.dart';
import 'package:hrm_manager/Services/add_worker_services.dart';
import 'package:hrm_manager/Services/all_trades_Services.dart';
import 'package:hrm_manager/Services/worker_profile_services.dart';
import 'package:hrm_manager/constant/app_color.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constant/app_text.dart';

class WorkerProfileProvider extends ChangeNotifier {
  List<String> documentList = <String>[
    'WHIM',
    'Working Form Height',
    "First Aid",
  ];
  WorkerProfileModel workerProfileModel = WorkerProfileModel(
    name: "Awais",
    price: "\$47.00/hr",
    trade: 'Carpenter',
    status: 'Now on Site',
    dob: '1988, Dec 27',
    experience: '6 Years of high rise, 5 commercial, 2 years drywall',
    previousEmployment: 'MCF, Structform, Supplier',
    unionAffiliation: '183, Local 27',
    flag: 'No papers',
    transportation: 'Yes',
    specialTickets: 'No',
    note: '',
    certificate: '',
    home: 'Toronto (King & Young)',
  );

  generateCsvFile({
    required BuildContext context,
    required String flags,
    required String experience,
    required String afflication,
    required String certificate,
    required String status,
    required String trade,
  }) async {
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
      List<dynamic> row2 = [];
      row.add("Name");
      row.add("Price");
      row.add("Trade");
      row.add("Status");
      row.add("Date of birth");
      row.add('Experience');
      row.add('Previous Employment');
      row.add('Union Affiliation');
      row.add('Flag');
      row.add('Transportation');
      row.add('Home');
      row.add('Certificates');
      row.add('Special Tickets');
      row.add('Note');
      row2.add(workerProfileModel.name);
      row2.add(workerProfileModel.price);
      row2.add(trade);
      row2.add(status);
      row2.add(workerProfileModel.dob);
      row2.add(experience);
      row2.add(workerProfileModel.previousEmployment);
      row2.add(afflication);
      row2.add(flags);
      row2.add(workerProfileModel.transportation);
      row2.add(workerProfileModel.home);
      row2.add(certificate);
      row2.add(workerProfileModel.specialTickets);
      row2.add(workerProfileModel.note);
      rows.add(row);
      rows.add(row2);

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
        if (await requestPermission()) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }

      File saveFile =
          File("${directory.path}/${workerProfileModel.name}-$join2-HRM.csv");
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

  WorkerByIdModel workerByIdModel = WorkerByIdModel();
  Future getWorkerData({required BuildContext context, required int id}) async {
    workerByIdModel = WorkerByIdModel();
    print("Worker is ID $id");
    final result =
        await WorkerServices().getWorkerData(context: context, id: id);
    if (result != null) {
      workerByIdModel = result;
    }
    notifyListeners();
  }

  clearData() {
    _files.clear();
    files.clear();
    _selectedUnionAfflicationIdList.clear();
    _selectedUnionAfflicationList.clear();
    unionAfflicationList.clear();
    _unionAfflicationList.clear();
    _selectedWorkExpIDList.clear();
    selectedWorkExpList.clear();
    workerFlagList.clear();
    _workerExperienceList.clear();
    workerExperienceList.clear();
    _workerFlagList.clear();
    workerFlagList.clear();
    certificationList.clear();
    _certificationList.clear();
    _selectedcertificateIdList.clear();
    selectedcertificateIdList.clear();
    _selectedcertificateList.clear();
    selectedcertificateList.clear();
    _selectedWorkerFlagIdList.clear();
    _selectedWorkerFlagList.clear();
    selectedWorkerFlagIdList.clear();
    selectedWorkerFlagList.clear();

    _workerStatusList.clear();
    workerStatusList.clear();
    _tradeOptionList.clear();
    tradeOptionList.clear();
    // clearProfile();
  }

  List<WorkerDocModel> _files = <WorkerDocModel>[];
  List<WorkerDocModel> get files => _files;
  String _profileImage = '';
  String get profileImage => _profileImage;

  changeProfileImage(String image) {
    _profileImage = image;
    notifyListeners();
  }

  Future getFileData({
    required int index,
    bool isProfile = false,
    required String api,
    required String title,
    required BuildContext context,
    int? id,
  }) async {
    if (_files.length >= 6) {
      _files.clear();
      files.clear();
    }
    final result = await WorkerServices().getFiles(api: api, context: context);
    if (result.wasabiBytes== null) {
      if(isProfile == true){
        changeProfileImage('');
        print("Profile is Empty");
      }
    } else {
      if (isProfile == true) {
        // clearProfile();
        if (result.wasabiBytes != null) {
          Uint8List pdfBytes = stringToUint8List(
            result.wasabiBytes!,
          );
          final data = await saveUint8ListToFile(context, pdfBytes, true, index,
              result.contentType!, title, id.toString());
          print("Data is ther and $data");
          changeProfileImage(data);
        }
      } else {
        if (result.wasabiBytes != null) {
          Uint8List pdfBytes = stringToUint8List(
            result.wasabiBytes!,
          );
          final data = await saveUint8ListToFile(
              context, pdfBytes, false, index, result.contentType!, title, '');
          _files.add(WorkerDocModel(
            title: title,
            wasabiBytes: data,
            contentType: result.contentType,
          ));
        }
        print("FIle Length${_files.length}");
      }
    }
    notifyListeners();
  }

  Uint8List stringToUint8List(
    String input,
  ) {
    List<int> bytes = base64.decode(input);
    return Uint8List.fromList(bytes);
  }

  Directory? directory;
  Future<String> saveUint8ListToFile(BuildContext context, Uint8List data,
      bool isProfile, int index, String type, String title, String? id) async {
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
      saveFile = "${directory!.path}/$id$title.png";
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

  List<String> _selectedWorkExpList = <String>[];
  List<String> get selectedWorkExpList => _selectedWorkExpList;
  List<int> _selectedWorkExpIDList = <int>[];
  List<int> get selectedWorkExpIDList => _selectedWorkExpIDList;
  selectWorkExperience(String workExp, int id) {
    if (!_selectedWorkExpList.contains(workExp)) {
      _selectedWorkExpList.add(workExp);
      _selectedWorkExpIDList.add(id);
      // workExperienceController.text = workExp;
      notifyListeners();
    }
  }

  List<AddWorkerDropDownModel> _workerExperienceList =
      <AddWorkerDropDownModel>[];
  List<AddWorkerDropDownModel> get workerExperienceList =>
      _workerExperienceList;
  Future getExperienceData({required BuildContext context}) async {
    if (_workerExperienceList.isNotEmpty) {
      _workerExperienceList.clear();
      workerExperienceList.clear();
    }
    final result =
        await AddWorkerServices().getWorkerExperience(context: context);
    if (result.isNotEmpty) {
      _workerExperienceList = result;
    }
    notifyListeners();
  }

  List<AddWorkerDropDownModel> _workerStatusList = <AddWorkerDropDownModel>[];
  List<AddWorkerDropDownModel> get workerStatusList => _workerStatusList;
  Future getStatusData({required BuildContext context}) async {
    if (_workerStatusList.isNotEmpty) {
      _workerStatusList.clear();
      workerStatusList.clear();
    }
    final result = await AddWorkerServices().getWorkerStatus(context: context);
    if (result.isNotEmpty) {
      _workerStatusList = result;
      print("Length ${_workerStatusList.length}");
      print(_workerStatusList[0].name);
    }
    notifyListeners();
  }

  List<String> _selectedWorkerFlagList = <String>[];
  List<String> get selectedWorkerFlagList => _selectedWorkerFlagList;
  List<int> _selectedWorkerFlagIdList = <int>[];
  List<int> get selectedWorkerFlagIdList => _selectedWorkerFlagIdList;
  // TextEditingController selectedWorkerFlag = TextEditingController();
  // int? _selectedWorkerFlagID;
  // int? get selectedWorkerFlagID => _selectedWorkerFlagID;
  selectWorkerFlag(String flag, int id) {
    if (!_selectedWorkerFlagList.contains(flag)) {
      _selectedWorkerFlagList.add(flag);
      _selectedWorkerFlagIdList.add(id);
      notifyListeners();
    }
  }

  List<AddWorkerDropDownModel> _workerFlagList = <AddWorkerDropDownModel>[];
  List<AddWorkerDropDownModel> get workerFlagList => _workerFlagList;
  Future getFlagData({required BuildContext context}) async {
    if (_workerFlagList.isNotEmpty) {
      _workerFlagList.clear();
      workerFlagList.clear();
    }
    final result = await AddWorkerServices().getWorkerFlag(context: context);
    if (result.isNotEmpty) {
      _workerFlagList = result;
    }
    notifyListeners();
  }

  List<String> _selectedUnionAfflicationList = <String>[];
  List<String> get selectedUnionAfflicationList =>
      _selectedUnionAfflicationList;
  List<int> _selectedUnionAfflicationIdList = <int>[];
  List<int> get selectedUnionAfflicationIdList =>
      _selectedUnionAfflicationIdList;

  selectUnionAffiliation(String affiliation, int id) {
    if (!_selectedUnionAfflicationList.contains(affiliation)) {
      _selectedUnionAfflicationList.add(affiliation);
      _selectedUnionAfflicationIdList.add(id);
      // unionAffiliationController.text = affiliation;
      notifyListeners();
    }
  }

  List<AddWorkerDropDownModel> _unionAfflicationList =
      <AddWorkerDropDownModel>[];
  List<AddWorkerDropDownModel> get unionAfflicationList =>
      _unionAfflicationList;
  Future getUnionAffliciationData({required BuildContext context}) async {
    if (_unionAfflicationList.isNotEmpty) {
      _unionAfflicationList.clear();
      unionAfflicationList.clear();
    }
    final result =
        await AddWorkerServices().getUnionAfflication(context: context);
    if (result.isNotEmpty) {
      _unionAfflicationList = result;
    }
    notifyListeners();
  }

  List<String> _selectedcertificateList = <String>[];
  List<String> get selectedcertificateList => _selectedcertificateList;
  List<int> _selectedcertificateIdList = <int>[];
  List<int> get selectedcertificateIdList => _selectedcertificateIdList;
  selectCertificate(String certificate, int id) {
    if (!_selectedcertificateList.contains(certificate)) {
      _selectedcertificateList.add(certificate);
      _selectedcertificateIdList.add(id);
    }
    notifyListeners();
  }

  List<AddWorkerDropDownModel> _certificationList = <AddWorkerDropDownModel>[];
  List<AddWorkerDropDownModel> get certificationList => _certificationList;
  Future getCertificationList({required BuildContext context}) async {
    if (_certificationList.isNotEmpty) {
      _certificationList.clear();
      certificationList.clear();
    }
    final result = await AddWorkerServices().getCertificate(context: context);
    if (result.isNotEmpty) {
      _certificationList = result;
      print("Length ${_certificationList.length}");
      print(_certificationList[0].name);
    }
    notifyListeners();
  }

  int? _selectedStatusID;
  int? get selectedStatusID => _selectedStatusID;
  String _selectedStatus = '';
  String get selectedStatus => _selectedStatus;
  selectStatus(String status, int id) {
    if (!_selectedStatus.contains(status)) {
      _selectedStatus = status;
      _selectedStatusID = id;
      notifyListeners();
    }
  }

  List<AllTradeModel> _tradeOptionList = <AllTradeModel>[];
  List<AllTradeModel> get tradeOptionList => _tradeOptionList;
  Future getTradeOption({required BuildContext context}) async {
    // showLoadingIndicator(context: context);
    _tradeOptionList.clear();
    tradeOptionList.clear();

    final result = await AllTradesServices().getAllTrade(context: context);
    if (result.isNotEmpty) {
      _tradeOptionList = result;
      print(_tradeOptionList.length);
    }

    notifyListeners();
  }

  int? _tradeOptionId;
  int? get tradeOptionId => _tradeOptionId;
  String _selectedTrade = '';
  String get selectedTrade => _selectedTrade;
  selectTradeOption(String tradeOption, int id) {
    if (!_selectedTrade.contains(tradeOption)) {
      _selectedTrade = tradeOption;
      _tradeOptionId = id;
      notifyListeners();
    }
  }
}

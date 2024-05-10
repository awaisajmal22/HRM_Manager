import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/Model/add_worker_drop_down_model.dart';
import 'package:hrm_manager/Model/all_trades_model.dart';
import 'package:hrm_manager/Services/add_worker_services.dart';
import 'package:hrm_manager/Services/all_trades_Services.dart';
import 'package:hrm_manager/extensions/calculate_date.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddWorkerProvider extends ChangeNotifier {
  TextEditingController workerIdController = TextEditingController();
  TextEditingController recruiterController = TextEditingController();
  TextEditingController clientIdController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController otherLanguageController = TextEditingController();
  TextEditingController socialInsuranceController = TextEditingController();
  TextEditingController workPermitController = TextEditingController();
  TextEditingController hireDateController = TextEditingController();
  TextEditingController terminationDateController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController flagNotesController = TextEditingController();
  TextEditingController businessWSIBNoController = TextEditingController();
  TextEditingController wSIBClaimNoteController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessTelephoneController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController mobileTelephoneController = TextEditingController();
  TextEditingController homeTelephoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController emergencyContact1Controller = TextEditingController();
  TextEditingController emergencyContact2Controller = TextEditingController();
  TextEditingController emergencyTelephone1Controller = TextEditingController();
  TextEditingController emergencyTelephone2Controller = TextEditingController();
  TextEditingController tradeOptionController = TextEditingController();
  TextEditingController regularRateController = TextEditingController();
  TextEditingController overTimeRateController = TextEditingController();
  TextEditingController clientRateController = TextEditingController();
  TextEditingController workExperienceController = TextEditingController();
  TextEditingController workExperienceNoteController = TextEditingController();
  TextEditingController tradeLicenseNoController = TextEditingController();
  TextEditingController unionAffiliationController = TextEditingController();
  TextEditingController unionAffiliationNotesController =
      TextEditingController();
  TextEditingController employmentHistoryNoteController =
      TextEditingController();
  TextEditingController certificationController = TextEditingController();
  TextEditingController certificationNotesController = TextEditingController();
  TextEditingController workerPickUpLocationController =
      TextEditingController();
  TextEditingController recruiterCommissionController = TextEditingController();
  TextEditingController timeSheetTypeController = TextEditingController();
  TextEditingController paymentNotesController = TextEditingController();



 

  
int? _timeSheetTypeId;
int? get timeSheetTypeId => _timeSheetTypeId;
  changeTimeSheetType(String timeSheet,int id) {
    if (!timeSheetTypeController.text.contains(timeSheet)) {
      timeSheetTypeController.text = timeSheet;
      _timeSheetTypeId =id;
      notifyListeners();
    }
  }
int? _workerPickUpId;
int? get workerPickUpId => _workerPickUpId;
  selectWorkerPickupLocation(String location,int id) {
    if (!workerPickUpLocationController.text.contains(location)) {
      workerPickUpLocationController.text = location;
      _workerPickUpId =id;
      notifyListeners();
    }
  }
int? _certificateId;
int? get certificateId => _certificateId;
  selectCertificate(String certificate,int id) {
    if (!certificationController.text.contains(certificate)) {
      certificationController.text = certificate;
      _certificateId = id;
      notifyListeners();
    }
  }

  selectUnionAffiliation(String affiliation) {
    if (!unionAffiliationController.text.contains(affiliation)) {
      unionAffiliationController.text = affiliation;
    }
  }

  selectWorkExperience(String workExp) {
    if (!workExperienceController.text.contains(workExp)) {
      workExperienceController.text = workExp;
      notifyListeners();
    }
  }
int? _tradeOptionId;
int? get tradeOptionId => _tradeOptionId;
  selectTradeOption(String tradeOption,int id) {
    if (!tradeOptionController.text.contains(tradeOption)) {
      tradeOptionController.text = tradeOption;
      _tradeOptionId = id;
      notifyListeners();
    }
  }

  // List<String> _selectedWorkerFlagList = <String>[];
  // List<String> get selectedWorkerFlagList => _selectedWorkerFlagList;
  TextEditingController selectedWorkerFlag = TextEditingController();
 int? _selectedWorkerFlagID;
  int? get selectedWorkerFlagID => _selectedWorkerFlagID;
  selectWorkerFlag(String flag,int id) {
    // if (!_selectedWorkerFlagList.contains(flag)) {
      // _selectedWorkerFlagList.add(flag);
selectedWorkerFlag.text = flag;
_selectedWorkerFlagID = id;
      notifyListeners();
    // }
  }
int? _selectedStatusID;
int? get selectedStatusID => _selectedStatusID;
  selectStatus(String status, int id) {
    if (!statusController.text.contains(status)) {
      statusController.text = status;
      _selectedStatusID = id;
      notifyListeners();
    }
  }
int? _recruiterId;
int? get recruiterId => _recruiterId;
  selectRecruiter(String recruiter,int id) {
    if (!recruiterController.text.contains(recruiter)) {
      recruiterController.text = recruiter;
      _recruiterId =id;
      notifyListeners();
    }
  }

  List<String> _selectedJobSitesList = <String>[];
  List<String> get selectedJobSitesList => _selectedJobSitesList;
  List<int> _selectedJobSitesIDList = <int>[];
  List<int> get selectedJobSitesIDList => _selectedJobSitesIDList;

  selectJobSite(String jobSite,int id) {
    if (!_selectedJobSitesList.contains(jobSite)) {
      _selectedJobSitesList.add(jobSite);
      _selectedJobSitesIDList.add(id);
    }
    notifyListeners();
  }

  removeJobSite(int index) {
    _selectedJobSitesList.removeAt(index);
    notifyListeners();
  }

  // List<String> _selectedLanguageList = <String>[];
  // List<String> get selectedLanguageList => _selectedLanguageList;
//   String? _selectedLanguage;
// String? get selectedLanguage => _selectedLanguage;
TextEditingController selectedLanguage = TextEditingController();
  int? _selectedLanguageId;
int? get selectedLanguageId => _selectedLanguageId;

  selectLanguage(String language,int id) {
    // if (!_selectedLanguageList.contains(language)) {
    //   _selectedLanguageList.add(language);
    // }
    selectedLanguage.text = language;
    _selectedLanguageId = id;
    notifyListeners();
  }

  // removeSelectedLanguage(int index) {
  //   _selectedLanguageList.removeAt(index);
  //   notifyListeners();
  // }

  // removeWorkerFlag(int index) {
  //   _selectedWorkerFlagList.removeAt(index);
  //   notifyListeners();
  // }

  pickDateOfBirth({required BuildContext context}) async {
    DateTime? date = await showDatePicker(
        context: context, firstDate: DateTime(1947), lastDate: DateTime.now());
    if (date != null) {
      dobController.text =
          "${DateFormat.M().format(date)}/${DateFormat.d().format(date)}/${DateFormat.y().format(date)}";
          ageController.text = calculateAge(date).toString();
    }
  }

  pickTerminationDate({required BuildContext context}) async {
    DateTime? date = await showDatePicker(
        context: context, firstDate: DateTime(1947), lastDate: DateTime(2050));
    if (date != null) {
      terminationDateController.text =
          "${DateFormat.M().format(date)}/${DateFormat.d().format(date)}/${DateFormat.y().format(date)}";
    }
  }

  pickHireDate({required BuildContext context}) async {
    DateTime? date = await showDatePicker(
        context: context, firstDate: DateTime(1947), lastDate: DateTime(2050));
    if (date != null) {
      hireDateController.text =
          "${DateFormat.M().format(date)}/${DateFormat.d().format(date)}/${DateFormat.y().format(date)}";
    }
  }

// Yes No Options
  int _isEnglishFluence = 0;
  int get isEnglishFluence => _isEnglishFluence;
  changeEnglishFLunecy(int index) {
    _isEnglishFluence = index;
    notifyListeners();
  }

  int _pastWSIBClaim = 0;
  int get pastWSIBClaim => _pastWSIBClaim;
  changePastWSIBClaim(int index) {
    _pastWSIBClaim = index;
    notifyListeners();
  }

  int _islegalToWork = 0;
  int get islegalToWork => _islegalToWork;
  changeLegalToWork(int index) {
    _islegalToWork = index;
    notifyListeners();
  }

  int _isOwnTransport = 0;
  int get isOwnTransport => _isOwnTransport;
  changeOwnTransport(int index) {
    _isOwnTransport = index;
    notifyListeners();
  }

  int _recruiterPaymentDelivery = 0;
  int get recruiterPaymentDelivery => _recruiterPaymentDelivery;
  changeRecruiterPaymentDelivery(int index) {
    _recruiterPaymentDelivery = index;
    notifyListeners();
  }

  int _submitOwnHours = 0;
  int get submitOwnHours => _submitOwnHours;
  changeSubmitOwnHours(int index) {
    _submitOwnHours = index;
    notifyListeners();
  }

  int _clientPaysWSIB = 0;
  int get clientPaysWSIB => _clientPaysWSIB;
  changeClientPaysWSIB(int index) {
    _clientPaysWSIB = index;
    notifyListeners();
  }

  //File Pickers
// WHIMS
  String _wHIMSFilePath = '';
  String get wHIMSFilePath => _wHIMSFilePath;
  String _wHIMSFileName = 'Choose File';
  String get wHIMSFileName => _wHIMSFileName;
  pickWHIMS() async {
    FilePickerResult? file = await FilePicker.platform.pickFiles();
    if (file != null) {
      _wHIMSFilePath = file.files.single.path!;
      _wHIMSFileName = file.files.single.name;
    }
    notifyListeners();
  }

// Working Form Heights
  String _workingFormHeightPath = '';
  String get workingFormHeightPath => _workingFormHeightPath;
  String _workingFormHeightName = 'Choose File';
  String get workingFormHeightName => _workingFormHeightName;
  pickWorkingFormHeightFile() async {
    FilePickerResult? file = await FilePicker.platform.pickFiles();
    if (file != null) {
      _workingFormHeightPath = file.files.single.path!;
      _workingFormHeightName = file.files.single.name;
    }
    notifyListeners();
  }

// FIrst Aid
  String _firstAidPath = '';
  String get firstAidPath => _firstAidPath;
  String _firstAidName = 'Choose File';
  String get firstAidName => _firstAidName;
  pickFirstAidFile() async {
    FilePickerResult? file = await FilePicker.platform.pickFiles();
    if (file != null) {
      _firstAidPath = file.files.single.path!;
      _firstAidName = file.files.single.name;
    }
    notifyListeners();
  }

// Terms Of Employment
  String _termsOfEmpPath = '';
  String get termsOfEmpPath => _termsOfEmpPath;
  String _termsOfEmpName = 'Choose File';
  String get termsOfEmpName => _termsOfEmpName;
  pickTermsOfEmpFile() async {
    FilePickerResult? file = await FilePicker.platform.pickFiles();
    if (file != null) {
      _termsOfEmpPath = file.files.single.path!;
      _termsOfEmpName = file.files.single.name;
    }
    notifyListeners();
  }

// Employment Release
  String _empReleasePath = '';
  String get empReleasePath => _empReleasePath;
  String _empReleaseName = 'Choose File';
  String get empReleaseName => _empReleaseName;
  pickEmpReleaseFile() async {
    FilePickerResult? file = await FilePicker.platform.pickFiles();
    if (file != null) {
      _empReleasePath = file.files.single.path!;
      _empReleaseName = file.files.single.name;
    }
    notifyListeners();
  }

// Other File
  String _otherFilePath = '';
  String get otherFilePath => _otherFilePath;
  String _otherFileName = 'Choose File';
  String get otherFileName => _otherFileName;
  pickOtherFile() async {
    FilePickerResult? file = await FilePicker.platform.pickFiles();
    if (file != null) {
      _otherFilePath = file.files.single.path!;
      _otherFileName = file.files.single.name;
    }
    notifyListeners();
  }

  //Image Picker
  String _pickedImage = '';
  String get pickedImage => _pickedImage;
  pickImage() async {
    XFile? image = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.gallery);
    if (image != null) {
      _pickedImage = image.path;
      notifyListeners();
    }
  }

  void clearData() {
    workerIdController.clear();
    recruiterController.clear();
    clientIdController.clear();
    firstNameController.clear();
    lastNameController.clear();
    dobController.clear();
    ageController.clear();
    otherLanguageController.clear();
    socialInsuranceController.clear();
    workPermitController.clear();
    hireDateController.clear();
    terminationDateController.clear();
    statusController.clear();
    flagNotesController.clear();
    businessWSIBNoController.clear();
    wSIBClaimNoteController.clear();
    businessNameController.clear();
    businessTelephoneController.clear();
    address1Controller.clear();
    address2Controller.clear();
    cityController.clear();
    provinceController.clear();
    postalCodeController.clear();
    countryController.clear();
    mobileTelephoneController.clear();
    homeTelephoneController.clear();
    emailController.clear();
    emergencyContact1Controller.clear();
    emergencyContact2Controller.clear();
    emergencyTelephone1Controller.clear();
    emergencyTelephone2Controller.clear();
    tradeOptionController.clear();
    regularRateController.clear();
    overTimeRateController.clear();
    clientRateController.clear();
    workExperienceController.clear();
    workExperienceNoteController.clear();
    tradeLicenseNoController.clear();
    unionAffiliationController.clear();
    unionAffiliationNotesController.clear();
    employmentHistoryNoteController.clear();
    certificationController.clear();
    certificationNotesController.clear();
    workerPickUpLocationController.clear();
    recruiterCommissionController.clear();
    timeSheetTypeController.clear();
    paymentNotesController.clear();
  }

  List<AddWorkerDropDownModel> _workerExperienceList =
      <AddWorkerDropDownModel>[];
  List<AddWorkerDropDownModel> get workerExperienceList =>
      _workerExperienceList;
  getExperienceData({required BuildContext context}) async {
    if (_workerExperienceList.isNotEmpty) {
      _workerExperienceList.clear();
      workerExperienceList.clear();
    }
    final result =
        await AddWorkerServices().getWorkerExperience(context: context);
    if (result.isNotEmpty) {
      _workerExperienceList = result;
      print("Length ${_workerExperienceList.length}");
      print(_workerExperienceList[0].name);
    }
    notifyListeners();
  }

  List<AddWorkerDropDownModel> _unionAfflicationList =
      <AddWorkerDropDownModel>[];
  List<AddWorkerDropDownModel> get unionAfflicationList =>
      _unionAfflicationList;
  getUnionAffliciationData({required BuildContext context}) async {
    if (_unionAfflicationList.isNotEmpty) {
      _unionAfflicationList.clear();
      unionAfflicationList.clear();
    }
    final result =
        await AddWorkerServices().getUnionAfflication(context: context);
    if (result.isNotEmpty) {
      _unionAfflicationList = result;
      print("Length ${_unionAfflicationList.length}");
      print(_unionAfflicationList[0].name);
    }
    notifyListeners();
  }

  List<AddWorkerDropDownModel> _jobSitesList = <AddWorkerDropDownModel>[];
  List<AddWorkerDropDownModel> get jobSitesList => _jobSitesList;

  getJobSiteData({required BuildContext context}) async {
    if (_jobSitesList.isNotEmpty) {
      _jobSitesList.clear();
      jobSitesList.clear();
    }
    final result = await AddWorkerServices().getJobSite(context: context);
    if (result.isNotEmpty) {
      _jobSitesList = result;
      print("Length ${_jobSitesList.length}");
      print(_jobSitesList[0].name);
    }
    notifyListeners();
  }

  List<AddWorkerDropDownModel> _recruiterList = <AddWorkerDropDownModel>[];
  List<AddWorkerDropDownModel> get recruiterList => _recruiterList;
  getRecruiterData({required BuildContext context}) async {
    if (_recruiterList.isNotEmpty) {
      _recruiterList.clear();
      recruiterList.clear();
    }
    final result = await AddWorkerServices().getRecruiter(context: context);
    if (result.isNotEmpty) {
      _recruiterList = result;
      print("Length ${_recruiterList.length}");
      print(_recruiterList[0].name);
    }
    notifyListeners();
  }

  List<AddWorkerDropDownModel> _languagesList = <AddWorkerDropDownModel>[];
  List<AddWorkerDropDownModel> get languagesList => _languagesList;
  getLanguagesData({required BuildContext context}) async {
    if (_languagesList.isNotEmpty) {
      _languagesList.clear();
      languagesList.clear();
    }
    final result = await AddWorkerServices().getLanguage(context: context);
    if (result.isNotEmpty) {
      _languagesList = result;
      print("Length ${_languagesList.length}");
      print(_languagesList[0].name);
    }
    notifyListeners();
  }

  List<AddWorkerDropDownModel> _certificationList = <AddWorkerDropDownModel>[];
  List<AddWorkerDropDownModel> get certificationList => _certificationList;
  getCertificationList({required BuildContext context}) async {
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

  List<AddWorkerDropDownModel> _workerPickUpLocationList =
      <AddWorkerDropDownModel>[];
  List<AddWorkerDropDownModel> get workerPickUpLocationList =>
      _workerPickUpLocationList;
  getWorkerPickupLocationData({required BuildContext context}) async {
    if (_workerPickUpLocationList.isNotEmpty) {
      _workerPickUpLocationList.clear();
      workerPickUpLocationList.clear();
    }
    final result = await AddWorkerServices().getWorkerPickupLocation(context: context);
    if (result.isNotEmpty) {
      _workerPickUpLocationList = result;
      print("Length ${_workerPickUpLocationList.length}");
      print(_workerPickUpLocationList[0].name);
    }
    notifyListeners();
  }
  List<AddWorkerDropDownModel> _timeSheetTypeList =
      <AddWorkerDropDownModel>[];
  List<AddWorkerDropDownModel> get timeSheetTypeList =>
      _timeSheetTypeList;
  getTimeSheetTypeData({required BuildContext context}) async {
    if (_timeSheetTypeList.isNotEmpty) {
      _timeSheetTypeList.clear();
      timeSheetTypeList.clear();
    }
    final result = await AddWorkerServices().getTimeSheet(context: context);
    if (result.isNotEmpty) {
      _timeSheetTypeList = result;
      print("Length ${_timeSheetTypeList.length}");
      print(_timeSheetTypeList[0].name);
    }
    notifyListeners();
  }
  
  List<AddWorkerDropDownModel> _workerStatusList =
      <AddWorkerDropDownModel>[];
  List<AddWorkerDropDownModel> get workerStatusList =>
      _workerStatusList;
  getStatusData({required BuildContext context}) async {
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
  List<AddWorkerDropDownModel> _workerFlagList =
      <AddWorkerDropDownModel>[];
  List<AddWorkerDropDownModel> get workerFlagList =>
      _workerFlagList;
  getFlagData({required BuildContext context}) async {
    if (_workerFlagList.isNotEmpty) {
      _workerFlagList.clear();
      workerFlagList.clear();
    }
    final result = await AddWorkerServices().getWorkerFlag(context: context);
    if (result.isNotEmpty) {
      _workerFlagList = result;
      print("Length ${_workerFlagList.length}");
      print(_workerFlagList[0].name);
    }
    notifyListeners();
  }
 
List<AllTradeModel> _tradeOptionList = <AllTradeModel>[];
List<AllTradeModel> get tradeOptionList => _tradeOptionList;
 Future getTradeOption({required BuildContext context}) async {
  // showLoadingIndicator(context: context);
  _tradeOptionList.clear();
  tradeOptionList.clear();
  
final result =await AllTradesServices().getAllTrade(context: context);
if(result.isNotEmpty){
  _tradeOptionList = result;
  print(_tradeOptionList.length);
  
}

notifyListeners();
 }
  

  Future addWorkerData({
  required BuildContext context, 
  int? workerID,
  String? internalWorkerID,
  String? clientWorkerID,
  int? age,
  String? firstName,
  String? nameContact1,
  String? mobileContact1,
  String? emailContact1,
  String? titleContact1,
  String? emailAdminContact1,
  String? constructorAdminPhone,
  String? adminEmail,
  String? adminExtension,
  String? addedDate,
  int? workerPickupLocation,
  int? recruiterAssingId,
  String? lastName,
  String? socialInsuranceNo,
  String? businessName,
  String? businessRegNo,
  String? businessWIBSno,
  String? address1,
  String? address2,
  String? state,
  String? province,
  String? postalCode,
String? country,
String? city,
String? fax,
String? homeTele,
String? businessTele,
String? mobile,
String? email,
String? paymentNotes,
String? workExperience,
String? workExperienceNotes,
String? employeHistoryNotes,
String? unionAffliciationId,
String? unionAffliciationNotes,
bool? paymentDelivery,
bool? submitOwnHours,
bool? pastWIBSClaim,
String? wibsClaimNotes,
bool? isTeamLeader,
bool? legalToWork,
bool? twoRateSimple,
double? dollarFlatRate,
double? percentageRate,
double? adminFeePercentageRate,
double? transactionFee,
bool? paymentProcessor,
bool? isDefaultBooth,
double? managementFee,
double? fundsAdvanceFeeRate,
String? workerHireDate,
String? workerTerminateDate,
String? dateOfBirth,
double? regularRate,
bool? isRecruiterComission,
double? recruiterComission,
double? billRate,
String? tradeLicenseNo,
int? paymentRuleId,
String? workerFlagId,
int? workerStatusId,
String? languageId,
String? workPermitNo,
bool? ownTransport,
bool? englishFluency,
String? notes,
bool? clientPayWSIB,
double? wsibRate,
int? tradeOptionId,
String? certificationId,
String? certificationNotes,
String? unionAffilation,
String? unionAffilationNotes,
String? emergencyContact1,
double? overTimeRate,
String? emergencyContact2,
String? emergencyTele1,
String? emergencyTele2,
int? timeSheetType,
List<int>? jobSites,
required String whimsFilePath,
required String profileImage,
required String workingFormHeightFilePath,
required String termsOfEmployeFilePath,
required String firstAidFilePath,
required String otherFilePath,
required String employementReleaseFilePath,

}) async{
  final result = await AddWorkerServices().addWorker(context: context,
  whimsFilePath: whimsFilePath,
  profileImage: profileImage,
  workingFormHeightFilePath: workingFormHeightFilePath,
  termsOfEmployeFilePath: termsOfEmployeFilePath,
  firstAidFilePath: firstAidFilePath,
  otherFilePath: otherFilePath,
  employementReleaseFilePath: employementReleaseFilePath,
  workerID :workerID,
  internalWorkerID: internalWorkerID,
 clientWorkerID : clientWorkerID,
   age : age,
 firstName:firstName,
 nameContact1: nameContact1,
  mobileContact1: mobileContact1,
 emailContact1:emailContact1,
 titleContact1:titleContact1,
 emailAdminContact1:emailAdminContact1,
  constructorAdminPhone:constructorAdminPhone,
  adminEmail:adminEmail,
 adminExtension:adminExtension,
 addedDate:addedDate,
 workerPickupLocation:workerPickupLocation,
  recruiterAssingId:recruiterAssingId,
  lastName:lastName,
  socialInsuranceNo:socialInsuranceNo,
   businessName:businessName,
  businessRegNo:businessRegNo,
  businessWIBSno: businessWIBSno,
  address1: address1,
 address2: address2,
 state:state,
  province:province,
 postalCode:postalCode,
country:country,
city:city,
fax:fax,
homeTele:homeTele,
businessTele:businessTele,
 mobile:mobile,
email:email,
 paymentNotes:paymentNotes,
 workExperience:workExperience,
workExperienceNotes:workExperienceNotes,
employeHistoryNotes:employeHistoryNotes,
unionAffliciationId:unionAffliciationId,
 unionAffliciationNotes:unionAffilationNotes,
 paymentDelivery:paymentDelivery,
submitOwnHours:submitOwnHours,
 pastWIBSClaim:pastWIBSClaim,
wibsClaimNotes:wibsClaimNotes,
isTeamLeader:isTeamLeader,
legalToWork:legalToWork,
twoRateSimple:twoRateSimple,
dollarFlatRate:dollarFlatRate,
percentageRate:percentageRate,
adminFeePercentageRate:adminFeePercentageRate,
transactionFee:transactionFee,
 paymentProcessor:paymentProcessor,
isDefaultBooth:isDefaultBooth,
managementFee:managementFee,
fundsAdvanceFeeRate:fundsAdvanceFeeRate,
workerHireDate:workerHireDate,
workerTerminateDate:workerTerminateDate,
dateOfBirth:dateOfBirth,
 regularRate:regularRate,
isRecruiterComission:isRecruiterComission,
recruiterComission:recruiterComission,
 billRate:billRate,
tradeLicenseNo:tradeLicenseNo,
 paymentRuleId:paymentRuleId,
workerFlagId:workerFlagId,
workerStatusId:workerStatusId,
 languageId:languageId,
 workPermitNo:workPermitNo,
ownTransport:ownTransport,
englishFluency:englishFluency,
 notes:notes,
 clientPayWSIB:clientPayWSIB,
 wsibRate:wsibRate,
tradeOptionId:tradeOptionId,
certificationId:certificationId,
certificationNotes:certificationNotes,
unionAffilation:unionAffilation,
unionAffilationNotes:unionAffilationNotes,
emergencyContact1:emergencyContact1,
overTimeRate:overTimeRate,
emergencyContact2:emergencyContact2,
 emergencyTele1:emergencyTele1,
emergencyTele2:emergencyTele2,
timeSheetType:timeSheetType,
jobSites : jobSites,
  );
}
}

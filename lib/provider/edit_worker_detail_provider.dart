import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditWorkerDetailProvider extends ChangeNotifier {
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
  TextEditingController workerPickUpLocationController = TextEditingController();
  TextEditingController recruiterCommissionController = TextEditingController();
  TextEditingController timeSheetTypeController = TextEditingController();
  TextEditingController paymentNotesController = TextEditingController();

  List<String> jobSitesList = <String>[
    "js1",
    "js2",
    'js3',
    'js4',
  ];
  List<String> languagesList = <String>[
    "Hindi",
    "Itailan",
    "Russian",
  ];
  List<String> recruiterList = <String>[
    "RC1",
    "RC2",
    "RC3",
  ];

  List<String> workerStatusList = <String>[
    "Candidate",
    "Now On Site",
    "On Leave",
    "Ready To Work",
    "Inactive",
  ];

  List<String> workerFlagList = <String>[
    "Do Not Rehire",
    "Incomplete Info",
    "No Papers",
    "Poor Health",
    "Special Circumstances",
  ];

  List<String> tradeOptionList = <String>[
    'Crane Operator',
    'Formwork Carpanter',
    'Formwork Forman',
    'Labour Forman',
    'Steelman',
    'Steelman Forman',
    'Swamper',
    'Concrete Finisher',
  ];

  List<String> workExperienceList = <String>[
    'Crane Operator',
    'Formwork Carpanter',
    'Formwork Forman',
    'Labour Forman',
    'General Labour'
        'Steelman',
    'Steelman Forman',
    'Swamper',
    'Concrete Finisher',
  ];

  List<String> unionAffiliationList = <String>[
    'Labourers',
    'Operating Engineers',
    'Painters & Allied Trades',
    'Plasterers & Cement Masons',
    'Plumbing & Pipefitting',
  ];

  List<String> certificationList = <String>[
    'Fall Arrest',
    "First Aid",
    'WHMIS',
  ];

  List<String> workerPickUpLocationList = <String>[
    "DB1",
    "DB2",
    "DB3",
  ];

  List<String> timeSheetTypeList = <String>[
    "Weekly Total",
    "Daily Detail",
  ];
changeTimeSheetType(String timeSheet){
  if(!timeSheetTypeController.text.contains(timeSheet)){
    timeSheetTypeController.text = timeSheet;
    notifyListeners();
  }
}
  selectWorkerPickupLocation(String location){
if(!workerPickUpLocationController.text.contains(location)){
  workerPickUpLocationController.text = location;
  notifyListeners();
}

  }
  selectCertificate(String certificate) {
    if (!certificationController.text.contains(certificate)) {
      certificationController.text = certificate;
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

  selectTradeOption(String tradeOption) {
    if (!tradeOptionController.text.contains(tradeOption)) {
      tradeOptionController.text = tradeOption;
      notifyListeners();
    }
  }

  List<String> _selectedWorkerFlagList = <String>[];
  List<String> get selectedWorkerFlagList => _selectedWorkerFlagList;
  selectWorkerFlag(String flag) {
    if (!_selectedWorkerFlagList.contains(flag)) {
      _selectedWorkerFlagList.add(flag);
      notifyListeners();
    }
  }

  selectStatus(String status) {
    if (!statusController.text.contains(status)) {
      statusController.text = status;
      notifyListeners();
    }
  }

  selectRecruiter(String recruiter) {
    if (!recruiterController.text.contains(recruiter)) {
      recruiterController.text = recruiter;
      notifyListeners();
    }
  }

  List<String> _selectedJobSitesList = <String>[];
  List<String> get selectedJobSitesList => _selectedJobSitesList;

  selectJobSite(String jobSite) {
    if (!_selectedJobSitesList.contains(jobSite)) {
      _selectedJobSitesList.add(jobSite);
    }
    notifyListeners();
  }

  List<String> _selectedLanguageList = <String>[];
  List<String> get selectedLanguageList => _selectedLanguageList;

  selectLanguage(String language) {
    if (!_selectedLanguageList.contains(language)) {
      _selectedLanguageList.add(language);
    }
    notifyListeners();
  }

  removeSelectedLanguage(int index) {
    _selectedLanguageList.removeAt(index);
    notifyListeners();
  }

  removeWorkerFlag(int index) {
    _selectedWorkerFlagList.removeAt(index);
    notifyListeners();
  }

  pickDateOfBirth({required BuildContext context}) async {
    DateTime? date = await showDatePicker(
        context: context, firstDate: DateTime(1947), lastDate: DateTime.now());
    if (date != null) {
      dobController.text =
          "${DateFormat.M().format(date)}/${DateFormat.d().format(date)}/${DateFormat.y().format(date)}";
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
    FilePickerResult? file = await FilePicker.platform.pickFiles(
       
    );
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
    FilePickerResult? file = await FilePicker.platform.pickFiles(
       
    );
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
    FilePickerResult? file = await FilePicker.platform.pickFiles(
       
    );
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
    FilePickerResult? file = await FilePicker.platform.pickFiles(
       
    );
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
    FilePickerResult? file = await FilePicker.platform.pickFiles(
       
    );
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
    FilePickerResult? file = await FilePicker.platform.pickFiles(
       
    );
    if (file != null) {
      _otherFilePath = file.files.single.path!;
      _otherFileName = file.files.single.name;
    }
    notifyListeners();
  }

  //Image Picker
  String _pickedImage ='';
  String get pickedImage => _pickedImage;
  pickImage()async{
    XFile? image = await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery);
    if(image != null){
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
}

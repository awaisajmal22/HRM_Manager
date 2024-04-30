import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    'Formwork Carpanter','Formwork Forman',
    'Labour Forman',
    'Steelman',
    'Steelman Forman',
    'Swamper',
    'Concrete Finisher',
  ];

  List<String> workExperienceList = <String>[
     'Crane Operator',
    'Formwork Carpanter','Formwork Forman',
    'Labour Forman',
    'General Labour'
    'Steelman',
    'Steelman Forman',
    'Swamper',
    'Concrete Finisher',
  ];
  selectWorkExperience(String workExp){
    if(!workExperienceController.text.contains(workExp)){
      workExperienceController.text = workExp;
      notifyListeners();
    }
  }
  selectTradeOption(String tradeOption){
    if(!tradeOptionController.text.contains(tradeOption)){
      tradeOptionController.text = tradeOption;
      notifyListeners();
    }
  }
List<String> _selectedWorkerFlagList = <String>[];
List<String> get selectedWorkerFlagList => _selectedWorkerFlagList;
  selectWorkerFlag(String flag){
if(!_selectedWorkerFlagList.contains(flag)){
  _selectedWorkerFlagList.add(flag);
  notifyListeners();
}
  }
  selectStatus(String status){
    if(!statusController.text.contains(status)){
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
}

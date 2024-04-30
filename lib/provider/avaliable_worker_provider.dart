import 'package:flutter/cupertino.dart';

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
}

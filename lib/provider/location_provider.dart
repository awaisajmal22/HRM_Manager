import 'package:flutter/material.dart';
import 'package:hrm_manager/Model/location_model.dart';
import 'package:hrm_manager/Services/location_services.dart';

class LocationProvider extends ChangeNotifier {
  TextEditingController locationController = TextEditingController();
  String _selectedLocation = "Toronto";
  int _selectedLocationIndex = -1;
  int get seletcedLocationIndex => _selectedLocationIndex;
  String get selectedLocation => _selectedLocation;

  selectLocation(String location, int index) {
    _selectedLocation = location;
    _selectedLocationIndex = index;
    notifyListeners();
  }

  List<LocationModel> _searchedList = <LocationModel>[];
  List<LocationModel> get searchedList => _searchedList;
  clearSearchData() {
    _searchedList.clear();
    searchedList.clear();
    notifyListeners();
  }

  clearSearch() {
    _searchedList.clear();
    searchedList.clear();
  }

  searchQuery(String value) {
    _searchedList.clear();
    searchedList.clear();
    _searchedList = _locationList
        .where((element) => "${element.city!} ${element.postalCode}"
            .toLowerCase()
            .contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }

  List<LocationModel> _locationList = <LocationModel>[];
  List<LocationModel> get locationList => _locationList;
  getLocationData({required BuildContext context}) async {
    final result = await LocationServices().getLocation(context: context);
    if (result.isNotEmpty) {
      _locationList = result;
    }
  }
}

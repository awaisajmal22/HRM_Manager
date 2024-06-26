import 'package:flutter/material.dart';

class LocationProvider extends ChangeNotifier{
  TextEditingController locationController = TextEditingController();
String _selectedLocation = "Toronto, CA";
int _selectedLocationIndex = 1;
int get seletcedLocationIndex => _selectedLocationIndex;
String get selectedLocation => _selectedLocation;
  List<String> locations = <String>[
    "Current Location",
    "Toronto, CA",
    "Orient Commercial",
    "United Properites",
    "Diamond Trading Estates",
    "South Coast Marketplace",
  ];
 
  selectLocation(String location,int index){
    _selectedLocation = location;
    _selectedLocationIndex =index;
    notifyListeners();
  }
}
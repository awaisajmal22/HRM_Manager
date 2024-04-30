import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  List<String> tradesList = <String>[
    "All trades",
    "Cleaning",
    "Repairing",
    "Painting",
    "Plumber",
    "Carpenter",
    "Electrician",
  ];
  List<String> _searchedList = <String>[];
  List<String> get searchedList => _searchedList;
  searchTrading(String query) {
    _searchedList.clear();
    searchedList.clear();
    _searchedList =
        tradesList.where((element) => element.toLowerCase().contains(query.toLowerCase())).toList();

    notifyListeners();
  }
}

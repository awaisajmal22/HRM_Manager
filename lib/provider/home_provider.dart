import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrm_manager/Model/all_trades_model.dart';
import 'package:hrm_manager/Services/all_trades_Services.dart';
import 'package:hrm_manager/constant/spinkit_view.dart';

class HomeProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
 
  List<AllTradeModel> _searchedList = <AllTradeModel>[];
  List<AllTradeModel> get searchedList => _searchedList;
  
List<AllTradeModel> _tradesList = <AllTradeModel>[];
List<AllTradeModel> get tradesList => _tradesList;
 Future getAllTradeFunc({required BuildContext context}) async {
  // showLoadingIndicator(context: context);
  _tradesList.clear();
  tradesList.clear();
  
final result =await AllTradesServices().getAllTrade(context: context);
if(result.isNotEmpty){
  result.sort((a, b) => a.tradeOptionName!.compareTo(b.tradeOptionName!));
  _tradesList = result;
  print(_tradesList.length);
  
}

notifyListeners();
 }
searchTrading(String query) {
    _searchedList.clear();
    searchedList.clear();
    _searchedList =
        tradesList.where((element) => element.tradeOptionName!.toLowerCase().contains(query.toLowerCase())).toList();

    notifyListeners();
  }
}

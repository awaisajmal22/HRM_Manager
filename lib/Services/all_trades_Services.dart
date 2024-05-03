import 'package:flutter/cupertino.dart';
import 'package:hrm_manager/Model/all_trades_model.dart';
import 'package:hrm_manager/Network/api_services.dart';
import 'package:hrm_manager/Network/api_url.dart';
import 'package:hrm_manager/constant/spinkit_view.dart';

class AllTradesServices{
  Future<List<AllTradeModel>> getAllTrade({required BuildContext context})async{
    List<AllTradeModel> allTradeModel = <AllTradeModel>[];
try{
final response = await API().getRequest(context, ApiUrl.allTradeUrl);
if(response.statusCode == 200){
  response.data.forEach((data)=> allTradeModel.add(AllTradeModel.fromJson(data)));
}
}catch(e){

}
    return allTradeModel;
  }
}
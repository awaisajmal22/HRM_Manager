import 'package:flutter/cupertino.dart';
import 'package:hrm_manager/Model/location_model.dart';
import 'package:hrm_manager/Network/api_services.dart';
import 'package:hrm_manager/Network/api_url.dart';

class LocationServices{
 Future<List<LocationModel>> getLocation({required BuildContext context}) async{
  List<LocationModel> locations = <LocationModel>[];
    try{
final response = await API().getRequestHeader(context, ApiUrl.getLocationUrl);
if(response.statusCode == 200){
response.data.forEach((e)=> locations.add(LocationModel.fromJson(e)));
}
    }catch(e){

    }
    return locations;
  }
}
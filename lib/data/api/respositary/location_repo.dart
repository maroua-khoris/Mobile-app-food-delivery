import 'package:get/get_connect/http/src/response/response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Pages/AppConstant.dart';
import '../../../models/Adresse_Model.dart';
import '../ApiClient.dart';

class Location_repo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  Location_repo({required this.apiClient, required this.sharedPreferences});
  getAddressfromGeocode(LatLng latLng)async{
    return await apiClient.getAddress('${AppConstant.geocode_url}'
      '?lat=${latLng.latitude}&lng=${latLng.longitude}'

    );
  }
  String getUserAddress(){
    return sharedPreferences.getString(AppConstant.user_address)??"";
  }
  Future<Response> addAdress(AdresseModel addressModel) async{
    return await apiClient.postData(AppConstant.ADD_user_address, addressModel.toJson());
  }
  getAllAddress()async{
    return await apiClient.getAllAdresse(AppConstant.Address_List_URL);
  }
  Future<bool> SaveUserAdddress(String Address) async{
    apiClient.updateHeader(sharedPreferences.getString(AppConstant.TOKEN)!);
    return await sharedPreferences.setString(AppConstant.user_address, Address);
  }
  getZone(String lat, String lng)async{
    return await apiClient.getZone('${AppConstant.zone_url}?lat=$lat&lng=$lng');
  }
  getinZone(){
    return apiClient.inZone;
  }
  searchLocation(String text)async{
    return await apiClient.getPredictions('${AppConstant.SEARCH_LOCATION_URL}?search_text=$text');
  }
  SetLocation(String placeId) async{
    return await apiClient.getLocation('${AppConstant.PLACE_DETAILS_URL}?placeid=$placeId');
  }


}
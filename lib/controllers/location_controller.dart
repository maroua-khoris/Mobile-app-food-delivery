import 'dart:convert';

import 'package:application/data/api/respositary/location_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Pages/AppConstant.dart';
import '../data/api/api_checker.dart';
import '../models/Adresse_Model.dart';
import '../models/response_model.dart';
import 'package:google_maps_webservice/src/places.dart';

class LocationController extends GetxController implements GetxService{
  final Location_repo location_repo;
  LocationController({ required this.location_repo});
  bool _loading=false;
  late Position _position;
  late Position _pickposition;
  Placemark _placemark = Placemark();
  Placemark _pickplacemark=Placemark();
  List<AdresseModel> _adresselist=[];
  Placemark get placemark=>_placemark;
  Placemark get pickplacemark=>_pickplacemark;
  List<AdresseModel> get addresslist=>_adresselist;
  late List<AdresseModel> _alladresslist;
  List<AdresseModel> get alladresslist=>_alladresslist;
  List<String> _addressTypelist=["home", "office", "others"];
  List<String> get addressTypeList=>_addressTypelist;
  int _addressTypeIndex=0;
  int get addressTypeIndex=>_addressTypeIndex;
  bool get loading=>_loading;
  Position get position=>_position;
  Position get pickPosition=>_pickposition;
  bool _isLoading =false;
  bool get isLoading=>_isLoading;
  bool _inZone=false;
  bool get inZone=>_inZone;
  bool _buttondisable=true;
  bool get buttondisabl=>_buttondisable;
  late GoogleMapController _mapController;
  GoogleMapController get mapController=>_mapController;
  bool _updateAddressData=true;
  bool get updateAddressData=>_updateAddressData;
  bool _changeAddres=true;
  List<Prediction> _predictionList =[];

  void setMapController(GoogleMapController mapController){
    _mapController=mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async{
    if(_updateAddressData){
      _loading=true;
      update();
      try{
        if(fromAddress){
          _position=Position(longitude: position.target.longitude, latitude: position.target.latitude,
              timestamp: DateTime.now(), accuracy: 1, altitude: 1,
              heading: 1, speed: 1, speedAccuracy: 1, altitudeAccuracy: 1, headingAccuracy: 1);
        }else{
          _pickposition=Position(longitude: position.target.longitude, latitude: position.target.latitude,
              timestamp: DateTime.now(), accuracy: 1, altitude: 1,
              heading: 1, speed: 1, speedAccuracy: 1, altitudeAccuracy: 1, headingAccuracy: 1);
        }
        ResponseModel _responseModel= await getZone(position.target.latitude.toString(), position.target.longitude.toString(), false);
        _buttondisable=!_responseModel.isSucess;
        if(_changeAddres){
          String _address=await getAddressfromGeocode(
              LatLng(position.target.latitude, position.target.longitude),
          );
          fromAddress?_placemark=Placemark(name: _address):_pickplacemark=Placemark(name: _address);
        }else {
          _changeAddres=true;
        }
      }catch(e){
        print(e);
      }
      _loading=false;
      update();

    }else {
      _updateAddressData=true;
    }
  }
  getAddressfromGeocode(LatLng latLng) async{
    String _address="aucune addresse n'est trouvée";
    _address=await location_repo.getAddressfromGeocode(latLng);
    update();
    return _address;
  }
  late Map<String, dynamic> _getAddress;
  Map get getAddress=>_getAddress;
  AdresseModel getuserAddress() {
    late AdresseModel _addressModel;
    _getAddress= jsonDecode(location_repo.getUserAddress());
    try{
      _addressModel = AdresseModel.fromJson(jsonDecode(location_repo.getUserAddress()));
    }catch(e){
      print(e);
    }
    return _addressModel;
  }
  void setAddressTypeIndex(int index){
    _addressTypeIndex=index;
    update();
  }
  Future<ResponseModel> addAddress(AdresseModel adresseModel)async{
    _loading=true;
    update();
    Response response=await location_repo.addAdress(adresseModel);
    ResponseModel responseModel;
    if(response.statusCode==200){
      await getAddressLIst();
      String message= response.body["message"];
      responseModel=ResponseModel(true, message);
      await SaveUserAddress(adresseModel);
      _loading=false;
    }else{
      print("l'addresse n'est pas enregistrer");
      responseModel=ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> getAddressLIst()async{
    _adresselist = await location_repo.getAllAddress();
      _alladresslist=[];
    for (var address in _adresselist) {
        _alladresslist.add(address);
      }
    update();
  }
  Future<bool> SaveUserAddress(AdresseModel adresseModel)async{
    String userAddress=jsonEncode(adresseModel.toJson());
    return await location_repo.SaveUserAdddress(userAddress);
  }
  void clearAddressList(){
    _adresselist=[];
    _alladresslist=[];
    update();
  }

  String getuserAddressFromLocalStorage(){
    return location_repo.getUserAddress();
  }
  void setAddAdressData(){
    _position=_pickposition;
    _placemark=_pickplacemark;
    _updateAddressData=false;
    update();

  }

  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad)async{
    late ResponseModel _responseModel;
    if(markerLoad){
      _loading=true;
    }else{
      _isLoading=true;
    }
    _responseModel = await location_repo.getZone(lat, lng);
    print("response model"+_responseModel.message);
    _inZone=location_repo.getinZone();
    if(markerLoad){
      _loading=false;
    }else{
      _isLoading=false;
    }
    update();
    return _responseModel;

  }
  Future<List<Prediction>> searchLocation(BuildContext context, String text) async{
    if(text.isNotEmpty){
      _predictionList=await location_repo.searchLocation(text);
      print("predictions "+_predictionList.toString());
    }
    return _predictionList;
  }
  setLocation(String placeID, String address, GoogleMapController mapController) async{
    _loading=true;
    update();
    PlacesDetailsResponse detailsResponse;
    detailsResponse=await location_repo.SetLocation(placeID);
    _pickposition=Position(
        latitude :detailsResponse.result.geometry!.location.lat,
      longitude: detailsResponse.result.geometry!.location.lng,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1, altitudeAccuracy: 1, headingAccuracy: 1,
    );
    _pickplacemark=Placemark(name: address);
    _changeAddres=false;
    if(!mapController.isNull){
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(
          detailsResponse.result.geometry!.location.lat,
          detailsResponse.result.geometry!.location.lng
        ),zoom: 15)
      ));
    }
    _loading=false;
    update();

  }



  }


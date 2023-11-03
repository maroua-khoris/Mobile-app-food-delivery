import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Pages/AppConstant.dart';
import '../../models/Adresse_Model.dart';
import '../../models/Order_model.dart';
import '../../models/User_model.dart';
import '../../models/product_model.dart';
import '../../models/response_model.dart';
import 'api_checker.dart';
import 'package:google_maps_webservice/src/places.dart';

class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appUrl;
  bool _isLoad=false;
  late Map<String, String> _mainHeaders;
  SharedPreferences sharedPreferences;
  bool get isLoad=>_isLoad;
  late List<OrderModel> _historyOrderList;
  List<OrderModel>  get historyOrderLsit =>_historyOrderList;

  ApiClient({ required this.appUrl, required this.sharedPreferences}){
    baseUrl=appUrl;
    token=sharedPreferences.getString(AppConstant.TOKEN)??"";
    print("token"+token);
    //time of request
    timeout= Duration(seconds: 30);
    _mainHeaders={
      //pour que le serveur sait que le contenu doit être en type json
      'Content-type':'application/json; charset=UTF-8',
      'Connection': 'Keep-Alive',
      'Keep-Alive': 'timeout=5, max=1000',
      //pour envoyer au serveur lors de get/post le token
      'Authorization': 'Bearer $token',
    };
  }

  void updateHeader(String token){
    _mainHeaders={
      //pour que le serveur sait que le contenu doit être en type json
      'Content-type':'application/json; charset=UTF-8',
      'Connection': 'Keep-Alive',
      'Keep-Alive': 'timeout=5, max=1000',
      //pour envoyer au serveur lors de get/post le token
      'Authorization': 'Bearer $token',
    };
  }
  late User_model _user_model;
  User_model get user_model=>_user_model;
  List<dynamic> _popularproductlist=[];
  bool _inZone=false;
  bool get inZone=>_inZone;
   getData(String uri,{Map<String, String>? headers}) async {
    try{
      final response = (await http.get(Uri.parse("http://10.0.2.2:8000$uri"),headers: headers??_mainHeaders)) ;
      print("le problème"+response.body.toString());
      if(response.statusCode==200){
        _popularproductlist = [];
        _popularproductlist.addAll(Product.fromJson(jsonDecode(response.body)).products as Iterable);
        _isLoad=true;
        return _popularproductlist;
      }

    }catch(e){
      return Response(statusCode: 1, statusText: e.toString() );
    }
  }
  getAllAdresse(String uri,{Map<String, String>? headers}) async {
    List<AdresseModel> _adresselist=[];
    try{
      final response = (await http.get(Uri.parse("http://10.0.2.2:8000$uri"),headers: headers??_mainHeaders)) ;
      print("le problème"+response.body.toString());
      if(response.statusCode==200){
        _adresselist=[];
        jsonDecode(response.body).forEach((address){
          _adresselist.add(AdresseModel.fromJson(address));
        });
        return _adresselist;
      }else {
        _adresselist=[];
      }

    }catch(e){
      return Response(statusCode: 1, statusText: e.toString() );
    }
  }
  getDataINFO(String uri,{Map<String, String>? headers}) async {
    try{
      final response = (await http.get(Uri.parse("http://10.0.2.2:8000$uri"),headers: headers??_mainHeaders)) ;
      late ResponseModel responseModel;
      if(response.statusCode==200){
        _user_model = User_model.fromJson(jsonDecode(response.body));
        responseModel = ResponseModel(true, "successfully");
        return _user_model;
      }

    }catch(e){
      return Response(statusCode: 1, statusText: e.toString() );
    }
  }
  getAddress(String uri,{Map<String, String>? headers}) async {
    try{
      String _address="aucune addresse n'est trouvée";
      final response = await http.get(Uri.parse("http://10.0.2.2:8000$uri"),headers: headers??_mainHeaders);
      if(response.statusCode==200){
        _address=jsonDecode(response.body)["results"][0]['formatted_address'].toString();
        return _address;
      }else{
        print("une erreur est trouvée avec api");
      }

    }catch(e){
      return Response(statusCode: 1, statusText: e.toString() );
    }
  }
  getZone(String uri,{Map<String, String>? headers}) async{
    late ResponseModel _responseModel;
    final response = await http.get(Uri.parse("http://10.0.2.2:8000$uri"),headers: headers??_mainHeaders);
    print(" code "+response.statusCode.toString());
    if(response.statusCode==200){
        _responseModel=ResponseModel(true, jsonDecode(response.body)["zone_id"].toString());
        _inZone=true;
    }else {
      _inZone=false;
      _responseModel=ResponseModel(true, response.body.toString());
    }
    return _responseModel;
  }
  getPredictions(String uri,{Map<String, String>? headers}) async{
    List<Prediction> _predictionList =[];
    final response = await http.get(Uri.parse("http://10.0.2.2:8000$uri"),headers: headers??_mainHeaders);
    if(response.statusCode==200&&jsonDecode(response.body)['status']=='OK'){
      _predictionList=[];
      jsonDecode(response.body)['predictions'].forEach((prediction)
      =>_predictionList.add(Prediction.fromJson(prediction)));
    }else {
      ApiCheker.checkApi(jsonDecode(response.body));

    }
    return _predictionList;
  }
  Future<PlacesDetailsResponse> getLocation(String uri,{Map<String, String>? headers}) async {
    PlacesDetailsResponse detailsResponse;
    final response = await http.get(Uri.parse("http://10.0.2.2:8000$uri"),headers: headers??_mainHeaders);
    print("response body" + response.body);
    detailsResponse = PlacesDetailsResponse.fromJson(jsonDecode(response.body));
    return detailsResponse;
  }
  getOrder(String uri,{Map<String, String>? headers})async{
    late List<OrderModel> _currentOrderList;
    final response = await http.get(Uri.parse("http://10.0.2.2:8000$uri"),headers: headers??_mainHeaders);
    print("ordeers "+response.body.toString());
    if(response.statusCode==200){
      _historyOrderList=[];
      _currentOrderList=[];
      jsonDecode(response.body).forEach((order){
        OrderModel orderModel=OrderModel.fromJson(order);
        if(orderModel.orderStatus=='pending'||orderModel.orderStatus=='accepted'
            ||orderModel.orderStatus=='processing'||
            orderModel.orderStatus=='handover'||orderModel.orderStatus=='picked_up'){
          _currentOrderList.add(orderModel);
        }else{
          _historyOrderList.add(orderModel);
        }
      });

    }else{
      _historyOrderList=[];
      _currentOrderList=[];
    }
    return _currentOrderList;
  }
  Future<Response> postData(String uri, dynamic data) async{
     try{
       Response response= await post(uri, data, headers: _mainHeaders);
       print("post response "+response.body.toString());
       return response;
     }catch(e){
       print(e.toString());
       return Response(statusCode: 1, statusText: e.toString());
     }

  }

}
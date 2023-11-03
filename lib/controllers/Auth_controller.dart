import 'dart:convert';

import 'package:application/models/response_model.dart';
import 'package:application/models/sugn_up_model.dart';
import 'package:get/get.dart';

import '../data/api/respositary/Auth_repo.dart';

class Auth_controller extends GetxController implements GetxService{
  final Auth_repo authrepo;
  Auth_controller({
    required this.authrepo,
  });

  bool _isloading=false;
  bool get isloading=>_isloading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isloading=true;
    update();
    Response response= await authrepo.registration(signUpBody);
    late ResponseModel responseModel;
    if(response.statusCode==200){
        authrepo.SaveUserToken(response.body["token"]);
        responseModel = ResponseModel(true, response.body["token"]);
    }else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isloading=false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String phone, String password) async {
    _isloading=true;
    update();
    Response response= await authrepo.login(phone,password);
    late ResponseModel responseModel;
    if(response.statusCode==200){
      authrepo.SaveUserToken(response.body["token"]);

      responseModel = ResponseModel(true, response.body["token"]);
    }else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isloading=false;
    update();
    return responseModel;
  }

  void SaveUser(String number, String password) {
    authrepo.SaveUser(number,password);
  }
  bool Loggedin() {
    return authrepo.Loggedin();
  }
  bool cleaSharedData(){
    return authrepo.clearSharedData();
  }
}
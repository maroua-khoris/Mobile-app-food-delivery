import 'package:application/data/api/ApiClient.dart';
import 'package:application/models/sugn_up_model.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Pages/AppConstant.dart';
class Auth_repo{
  final ApiClient apiclient;
  final SharedPreferences shareddata;
  Auth_repo({
    required this.apiclient,
    required this.shareddata,
  });
  Future<dynamic> registration(SignUpBody signUpBody) async {
    return await apiclient.postData(AppConstant.resgistration_url, signUpBody.toJson());
  }
  Future<String> getUserToken() async{

    return await shareddata.getString(AppConstant.TOKEN)??"None";
  }
  bool Loggedin() {
    return shareddata.containsKey(AppConstant.TOKEN);
  }
  Future<dynamic> login(String phone, String password) async {
    return await apiclient.postData(AppConstant.login_url, {"phone":phone, "password":password});
  }

  Future<bool> SaveUserToken(String token) async {
    apiclient.token=token;
    apiclient.updateHeader(token);
    return await shareddata.setString(AppConstant.TOKEN, token);
  }
  Future<void> SaveUser(String number, String password)async {
    try{
      await shareddata.setString(AppConstant.PHONE, number);
      await shareddata.setString(AppConstant.PASSWORD, password);
    }catch(e){
      throw e;
    }
  }
  bool clearSharedData(){
    shareddata.remove(AppConstant.TOKEN);
    shareddata.remove(AppConstant.PHONE);
    shareddata.remove(AppConstant.PASSWORD);
    apiclient.token="";
    apiclient.updateHeader("");
    return true;
  }
}
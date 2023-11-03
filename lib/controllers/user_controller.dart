import 'package:application/data/api/respositary/User_repo.dart';
import 'package:application/models/User_model.dart';
import 'package:application/models/response_model.dart';
import 'package:application/models/sugn_up_model.dart';
import 'package:get/get.dart';

import '../data/api/respositary/Auth_repo.dart';

class user_controller extends GetxController implements GetxService{
  final User_repo user_repo;
  user_controller({
    required this.user_repo,
  });

  bool _isloading=false;
  bool get isloading=>_isloading;
  late User_model _user_model;
  User_model get user_model=>_user_model;

   getUserinfo() async {
    _user_model= await user_repo.getUserInfo();
    //late ResponseModel responseModel;
    //if(response.statusCode==200){
     // _user_model = User_model.fromJson(response.body);
     // _isloading=true;
     // responseModel = ResponseModel(true, "successfully");
    //}else {
     // responseModel = ResponseModel(false, response.statusText!);
   // }
    _isloading=_user_model.name.isEmpty?false:true;
    update();
  }
}
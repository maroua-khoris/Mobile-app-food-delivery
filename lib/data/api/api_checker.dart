import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Road/road_file.dart';
import '../../base/Custom_message.dart';

class ApiCheker{
  static void checkApi(Response response){
    if(response.statusCode==401){
      Get.offNamed(Road_Helper.getSignIn());
    }else{
      showCustomemesg(response.statusText!);
    }
  }
}
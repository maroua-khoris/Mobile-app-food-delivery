import 'package:application/data/api/ApiClient.dart';
import 'package:get/get.dart';

import '../../../Pages/AppConstant.dart';

class Recommanded_product extends GetxService{
  final ApiClient apiclient;
  Recommanded_product({required this.apiclient});
  getProductList()async{
    return await apiclient.getData(AppConstant.recommended_product_url);
  }
  getLaod(){
    return apiclient.isLoad;

  }
}
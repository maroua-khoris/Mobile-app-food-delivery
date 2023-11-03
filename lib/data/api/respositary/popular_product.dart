import 'package:application/data/api/ApiClient.dart';
import 'package:get/get.dart';

import '../../../Pages/AppConstant.dart';

class Popular_product extends GetxService{
  final ApiClient apiclient;
  Popular_product({required this.apiclient});
   getProductList()async{
      return await apiclient.getData(AppConstant.popular_product_url) ;
  }
  getislaod(){
    return apiclient.isLoad;
  }
}
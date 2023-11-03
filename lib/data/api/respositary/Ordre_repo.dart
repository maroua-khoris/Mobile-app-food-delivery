import 'package:application/Pages/AppConstant.dart';
import 'package:application/data/api/ApiClient.dart';
import 'package:application/models/Place_ordre_model.dart';
import 'package:get/get.dart';
class Order_repo{
  final ApiClient apiclient;

  Order_repo({ required this.apiclient});

  Future<Response> placeOrder(PlaceOrderBody placeOrder) async{
    return await apiclient.postData(AppConstant.PLACE_ORDER_URL,placeOrder.toJson());
  }
  
  getOrderList() async{
    return await apiclient.getOrder(AppConstant.Order_list_URL);
  }
  getHistoryOrderList() async{
    return apiclient.historyOrderLsit;
  }
}
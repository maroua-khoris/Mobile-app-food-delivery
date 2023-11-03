import 'package:application/models/Order_model.dart';
import 'package:application/models/Place_ordre_model.dart';
import 'package:get/get.dart';

import '../data/api/respositary/Ordre_repo.dart';

class Ordre_Controller extends GetxController implements GetxService{
  Order_repo order_repo;
  Ordre_Controller({required this.order_repo,});
  bool _isLoading=false;
  bool get isLoading=>_isLoading;
  late List<OrderModel> _currentOrderList;
  late List<OrderModel> _historyOrderList;
  bool get isloding=>_isLoading;
  List<OrderModel> get currentOrderLsit=>_currentOrderList;
  List<OrderModel>  get historyOrderLsit =>_historyOrderList;
  int _paymentindex=0;
  int  get paymentindex=>_paymentindex;
  String _orderType="delivery";
  String get orderType=>_orderType;
  String _note=" ";
  String  get note=>_note;
  Future<void> placeOrdre(PlaceOrderBody placeOrderBody,Function callback) async {
    _isLoading=true;
    Response response= await order_repo.placeOrder(placeOrderBody);
    print("response order"+response.body.toString());
    if(response.statusCode==200){
      _isLoading=false;
      String string=response.body['message'];
      String ordreID=response.body['order_id'].toString();
      callback(true,string,ordreID);
    }else {
      callback(false,response.statusText,'-1');
    }
  }

  Future<void> getOrderList() async{
    _isLoading=true;
    _currentOrderList=await order_repo.getOrderList();
    print(_currentOrderList.toString());
    _historyOrderList= await order_repo.getHistoryOrderList();
    _isLoading=false;
    update();
  }
  void setPaymentIndex(int index){
    _paymentindex=index;
    update();
  }

  void setDeliveryType(String type){
    _orderType=type;
    update();
  }
  void setFoodNote(String note){
    _note=note;

  }

}
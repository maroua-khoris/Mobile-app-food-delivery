import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../Pages/AppConstant.dart';
import '../../../models/Cart_Model.dart';

class Cart_repo{
  final SharedPreferences sharedPreferences;
  Cart_repo({required this.sharedPreferences});

  List<String> cart=[];
  List<String> cartHistory=[];

  void addToCartList(List<CartModel> cartlist){
    sharedPreferences.remove(AppConstant.cartlist);
    sharedPreferences.remove(AppConstant.carthistory);
    var time= DateTime.now().toString();
    cart=[];
    cartlist.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppConstant.cartlist, cart);
  getCartList( );
  }
  List<CartModel> getCartList(){
    List<String> carts=[];
    if(sharedPreferences.containsKey(AppConstant.cartlist)){
      carts=sharedPreferences.getStringList(AppConstant.cartlist)!;
      print("Cart list"+carts.toString());
    };
    List<CartModel> cartlist=[];
    carts.forEach((element) {
      cartlist.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartlist;
  }
  List<CartModel> getCartHistory(){
    if(sharedPreferences.containsKey(AppConstant.carthistory)){
      cartHistory=[];
      cartHistory=sharedPreferences.getStringList(AppConstant.carthistory)!;
    }
    List<CartModel> cartListHitory=[];
    cartHistory.forEach((element) {
      cartListHitory.add(CartModel.fromJson(jsonDecode(element)));
    });

    return cartListHitory;
  }
  void addToCartcheckoutList(){
    if(sharedPreferences.containsKey(AppConstant.carthistory)){
      cartHistory=sharedPreferences.getStringList(AppConstant.carthistory)!;
    }
    for(int i=0;i<cart.length;i++){
      cartHistory.add(cart[i]);
      //print("cart Hitory"+cart[i]);
    }
    removecart();
    sharedPreferences.setStringList(AppConstant.carthistory, cartHistory);
    print("length cart history"+getCartHistory().length.toString());
    for(int j=0;j<cartHistory.length;j++){
      print("time"+getCartHistory()[j].time.toString());
    }
  }
  void removecart(){
    cart=[];
    sharedPreferences.remove(AppConstant.cartlist);
  }
  void clearCart(){
    removecart();
    cartHistory=[];
    sharedPreferences.remove(AppConstant.carthistory);
  }


}
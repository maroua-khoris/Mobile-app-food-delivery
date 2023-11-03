import 'package:application/Pages/Home/color.dart';
import 'package:application/controllers/cart_controller.dart';
import 'package:application/data/api/respositary/popular_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Pages/Home/color.dart';

import '../models/Cart_Model.dart';
import '../models/product_model.dart';

class Popular_product_controller extends GetxController{
  final Popular_product popular_product;
  final _popularproductlist=[].obs;
  bool status=false;
  List<dynamic> get popularproductlist =>_popularproductlist;
  Popular_product_controller({required this.popular_product});


  @override
  onInit() async {
    super.onInit();
   await getPopularProductList();
  }
  int _quantity=0;
  int get quantity=>_quantity;
  int _itemcart=0;
  int get itemcart =>_itemcart+_quantity;
  late Cart_controller _cart;
  Future<void> getPopularProductList()async{
    _popularproductlist.value=await popular_product.getProductList();
    status=popular_product.getislaod();
    // Response response = await popular_product.getProductList();
    // print(response.statusCode);
    // print(response.statusText);
    //   if(response.statusCode == 200) {
    //     print("got products");
    //     _popularproductlist = [];
    //     _popularproductlist.addAll(Product
    //         .fromJson(response.body)
    //         .products as Iterable);
    //     print(_popularproductlist);
    //     update();
    //   }else{
    //
    //   }
  }
  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity=checkquantity(_quantity+1);
      //print("quantity"+_quantity.toString());
    }else{
      _quantity=checkquantity(_quantity-1);
      //print("quantity"+_quantity.toString());
    }
    update();
  }
  int checkquantity(int quantity){
  if((_itemcart+quantity) < 0) {
    Get.snackbar("item count", "la quantité ne peut pas être moins de 0",
    backgroundColor: color.maincolor,
      colorText: Colors.white,
    );
    if(_itemcart>0){
      _quantity= -_itemcart;
      return _quantity;
    }
    return 0;
  }else if ((_itemcart+quantity) > 20){
    Get.snackbar("item count", "le stock ne dépasse pas 20 unité",
      backgroundColor: color.maincolor,
      colorText: Colors.white,
    );
    return 20;
  }else return quantity;
  }
  void initData(Products product,Cart_controller cart){
    _quantity=0;
    _itemcart=0;
    _cart=cart;
    var exist=false;
    exist=_cart.existInCart(product);
    print("existe "+exist.toString());
    if(exist){
      _itemcart=_cart.getQuantity(product);
    }
    print("quantity "+_itemcart.toString());
  }
  void addItem(Products product){
    _cart.addItem(_quantity, product);
    _quantity=0;
    _itemcart=_cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print("id "+value.id.toString()+" quantity "+value.quantity.toString());
    });
    update();
  }
  int get totalItem{
    return _cart.totalItems;
  }
  List<CartModel> get getproducts{
    return _cart.getproducts;
  }
}
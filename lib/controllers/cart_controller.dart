import 'package:application/data/api/respositary/cart_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../Pages/Home/color.dart';
import '../models/Cart_Model.dart';
import '../models/product_model.dart';

class Cart_controller extends GetxController {
  final Cart_repo cartrepo;

  Cart_controller({required this.cartrepo});

  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;
  List<CartModel> storageItems = [];

  void addItem(int quantity, Products product) {
    var totalquantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalquantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });
      if (totalquantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      } else {
        Get.snackbar("quantité", "ajouter au moins un article",
          backgroundColor: color.maincolor,
          colorText: Colors.white,
        );
      }
    }
    cartrepo.addToCartList(getproducts);
    update();
  }

  bool existInCart(Products product) {
    if (_items.containsKey(product.id!)) {
      return true;
    }
    return false;
  }

  int getQuantity(Products product) {
    var quantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return
      totalQuantity;
  }

  List<CartModel> get getproducts {
    return items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalMontant {
    var total = 0;
    _items.forEach((key, value) {
      total = value.price! * value.quantity!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartrepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    print("length of cat items" + storageItems.length.toString());
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartrepo.addToCartcheckoutList();
    clear();
  }
  void clear(){
    _items={};
    update();
  }
  List<CartModel> getCartHitoryList(){
    return cartrepo.getCartHistory();
  }
  set setitems(Map<int, CartModel> setItems){
    _items={};
    _items=setItems;
  }
  void addToCartList(){
    cartrepo.addToCartList(getproducts);
    update();
  }
  void clearCart(){
    cartrepo.clearCart();
    update();
  }
}
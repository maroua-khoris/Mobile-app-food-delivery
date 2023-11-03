import 'dart:convert';

import 'package:application/Pages/AppConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:application/Pages/Home/color.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Road/road_file.dart';
import '../../base/No_data.dart';
import '../../controllers/cart_controller.dart';
import '../../models/Cart_Model.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/police_text.dart';
import '../../widgets/small_text.dart';
import '../Home/dimension.dart';

class Cart_History extends StatelessWidget {
  const Cart_History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHitoryList= Get.find<Cart_controller>().getCartHitoryList().reversed.toList();
    Map<String, int> cartItemPerOrder= Map();
    for(int i=0;i<getCartHitoryList.length;i++){
      if(cartItemPerOrder.containsKey(getCartHitoryList[i].time)){
        cartItemPerOrder.update(getCartHitoryList[i].time!, (value) => ++value);
      }else{
    cartItemPerOrder.putIfAbsent(getCartHitoryList[i].time!, () => 1);
    }
    }
    List<int> cartOrderTime(){
      return cartItemPerOrder.entries.map((e)=>e.value).toList();
    }
    List<String> cartTime(){
      return cartItemPerOrder.entries.map((e)=>e.key).toList();
    }
    List<int> orderTimes=cartOrderTime();

    var saveCounts=0;
    Widget TimeWidget(int index){
      var outputDate= DateTime.now.toString();
      if(index<getCartHitoryList.length) { DateTime parseDate=DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHitoryList[saveCounts].time!);
        var inputDate=DateTime.parse(parseDate.toString());
        var outputFormat=DateFormat("MM/dd/yyyy hh:mm a");
        outputDate=outputFormat.format(inputDate);}
        return Police_text(text: outputDate,);
    }

    return Scaffold(
      body: Column(
        children: [
            Container(
              height: Dimensions.height10*10,
              color: color.maincolor,
              width: double.maxFinite,
              padding: EdgeInsets.only(top: Dimensions.height45, left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Police_text(text: "Cart history", color: Colors.white),
                  App_icon(icon: Icons.shopping_cart_outlined, background: Colors.yellow),
                ],
              ),
            ),
          GetBuilder<Cart_controller>(builder: (_cartcontroller){
            return _cartcontroller.getCartHitoryList().length>0? Expanded(
              child: Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20
                  ),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                      children: [
                        for(int j=0;j<orderTimes.length;j++ )
                          Container(
                            height: Dimensions.height30*5,
                            margin: EdgeInsets.only(bottom: Dimensions.height20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TimeWidget(saveCounts),
                                SizedBox(height: Dimensions.height10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                      direction: Axis.horizontal,
                                      children: List.generate(orderTimes[j], (index){
                                        if(saveCounts<getCartHitoryList.length){
                                          saveCounts++;
                                        }
                                        return index<=2?Container(
                                          height: Dimensions.height20*4,
                                          width: Dimensions.width20*4,
                                          margin: EdgeInsets.only(right: Dimensions.width10/2),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    AppConstant.Base_URL+"/uploads/"+getCartHitoryList[saveCounts-1].img!,
                                                  )

                                              )
                                          ),
                                        ):Container();
                                      }),
                                    ),
                                    Container(

                                      height: Dimensions.height20*4,
                                      child:Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Small_text(text: 'Total',color: color.maincolor,),
                                          Police_text(text: orderTimes[j].toString()+" Items",),
                                          GestureDetector(
                                            onTap: () {
                                              var OrderTime = cartTime();
                                              Map<int, CartModel> moreOrder = {};
                                              for(int k=0;k<getCartHitoryList.length;k++){
                                                if(getCartHitoryList[k].time==OrderTime[j]){
                                                  moreOrder.putIfAbsent(getCartHitoryList[k].id!, (){
                                                    return CartModel.fromJson(jsonDecode(jsonEncode(getCartHitoryList[k])));
                                                  });
                                                }
                                              }
                                              Get.find<Cart_controller>().setitems = moreOrder;
                                              Get.find<Cart_controller>().addToCartList();
                                              Get.toNamed(Road_Helper.getcartpage());
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,vertical: Dimensions.height10/5),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                                border: Border.all(width: 1,color: color.maincolor),

                                              ),
                                              child: Small_text(text: 'one more',color: color.maincolor,),
                                            ),
                                          )
                                        ],
                                      ),
                                    )

                                  ],
                                )
                              ],
                            ),
                          )

                      ],
                    ),)
              ),
            ):No_data(text: "votre panier est vide",);
          })


        ],
      )
    );
  }
}



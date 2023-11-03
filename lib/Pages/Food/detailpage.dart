  import 'package:application/Pages/AppConstant.dart';
import 'package:application/Pages/Home/dimension.dart';
import 'package:application/Pages/Home/main_food.dart';
import 'package:application/Road/road_file.dart';
import 'package:application/controllers/cart_controller.dart';
import 'package:application/controllers/popular_product_cont.dart';
import 'package:application/widgets/Appcolone.dart';
import 'package:application/widgets/app_icon.dart';
import 'package:application/widgets/expaandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets/icon_text.dart';
import '../../widgets/police_text.dart';
import '../../widgets/small_text.dart';
import '../Home/color.dart';
import '../cart/cart_page.dart';

class Detail_page extends StatelessWidget {
  int pageid;
  String page;
    Detail_page({Key? key, required this.pageid, required this.page}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      var product= Get.find<Popular_product_controller>().popularproductlist[pageid];
      Get.find<Popular_product_controller>().initData(product,Get.find<Cart_controller>());
        return Scaffold(
        body: Stack(
          children: [
            Positioned(
              left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: Dimensions.imgsize,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            AppConstant.Base_URL+"/uploads/"+product.img!
                          )
                      )
                  ),
            )),
            Positioned(
                top: Dimensions.height45,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                       if(page=="cart page"){
                         Get.toNamed(Road_Helper.getcartpage());
                       }else {
                         Get.toNamed(Road_Helper.getinitial());
                       }
                      },
                        child: App_icon(icon: Icons.arrow_back_ios)),
                    GetBuilder<Popular_product_controller>(builder: (controller){
                      return Stack(
                       children: [
                        GestureDetector(
                          onTap: (){
                            if(controller.totalItem>=1)
                            Get.toNamed(Road_Helper.getcartpage());
                      },
                            child: App_icon(icon: Icons.shopping_cart_sharp)),
                        Get.find<Popular_product_controller>().totalItem>=1?
                        Positioned(
                          right:0,
                            top:0,
                            child:
                            App_icon(icon: Icons.circle, size: 20, iconcolor: Colors.transparent,background: color.maincolor,)):
                        Container(),
                         Get.find<Popular_product_controller>().totalItem>=1?
                         Positioned(
                             right:5,
                             top:3,
                             child: Police_text(text: Get.find<Popular_product_controller>().totalItem.toString(),
                             size: 15, color: Colors.white,)):
                         Container()
                       ],
                      );
                    })
                  ],
                )),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: Dimensions.imgsize-20,
                child: Container(
                  padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        topLeft: Radius.circular(Dimensions.radius20)
                      ),
                      color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      App_colonne(text: product.name!,),
                      SizedBox(height: Dimensions.height20,),
                      Police_text(text: "introduction"),
                      SizedBox(height: Dimensions.height20,),
                      Expanded(
                          child: SingleChildScrollView(
                              child:
                              Expandable_text(text: product.description!)))
                    ],
                  ),
                )),
          ],
        ),
        bottomNavigationBar: GetBuilder<Popular_product_controller>(builder: (popularproduct){
          return Container(
            height: Dimensions.height120,
            padding: EdgeInsets.only( left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
            decoration: BoxDecoration(
                color: color.maincolor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20*2),
                    topRight: Radius.circular(Dimensions.radius20*2)
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, left: Dimensions.width20, bottom: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: (){
                            popularproduct.setQuantity(false);
                          },
                          child: Icon(Icons.remove, color: Colors.grey,)),
                      SizedBox(width: Dimensions.width10/2,),
                      Police_text(text: popularproduct.itemcart.toString()),
                      SizedBox(width: Dimensions.width10/2,),
                      GestureDetector(
                          onTap: (){
                          popularproduct.setQuantity(true);
                          },
                          child: Icon(Icons.add, color: Colors.grey,))
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    popularproduct.addItem(product);
                  },
                  child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height20, left: Dimensions.width20, bottom: Dimensions.width20, right: Dimensions.width20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white38
                      ),

                          child: Police_text(text: "\$ ${product.price!} | Add to cart",)

                  ),
                )
              ],
            ),
          );
        },),
      );
    }
  }
  
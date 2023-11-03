import 'package:application/Pages/Home/color.dart';
import 'package:application/Pages/Home/dimension.dart';
import 'package:application/controllers/popular_product_cont.dart';
import 'package:application/widgets/Appcolone.dart';
import 'package:application/widgets/app_icon.dart';
import 'package:application/widgets/expaandable_text.dart';
import 'package:application/widgets/police_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Road/road_file.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/recommended_popular_cont.dart';
import '../AppConstant.dart';
import '../cart/cart_page.dart';

class Recom_food extends StatelessWidget {
  int pageid;
  String page;
  Recom_food({Key? key, required this.pageid, required this.page}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    var product= Get.find<Recommanded_product_controller>().recommandedproductlist[pageid];
    Get.find<Popular_product_controller>().initData(product,Get.find<Cart_controller>());
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Row(
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
                    child: App_icon(icon: Icons.clear)),
                //App_icon(icon: Icons.shopping_cart_sharp)
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
                          child: App_icon(icon: Icons.circle, size: 20, iconcolor: Colors.transparent,background: color.maincolor,)):
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
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(60),child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20),
                  topLeft: Radius.circular(Dimensions.radius20),
                )
              ),
              width: double.maxFinite,

              child: Center(child: Police_text(text: product.name!,)),
              padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height20),
            ),
            ),
            pinned: true,
            backgroundColor: color.maincolor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(AppConstant.Base_URL+"/uploads/"+product.img!,
              width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                    child:
            Expandable_text(text: product.description!,),
                    padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar:
      GetBuilder<Popular_product_controller>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(left: Dimensions.width20*2.5, right: Dimensions.width20*2.5, top: Dimensions.height10, bottom: Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (){
                        controller.setQuantity(false);
                      },
                      child:
                      App_icon(icon: Icons.remove,iconcolor: Colors.white,background: color.maincolor,)),

                  Police_text(text: "\$ ${product.price!} X ${controller.itemcart}", size: Dimensions.font26,),
                  GestureDetector(
                      onTap: (){
                        controller.setQuantity(true);
                      },
                      child:
                      App_icon(icon: Icons.add,iconcolor: Colors.white,background: color.maincolor,))

                ],
              ),
            ),
            Container(
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
                    child:
                    Icon(Icons.favorite, color: Colors.grey,),
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.addItem(product);
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
            ),
          ],
        );
      },)
    );
  }


}

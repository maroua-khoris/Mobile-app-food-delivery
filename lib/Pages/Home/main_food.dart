//import 'package:application/Home/dimension.dart';
//import 'package:application/Home/food_page.dart';
//import 'package:application/Home/color.dart';
import 'package:application/widgets/police_text.dart';
import 'package:application/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/popular_product_cont.dart';
import '../../controllers/recommended_popular_cont.dart';
import 'dimension.dart';
import 'food_page.dart';
import 'color.dart';


class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadRessources()async {
    await Get.find<Popular_product_controller>().getPopularProductList();
    await  Get.find<Recommanded_product_controller>().getRecommandedProductList();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Popular_product_controller>(builder: (controller){
      return  RefreshIndicator(child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.width20),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [ Column( children: [
                  Police_text(text: "Marroco", color: color.maincolor, size: 21,),
                  Row(
                    children: [
                      Small_text(text: "Casablanca"),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                ],),
                  Center(
                    child: Container(
                      width: Dimensions.height45,
                      height: Dimensions.height45,
                      child: Icon(Icons.search, color: Colors.white,size: Dimensions.iconsize24,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        color: color.maincolor,
                      ),),
                  ),
                ],
              ),

            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Food_Page(),
            ),
          ),
        ],
      ), onRefresh: _loadRessources);
    });
  }
}

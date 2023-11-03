
//import 'package:application/Home/color.dart';
//import 'package:application/Home/dimension.dart';
import 'package:application/Pages/AppConstant.dart';
import 'package:application/controllers/recommended_popular_cont.dart';
import 'package:application/widgets/Appcolone.dart';
import 'package:application/widgets/icon_text.dart';
import 'package:application/widgets/police_text.dart';
import 'package:application/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Road/road_file.dart';
import '../../controllers/popular_product_cont.dart';
import '../../models/product_model.dart';
import '../Food/detailpage.dart';
import '../Food/recommandation_food.dart';
import 'dimension.dart';
import 'color.dart';

class Food_Page extends  StatefulWidget {
  const Food_Page({Key? key}) : super(key: key);

  @override
  State<Food_Page> createState() => _Food_PageState();
}

class _Food_PageState extends State<Food_Page> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentpagevalue=0.0;
  double _scalefactor=0.8;
  double _height= Dimensions.pagecontainer;
  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentpagevalue =  pageController.page!;
      });
    });
  }
  @override
  void dispose(){
    pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return
      Column(
      children: [
        GetBuilder<Popular_product_controller>(builder: (popularProducts){
          return Obx(()=> Container(
            height: Dimensions.pageview,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularproductlist.length,
                  itemBuilder: (context, position){
                    return _buildpageitem(position, popularProducts.popularproductlist[position]);
                  }),
          ));
        }),
        GetBuilder<Popular_product_controller>(builder: (popularProducts){
          return Obx(() => DotsIndicator(
            dotsCount: popularProducts.popularproductlist.isEmpty?1:popularProducts.popularproductlist.length,
            position: _currentpagevalue,
            decorator: DotsDecorator(
              activeColor: color.maincolor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          ));
        }),
        SizedBox(height: Dimensions.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Police_text(text: "Recommended"),
                SizedBox(width: Dimensions.width10,),
                Container(
                    child: Small_text(text: ".",size: 20,)),
                SizedBox(width: Dimensions.width10,),
                Container(
                    child: Small_text(text: "Food pairring", color: Colors.grey,)),

              ],
          ),
        ),
        // list of images
        GetBuilder<Recommanded_product_controller>(builder: (recommendedproducts){
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedproducts.recommandedproductlist.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(Road_Helper.getRecommended(index, "home"));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width30, bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        //image section
                        Container(
                          width: Dimensions.imgheight,
                          height: Dimensions.imgheight,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      AppConstant.Base_URL+"/uploads/"+recommendedproducts.recommandedproductlist[index].img!
                                  )
                              )
                          ),
                        ),
                        //text section
                        Expanded(
                          child: Container(
                            height: Dimensions.textcontainer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20),
                                bottomRight: Radius.circular(Dimensions.radius20),

                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: Dimensions.width10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Police_text(text: recommendedproducts.recommandedproductlist[index].name!),
                                  SizedBox(height: Dimensions.height10,),
                                  Small_text(text: "Amazing food", color: Colors.grey,),
                                  SizedBox(height: Dimensions.height10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon_text(text: "Normal", icon: Icons.circle_sharp, iconcolor: Colors.yellow),
                                      Icon_text(text: "17km", icon: Icons.location_on, iconcolor: color.maincolor),
                                      Icon_text(text: "32min", icon: Icons.access_time_rounded, iconcolor: Colors.red),
                                    ],),

                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        }),


      ],
    );
  }
  Widget _buildpageitem(int index, Products popularproduct){
    Matrix4  matrix = new Matrix4.identity();
    if(index == _currentpagevalue.floor()){
      var currentscale= 1-(_currentpagevalue-index)*(1-_scalefactor);
      var currenttrans= _height*(1-currentscale)/2;
      matrix = Matrix4.diagonal3Values(1, currentscale, 1)..setTranslationRaw(0, currenttrans, 0);
    }else if(index == _currentpagevalue.floor()+1) {
      var currscale=_scalefactor+(_currentpagevalue-index*1)*(1-_scalefactor);
      var currenttrans= _height*(1-currscale)/2;
      matrix = Matrix4.diagonal3Values(1, currscale, 1);
      matrix = Matrix4.diagonal3Values(1, currscale, 1)..setTranslationRaw(0, currenttrans, 0);
    }else if(index == _currentpagevalue.floor()-1) {
      var currentscale= 1-(_currentpagevalue-index)*(1-_scalefactor);
      var currenttrans= _height*(1-currentscale)/2;
      matrix = Matrix4.diagonal3Values(1, currentscale, 1);
      matrix = Matrix4.diagonal3Values(1, currentscale, 1)..setTranslationRaw(0, currenttrans, 0);
    } else {
      var currentscale=0/8;
      matrix = Matrix4.diagonal3Values(1, currentscale, 1)..setTranslationRaw(0, _height*(1-_scalefactor)/2, 1);

    }
      return Transform(
        transform: matrix,
        child: Stack(
          children: [
            GestureDetector(
              onTap: (){
                Get.toNamed(Road_Helper.getPopularFood(index, "home"));
              },
              child: Container(
                height: Dimensions.pagecontainer,
                margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: Color(0xFF69c5df),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                           AppConstant.Base_URL+"/uploads/"+popularproduct.img!
                        )
                    )
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
              height: Dimensions.pagetext,
              margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                boxShadow: [BoxShadow(color: Color(0xFFe8e8e8),blurRadius: 7.0, offset: Offset(0, 5))]
              ),
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height15, left: 15, right: 15),
                  child: App_colonne(text: popularproduct.name!,),
                ),
            ),
            )
          ],
        ),
      );
  }
}

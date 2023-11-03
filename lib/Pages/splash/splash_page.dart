import 'dart:async';

import 'package:application/Road/road_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/popular_product_cont.dart';
import '../../controllers/recommended_popular_cont.dart';
import '../Home/dimension.dart';

class Splash_page extends StatefulWidget {
  const Splash_page({Key? key}) : super(key: key);

  @override
  State<Splash_page> createState() => _Splash_pageState();
}

class _Splash_pageState extends State<Splash_page> with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;
  @override
  Future<void> _loadRessources()async {
    await Get.find<Popular_product_controller>().getPopularProductList();
    await  Get.find<Recommanded_product_controller>().getRecommandedProductList();
  }
  void initState(){
    super.initState();
    _loadRessources();
    controller=new AnimationController(vsync: this, duration: Duration(seconds: 2))..forward();
    animation= new CurvedAnimation(
        parent: controller, curve: Curves.linear);
    Timer(
      Duration(seconds: 3),
        ()=>Get.offNamed(Road_Helper.getinitial())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
              child: Center(child: Image.asset("image/logo_restourant.jpg", width: Dimensions.splashimg,)))
        ],
      ),
    );
  }
}

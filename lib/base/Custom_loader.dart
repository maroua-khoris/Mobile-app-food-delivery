import 'package:application/controllers/Auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Pages/Home/color.dart';
import '../Pages/Home/dimension.dart';

class Custom_loader extends StatelessWidget {
  const Custom_loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  print("using loading classe"+Get.find<Auth_controller>().isloading.toString());
    return Center(
      child: Container(
        height: Dimensions.height20*5,
        width: Dimensions.height20*5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height20*5/2),
          color: color.maincolor,
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}

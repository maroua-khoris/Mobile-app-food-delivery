import 'package:application/Road/road_file.dart';
import 'package:application/base/Custome_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Home/dimension.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderId;
  final int status;
  OrderSuccessPage({required this.orderId, required this.status});

  @override
  Widget build(BuildContext context) {
    if(status == 0){
      Future.delayed(Duration(seconds: 1),(){

      });
    }
    return Scaffold(
      body: Center(
        child: SizedBox(
          width:  Dimensions.screenwidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(status == 1 ? "image/checked.jpg":"image/warning.png",height: 30,),
              SizedBox(height: Dimensions.height45,),

              Text(
                status == 1 ? 'the ordre is succesfully placed': 'your order failed',
                style: TextStyle(
                  fontSize: Dimensions.font26,
                )),
              SizedBox( height:  Dimensions.height20,),
              Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.height20,
              vertical:  Dimensions.height20),
              child: Text(
                status == 1? 'Successful order':'Failed order',
                style: TextStyle(fontSize:  Dimensions.font20,
                color: Theme.of(context).disabledColor),
                textAlign: TextAlign.center,
              ),),
              SizedBox(height: 30,),
              Padding(padding: EdgeInsets.all(Dimensions.height20),
              child: Custome_button(buttonText: 'back to home',
              onPressed: ()=> Get.offNamed(Road_Helper.getinitial()),),)
            ],
          ),
        ),
      ),
    );
  }
}

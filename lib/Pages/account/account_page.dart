import 'package:application/Road/road_file.dart';
import 'package:application/base/Custom_loader.dart';
import 'package:application/base/Custome_bar.dart';
import 'package:application/controllers/Auth_controller.dart';
import 'package:application/controllers/cart_controller.dart';
import 'package:application/controllers/user_controller.dart';
import 'package:application/widgets/app_icon.dart';
import 'package:application/widgets/police_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../controllers/location_controller.dart';
import '../Home/color.dart';
import '../Home/dimension.dart';
import 'account_widget.dart';
class Account_page extends StatelessWidget {
  const Account_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _user_loggedin=Get.find<Auth_controller>().Loggedin();
    if(_user_loggedin){
      Get.find<user_controller>().getUserinfo();
      Get.find<LocationController>().getAddressLIst();
    }
    return Scaffold(
      appBar: Cutome_app_bar(title: 'My profile',),
      body: GetBuilder<user_controller>(builder: (usercontroller){
        return _user_loggedin?(usercontroller.isloading?Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(
            children: [
              App_icon(icon: Icons.person, background: color.maincolor,iconcolor: Colors.white,
                size: Dimensions.height15*10,iconSize: Dimensions.height45+Dimensions.height30,),
              SizedBox(height: Dimensions.height30,),
              Expanded(child: SingleChildScrollView(
                child: Column(
                  children: [
                    //name
                    Account_Widget(appicon:
                    App_icon(icon: Icons.person, background: color.maincolor,iconcolor: Colors.white,
                      size: Dimensions.height10*5,iconSize: Dimensions.iconsize24,),
                      bigText: Police_text(text: usercontroller.user_model.name,),),
                    SizedBox(height: Dimensions.height20,),
                    //phone
                    Account_Widget(appicon:
                    App_icon(icon: Icons.phone, background: Colors.yellow,iconcolor: Colors.white,
                      size: Dimensions.height10*5,iconSize: Dimensions.iconsize24,),
                      bigText: Police_text(text: usercontroller.user_model.phone,),),
                    SizedBox(height: Dimensions.height20,),
                    //email
                    Account_Widget(appicon:
                    App_icon(icon: Icons.email, background: Colors.yellow,iconcolor: Colors.white,
                      size: Dimensions.height10*5,iconSize: Dimensions.iconsize24,),
                      bigText: Police_text(text: usercontroller.user_model.email,),),
                    SizedBox(height: Dimensions.height20,),
                    //adresse
                    GetBuilder<LocationController>(builder: (locationController){
                      if(_user_loggedin&&locationController.addresslist.isEmpty){
                        return GestureDetector(
                          onTap: (){
                            Get.offNamed(Road_Helper.getAddressPage());
                          },
                          child: Account_Widget(appicon:
                          App_icon(icon: Icons.location_on, background: Colors.yellow,iconcolor: Colors.white,
                            size: Dimensions.height10*5,iconSize: Dimensions.iconsize24,),
                            bigText: Police_text(text: "Entrer votre adresse",),),
                        );
                      }else {
                        return GestureDetector(
                          onTap: (){
                            Get.offNamed(Road_Helper.getAddressPage());
                          },
                          child: Account_Widget(appicon:
                          App_icon(icon: Icons.location_on, background: Colors.yellow,iconcolor: Colors.white,
                            size: Dimensions.height10*5,iconSize: Dimensions.iconsize24,),
                            bigText: Police_text(text: "Votre adresse",),),
                        );

                      }
                    },),
                    SizedBox(height: Dimensions.height20,),
                    //message
                    Account_Widget(appicon:
                    App_icon(icon: Icons.message, background: Colors.redAccent,iconcolor: Colors.white,
                      size: Dimensions.height10*5,iconSize: Dimensions.iconsize24,),
                      bigText: Police_text(text: "Hello",),),
                    SizedBox(height: Dimensions.height20,),
                    //message
                    GestureDetector(
                      onTap: (){
                        if(Get.find<Auth_controller>().Loggedin()){
                          Get.find<Auth_controller>().cleaSharedData();
                          Get.find<Cart_controller>().clearCart();
                          Get.find<Cart_controller>().clear();
                          Get.find<LocationController>().clearAddressList();
                          Get.toNamed(Road_Helper.getSignIn());}
                      },
                      child: Account_Widget(appicon:
                      App_icon(icon: Icons.logout_outlined, background: Colors.redAccent,iconcolor: Colors.white,
                        size: Dimensions.height10*5,iconSize: Dimensions.iconsize24,),
                        bigText: Police_text(text: "Log out",),),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ):Custom_loader()):Container(child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.maxFinite,
                height: Dimensions.height20*10,
                margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    image:DecorationImage(

                        image: AssetImage(
                            "image/logo_restourant.jpg"
                        )
                    )
                ),
              ),
              GestureDetector(
                onTap: (){
                  Get.toNamed(Road_Helper.getSignIn());
                },
                child: Container(
                  width: double.maxFinite,
                  height: Dimensions.height20*5,
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
                  decoration: BoxDecoration(
                    color: color.maincolor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  ),
                  child: Center(child: Police_text(text: "Connectez vous", color: Colors.white, size: Dimensions.font20,)),
                ),
              )
            ],
          ),),);
      },),
    );
  }
}

import 'package:application/Road/road_file.dart';
import 'package:application/widgets/police_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../base/Custom_loader.dart';
import '../../base/Custom_message.dart';
import '../../controllers/Auth_controller.dart';
import '../Home/color.dart';
import '../../widgets/App_Text_Flied.dart';
import '../Home/dimension.dart';
import '../auth/Sign_up_page.dart';

class Sign_in extends StatelessWidget {
  const Sign_in({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController= TextEditingController();
    var passwordController= TextEditingController();
    void _login(Auth_controller auth_controller){
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();
     if(phone.isEmpty){
        showCustomemesg("Entrer un numéro ",title: "phone");
      }else
        if(password.isEmpty){
        showCustomemesg("Entrer votre mot de passe",title: "password");
      }else if(password.length<6){
        showCustomemesg("le mot de passe ne peut pas être moins de 6 caractère",title: "password");
      }else{
        auth_controller.login(phone,password).then((status){
          if(status.isSucess){
            Get.toNamed(Road_Helper.getinitial());
          }else{
            showCustomemesg(status.isSucess.toString());
          }
        });
      }

    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<Auth_controller>(builder: (authcontroller){
        return !authcontroller.isloading?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenheight*0.05,),
              //app logo
              Container(
                height: Dimensions.screenheight*0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage(
                        "image/logo_restourant.jpg"
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height30,),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: Dimensions.width20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello",
                      style: TextStyle(
                        fontSize: Dimensions.font20*3+Dimensions.font20/2,
                        fontWeight: FontWeight.bold,
                      ),),
                    Text("Connectez vous à votre compte",
                      style: TextStyle(
                          fontSize: Dimensions.font20,
                          color: Colors.grey[500]
                      ),)
                  ],
                ),
              ),
              App_Text_Flied(textController: phoneController,hintext: "Phone", icon: Icons.phone,),
              SizedBox(height: Dimensions.height20,),
              App_Text_Flied(textController: passwordController, hintext: "Password", icon: Icons.password_sharp, isObscure:true),
              SizedBox(height: Dimensions.height20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(text:
                  TextSpan(
                      text: "Connecter à votre compte",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20,
                      )
                  )
                  ),
                  SizedBox(width:Dimensions.width20),
                ],
              ),
              SizedBox(height: Dimensions.height10,),
              GestureDetector(
                onTap: (){
                  _login(authcontroller);
                },
                child: Container(
                  width: Dimensions.screenwidth/2,
                  height: Dimensions.screenheight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: color.maincolor
                  ),
                  child: Center(
                    child: Police_text(text: "Sign in",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,),
                  ),
                ),
              ),

              SizedBox(height: Dimensions.screenheight*0.02,),
              RichText(text: TextSpan(
                  text: "si vous n'avez pas un compte? ",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20,
                  ),
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>Sign_up(), transition: Transition.fade),
                        text: "Créer",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontSize: Dimensions.font20,
                        ))
                  ]
              )
              ),



            ],
          ),
        ):Custom_loader();
      }),
    );
  }
}

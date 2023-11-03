import 'package:application/Road/road_file.dart';
import 'package:application/base/Custom_loader.dart';
import 'package:application/base/Custom_message.dart';
import 'package:application/controllers/Auth_controller.dart';
import 'package:application/models/sugn_up_model.dart';
import 'package:application/widgets/police_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Home/color.dart';
import '../../widgets/App_Text_Flied.dart';
import '../Home/dimension.dart';

class Sign_up extends StatelessWidget {
  const Sign_up({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController= TextEditingController();
    var passwordController= TextEditingController();
    var nameController= TextEditingController();
    var phoneController= TextEditingController();
    var signUpImages=[
      "t.png",
      "G.png",
      "f.png"
    ];
    void _registre(Auth_controller auth_controller){
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();
      if(name.isEmpty){
        showCustomemesg("Entrer votre nom",title: "name");
      }else if(phone.isEmpty){
        showCustomemesg("Entrer votre téléphone",title: "phone");
      }else if(email.isEmpty){
        showCustomemesg("Entrer votre email",title: "email");
      }else if(!GetUtils.isEmail(email)){
        showCustomemesg("Entrer une adresse mail valide",title: "email");
      }else if(password.isEmpty){
        showCustomemesg("Entrer votre mot de passe",title: "password");
      }else if(password.length<6){
        showCustomemesg("le mot de passe ne peut pas être moins de 6 caractère",title: "password");
      }else{
        showCustomemesg("Enregistrer",title: "Perfect");
        SignUpBody signUpBody= SignUpBody(name: name, email: email, phone: phone, password: password);
        auth_controller.registration(signUpBody).then((status){
          if(status.isSucess){
            print("Sucess registration");
            Get.offNamed(Road_Helper.getinitial());
          }else{
            showCustomemesg(status.message);
          }
        });
       }

    }

    return Scaffold(
      backgroundColor: Colors.white,
      body:
        GetBuilder<Auth_controller>(builder: (_authcontroller){
          return !_authcontroller.isloading?SingleChildScrollView(
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
                App_Text_Flied(textController: emailController,hintext: "Email", icon: Icons.email,),
                SizedBox(height: Dimensions.height20,),
                App_Text_Flied(textController: passwordController, hintext: "Password", icon: Icons.password_sharp,isObscure:true),
                SizedBox(height: Dimensions.height20,),
                App_Text_Flied(textController: nameController, hintext: "Name", icon: Icons.person,),
                SizedBox(height: Dimensions.height20,),
                App_Text_Flied(textController: phoneController, hintext: "Phone", icon: Icons.phone),
                SizedBox(height: Dimensions.height20,),
                GestureDetector(
                  onTap: (){
                    _registre(_authcontroller);
                  },
                  child: Container(
                    width: Dimensions.screenwidth/2,
                    height: Dimensions.screenheight/13,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        color: color.maincolor
                    ),
                    child: Center(
                      child: Police_text(text: "Sign up",
                        size: Dimensions.font20+Dimensions.font20/2,
                        color: Colors.white,),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height10,),
                RichText(text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                    text: "Compte existe déjà?",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20,
                    )
                )
                ),
                SizedBox(height: Dimensions.screenheight*0.02,),
                RichText(text: TextSpan(
                    text: "Sign up avec un des méthodes ci-dessus",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font16,
                    )
                )
                ),
                Wrap(
                  children: List.generate(3, (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: Dimensions.radius30,
                      backgroundImage: AssetImage(
                          "image/"+signUpImages[index]
                      ),


                    ),
                  )),
                )



              ],
            ),
          ):const Custom_loader();
        },)
    );

  }
}

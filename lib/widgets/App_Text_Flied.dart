import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Pages/Home/dimension.dart';

class App_Text_Flied extends StatelessWidget {
  final TextEditingController textController;
  final String hintext;
  final IconData icon;
  bool isObscure;
  bool maxLines;
  App_Text_Flied({Key? key, required this.textController, required this.hintext, required this.icon, this.isObscure=false, this.maxLines=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius30),
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                spreadRadius: 1,
                offset: Offset(1,1),
                color: Colors.grey.withOpacity(0.2)
            )
          ]
      ),
      child: TextField(
        maxLines: maxLines?3:1,
        obscureText: isObscure?true:false,
        controller: textController,
        decoration: InputDecoration(
            hintText: hintext,
            prefixIcon: Icon(icon, color: Colors.yellow,),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              borderSide: BorderSide(
                  width: 1.0,
                  color: Colors.white
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              borderSide: BorderSide(
                  width: 1.0,
                  color: Colors.white
              ),
            ),
            border:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30),

            )
        ),
      ),
    );
  }
}

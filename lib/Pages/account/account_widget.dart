import 'package:application/widgets/app_icon.dart';
import 'package:application/widgets/police_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Home/dimension.dart';

class Account_Widget extends StatelessWidget {
  App_icon appicon;
  Police_text bigText;
  Account_Widget({Key? key,  required this.appicon, required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.only(left: Dimensions.width20,top: Dimensions.height10,
      bottom: Dimensions.height10),
      child: Row(
        children: [
          appicon,
          SizedBox(width: Dimensions.width20,),
          bigText
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0, 5),
            color: Colors.grey.withOpacity(0.2)
          )
        ]
      ),
    );
  }
}

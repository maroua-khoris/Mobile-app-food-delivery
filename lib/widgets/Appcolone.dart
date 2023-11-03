import 'package:application/widgets/police_text.dart';
import 'package:application/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Pages/Home/dimension.dart';
import '../Pages/Home/color.dart';
import 'icon_text.dart';

class App_colonne extends StatelessWidget {
  final String text;
  const App_colonne({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Police_text(text: text, size: Dimensions.font26,),
        SizedBox(height: Dimensions.height10,),
        Row(
          children: [
            Wrap(children: List.generate(5, (index) => Icon(Icons.star, color: color.maincolor,)),),
            SizedBox(width: Dimensions.width10,),
            Small_text(text: "5", color: Colors.grey),
            SizedBox(width: Dimensions.width10,),
            Small_text(text: "100 comments", color: Colors.grey,)
          ],
        ),
        SizedBox(height: Dimensions.height20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon_text(text: "Normal", icon: Icons.circle_sharp, iconcolor: Colors.yellow),
            Icon_text(text: "17km", icon: Icons.location_on, iconcolor: color.maincolor),
            Icon_text(text: "32min", icon: Icons.access_time_rounded, iconcolor: Colors.red),
          ],),
      ],
    );
  }
}

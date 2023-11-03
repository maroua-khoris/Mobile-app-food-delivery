import 'package:application/Road/road_file.dart';
import 'package:application/widgets/police_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Cutome_app_bar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final bool backbutton;
  final Function? onBackPressed;
  const Cutome_app_bar({Key? key,
    required this.title,
    this.backbutton=true,
    this.onBackPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Police_text(text: title, color: Colors.white,),
      centerTitle: true,
      elevation: 0,
      leading: backbutton==true?IconButton(
          onPressed: ()=>onBackPressed!=null?onBackPressed!():Get.toNamed(Road_Helper.getinitial()),
          icon: Icon(Icons.arrow_back_ios)):SizedBox(),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(500, 55);
}

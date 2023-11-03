import 'package:application/widgets/police_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
void showCustomemesg(String message, {bool isError=true, String title="Error"}){
  Get.snackbar(title, message,
  titleText: Police_text(text: title, color: Colors.white,),
  messageText:Text(message, style: TextStyle(
    color: Colors.white,
  ),
  ),
      colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.redAccent,
  );

}
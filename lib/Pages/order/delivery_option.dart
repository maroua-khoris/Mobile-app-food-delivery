import 'package:application/controllers/Ordre_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Home/color.dart';
import '../Home/dimension.dart';
import 'package:get/get.dart';

class Delivery_Options extends StatelessWidget {
  final  String value;
  final String title;
  final double amount;
  final bool isFree;
  const Delivery_Options({Key? key, required this.value,
    required this.title,
    required this.amount,
    required this.isFree}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Ordre_Controller>(builder: (orderController){
      return Row(
        children: [
          Radio(
            value: value,
            groupValue: orderController.orderType,
            onChanged: (String? value)=>orderController.setDeliveryType(value!),
            activeColor: color.maincolor,),
          SizedBox(width:  Dimensions.width10/2,),
          Text(title,
              style: TextStyle (fontWeight: FontWeight.w700,
                fontSize: Dimensions.font16,)),
          SizedBox(width:  Dimensions.width10/2,),
          Text(
            '${(value == 'take away' || isFree)?'free':'\$${amount/10}'}',
            style: TextStyle(fontWeight: FontWeight.w700,
              fontSize: Dimensions.font15,),
          )
        ],
      );
    });
  }
}

import 'package:application/controllers/Ordre_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Pages/Home/color.dart';
import '../Pages/Home/dimension.dart';
import 'package:get/get.dart';

class Payment_option extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String subtitle;
  final int index;
  const Payment_option({Key? key,
    required this.iconData,
    required this.title,
    required this.subtitle,
    required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Ordre_Controller>(builder: (orderController){
      bool _selected=orderController.paymentindex==index;
      return InkWell(
        onTap: ()=>orderController.setPaymentIndex(index),
        child: Container(
          padding: EdgeInsets.only(bottom: Dimensions.height10/2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20/4),
              color: Theme.of(context).cardColor,
              boxShadow: [BoxShadow(
                  color: Colors.grey[200]!,
                  blurRadius: 5,
                  spreadRadius: 1
              )]
          ),
          child: ListTile(
            leading: Icon(
              iconData,
              size: 40,
              color: _selected?color.maincolor:Theme.of(context).disabledColor,),
            title: Text(
              title,
              style:  TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: Dimensions.font20,
              ),
            ),
            subtitle: Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).disabledColor,
                fontWeight: FontWeight.w700,
                fontSize: Dimensions.font20,
              ),
            ),
            trailing: _selected?Icon(Icons.check_circle_outline, color: Theme.of(context).primaryColor,):null,
          ),
        ),
      );
    });
  }
}

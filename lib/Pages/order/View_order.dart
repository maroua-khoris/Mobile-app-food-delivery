import 'package:application/base/Custom_loader.dart';
import 'package:application/controllers/Ordre_controller.dart';
import 'package:application/models/Order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Home/color.dart';
import '../Home/dimension.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;
  const ViewOrder({Key? key, required this.isCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<Ordre_Controller>(builder: (orderController){
        if(orderController.isLoading==false){
          late List<OrderModel> orderModel;
          if(orderController.currentOrderLsit.isNotEmpty){
            orderModel=isCurrent?orderController.currentOrderLsit.reversed.toList():
            orderController.historyOrderLsit.reversed.toList();
          }
          return SizedBox(
            width: Dimensions.screenwidth,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,vertical: Dimensions.height10/2),
              child: ListView.builder(
                  itemCount: orderModel.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: ()=>null,
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text("Order ID",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: Dimensions.font16,
                            ),),
                                    SizedBox(width: Dimensions.width10/2,),
                                    Text("#${orderModel[index].id}"),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: color.maincolor,
                                        borderRadius: BorderRadius.circular(Dimensions.radius20/4)
                                      ),
                                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,vertical: Dimensions.width10/2),
                                          child:Text('${orderModel[index].orderStatus}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: Dimensions.font16,
                                              ) )

                                    ),
                                    SizedBox(height: Dimensions.height10/2,),
                                    InkWell(
                                      onTap: ()=>null,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,vertical: Dimensions.width10/2),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                                          border: Border.all(width: 1,color: Theme.of(context).primaryColor),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset("image/tracking.png",height: 15,width: 15,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                            SizedBox(width: Dimensions.width10/2,),
                                            Text("Track order",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: Dimensions.font15,
                                                color: Theme.of(context).primaryColor,
                                              ),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: Dimensions.height10,)
                        ],
                      ),
                    );
                  }),
            ),
          );
        }else{
          return Custom_loader();
        }
        ;
      },),
    );
  }
}

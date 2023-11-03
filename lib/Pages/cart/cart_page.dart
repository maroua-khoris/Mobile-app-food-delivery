import 'package:application/Pages/AppConstant.dart';
import 'package:application/Pages/Home/color.dart';
import 'package:application/Pages/Home/dimension.dart';
import 'package:application/Pages/Home/main_food.dart';
import 'package:application/base/Custom_message.dart';
import 'package:application/controllers/Auth_controller.dart';
import 'package:application/controllers/popular_product_cont.dart';
import 'package:application/controllers/recommended_popular_cont.dart';
import 'package:application/controllers/user_controller.dart';
import 'package:application/models/Place_ordre_model.dart';
import 'package:application/widgets/App_Text_Flied.dart';
import 'package:application/widgets/Payment_option_button.dart';
import 'package:application/widgets/app_icon.dart';
import 'package:application/widgets/police_text.dart';
import 'package:application/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Road/road_file.dart';
import '../../base/No_data.dart';
import '../../controllers/Ordre_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/location_controller.dart';
import '../order/delivery_option.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteController=TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20*3,
            left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  App_icon(icon: Icons.arrow_back_ios,
                  iconcolor: Colors.white,
                    background: color.maincolor,
                    size: Dimensions.iconsize24*2,
                  ),
                  SizedBox(width: Dimensions.width20*5,),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(Road_Helper.getinitial());
                    },
                    child: App_icon(icon: Icons.home_outlined,
                      iconcolor: Colors.white,
                      background: color.maincolor,
                      size: Dimensions.iconsize24*2,
                    ),
                  ),
                  App_icon(icon: Icons.shopping_cart,
                    iconcolor: Colors.white,
                    background: color.maincolor,
                    size: Dimensions.iconsize24*2,
                  )
                ],
              )
          ),
          GetBuilder<Cart_controller>(builder: (_cartcontroller){
            return _cartcontroller.getproducts.length>0?Positioned(
                top: Dimensions.height20*6,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<Cart_controller>(builder: (cartcontroller){
                      var cartList= cartcontroller.getproducts;
                      return ListView.builder(
                          itemCount: cartList.length,
                          itemBuilder: (_,index){
                            return Container(
                              height: 100,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      var popularIndex= Get.find<Popular_product_controller>().popularproductlist.indexOf(cartList[index].product!);
                                      if(popularIndex>=0){
                                        Get.toNamed(Road_Helper.getPopularFood(popularIndex,"cart page"));
                                      }else {
                                        var recommendedIndex= Get.find<Recommanded_product_controller>().recommandedproductlist.indexOf(cartList[index].product!);
                                        if(recommendedIndex<0){
                                          Get.snackbar("History porducts", "produit n'est plus valable",
                                            backgroundColor: Colors.redAccent,
                                            colorText: Colors.white,
                                          );
                                        }else {
                                          Get.toNamed(Road_Helper.getRecommended(recommendedIndex, "cart page"));
                                        }

                                      }
                                    },

                                    child: Container(
                                      width: Dimensions.width20*5,
                                      height: Dimensions.height20*5,
                                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                AppConstant.Base_URL+"/uploads/"+cartcontroller.getproducts[index].img!
                                            ),
                                          ),
                                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.width10,),
                                  Expanded(child: Container(
                                    height: Dimensions.height20*5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Police_text(text: cartcontroller.getproducts[index].name!, color: Colors.black54,),
                                        Small_text(text: "Spicy",color: Colors.grey,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Police_text(text: cartcontroller.getproducts[index]!.price.toString(), color: Colors.red,),
                                            Container(
                                              padding: EdgeInsets.only(top: Dimensions.height10, left: Dimensions.width10, bottom: Dimensions.width10, right: Dimensions.width10),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                  color: Colors.white
                                              ),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap: (){
                                                        cartcontroller.addItem(-1,cartList[index].product!);
                                                      },
                                                      child: Icon(Icons.remove, color: Colors.grey,)),
                                                  SizedBox(width: Dimensions.width10/2,),
                                                  Police_text(text: cartList[index].quantity.toString()),//popularproduct.itemcart.toString()
                                                  SizedBox(width: Dimensions.width10/2,),
                                                  GestureDetector(
                                                      onTap: (){
                                                        cartcontroller.addItem(1,cartList[index].product!);
                                                      },
                                                      child: Icon(Icons.add, color: Colors.grey,))
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            );
                          });
                    }),
                  ),
                )
            ):No_data(text: "votre panier est vide",);
          })

        ],
      ),
      bottomNavigationBar: GetBuilder<Ordre_Controller>(builder: (ordercontroller){
        _noteController.text=ordercontroller.note;
        return GetBuilder<Cart_controller>(builder: (cartproduct){
          return Container(
            height: Dimensions.height120,
            padding: EdgeInsets.only( left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
            decoration: BoxDecoration(
                color: color.maincolor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20*2),
                    topRight: Radius.circular(Dimensions.radius20*2)
                )
            ),
            child: cartproduct.getproducts.length>0?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, left: Dimensions.width20, bottom: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white
                  ),
                  child: Row(
                    children: [SizedBox(width: Dimensions.width10/2,),
                      Police_text(text: cartproduct.totalMontant.toString()),
                      SizedBox(width: Dimensions.width10/2,),
                    ],
                  ),
                ),
          InkWell(
                    onTap: ()=>showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (_){
                          return Column(
                            children: [
                              Expanded(
                                  child: SingleChildScrollView(
                                    child: Container(
                                      height: MediaQuery.of(context).size.height*0.9,
                                      decoration: BoxDecoration(
                                          color: Colors.white ,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(Dimensions.radius20),
                                              topRight: Radius.circular(Dimensions.radius20)
                                          )
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 520,
                                            padding:EdgeInsets.only(
                                                left: Dimensions.width20,
                                                right: Dimensions.width20,
                                                top: Dimensions.height20
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Payment_option(
                                                  iconData: Icons.money,
                                                  title: 'cash on delivery',
                                                  subtitle: 'paiement à la livraison',
                                                  index: 0,
                                                ),
                                                SizedBox(height: Dimensions.height30,),
                                                Text("Delivery options", style : TextStyle(fontWeight: FontWeight.w700,
                                                  fontSize: Dimensions.font16,)),
                                                SizedBox(height: Dimensions.height10),
                                                Delivery_Options(value: 'delivery',
                                                    title: 'Home delivery',
                                                    amount: double.parse(Get.find<Cart_controller>().totalMontant.toString()),
                                                    isFree:false),
                                                SizedBox(height: Dimensions.height10/2,),
                                                Delivery_Options(value: 'take away',
                                                    title: 'take away',
                                                    amount: 10.0,
                                                    isFree:true),
                                                SizedBox(height: Dimensions.height20,),
                                                Text("Additional notes", style : TextStyle(fontWeight: FontWeight.w700,
                                                  fontSize: Dimensions.font20,)),
                                                App_Text_Flied(
                                                  textController: _noteController,
                                                  hintext: "",
                                                  icon: Icons.note_add,
                                                  maxLines:true,),
                                                InkWell(
                                                  onTap: (){
                                                    if(Get.find<Auth_controller>().Loggedin()){
                                                      // cartproduct.addToHistory();
                                                      if(Get.find<LocationController>().addresslist.isEmpty){
                                                        Get.toNamed(Road_Helper.getAddressPage());
                                                      }else{
                                                        var location=Get.find<LocationController>().getuserAddress();
                                                        var cart=Get.find<Cart_controller>().getproducts;
                                                        var user = Get.find<user_controller>().user_model;
                                                        PlaceOrderBody placeOrder=PlaceOrderBody(
                                                            cart: cart,
                                                            orderAmount: 100.0,
                                                            distance: 10.0,
                                                            scheduleAt: '',
                                                            orderNote: _noteController.text,
                                                            address: location.adresse,
                                                            latitude: location.latitude,
                                                            longitude: location.longitude,
                                                            contactPersonName: user!.name,
                                                            contactPersonNumber: user!.phone,
                                                            orderType: ordercontroller.orderType,
                                                            paymentMethod: 'cash_on_delivery');
                                                        Get.find<Ordre_Controller>().placeOrdre(placeOrder, _callback );
                                                      }
                                                    }else{
                                                      Get.toNamed(Road_Helper.getSignIn());
                                                    }

                                                  },
                                                child: Container(
                                                    padding: EdgeInsets.only(top: Dimensions.height20, left: Dimensions.width20, bottom: Dimensions.width20, right: Dimensions.width20),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                        color: color.maincolor
                                                    ),

                                                    child: Police_text(text: " continue",color: Colors.white,)

                                                ),)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                            ],
                          );
                        }).whenComplete(() => ordercontroller.setFoodNote(_noteController.text.trim())),
                    child: Container(
                        padding: EdgeInsets.only(top: Dimensions.height20, left: Dimensions.width20, bottom: Dimensions.width20, right: Dimensions.width20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white38
                        ),

                        child: Police_text(text: " Checkout",)

                    ),
                  ),
              ],
            ):Container(),
          );
        },);
      },),

    );
  }

  void _callback(bool isSucces, String message, String ordreID){
    if(isSucces){
      Get.find<Cart_controller>().clear();
      Get.find<Cart_controller>().clearCart();
      Get.find<Cart_controller>().addToHistory();
      Get.offNamed(Road_Helper.getOrderSuccessPage(ordreID, "success"));
    }else {
      showCustomemesg(message);
    }
  }
}

import 'package:application/Pages/Address/Pick_address_map.dart';
import 'package:application/Pages/Food/detailpage.dart';
import 'package:application/Pages/Food/recommandation_food.dart';
import 'package:application/Pages/account/Sign_in_page.dart';
import 'package:application/Pages/payment/payment_page.dart';
import 'package:application/Pages/splash/splash_page.dart';
import 'package:application/models/Order_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../Pages/Address/Add_address_page.dart';
import '../Pages/Home/home_page.dart';
import '../Pages/Home/main_food.dart';
import '../Pages/cart/cart_page.dart';
import '../Pages/payment/Order_success_page.dart';

class Road_Helper {
  static const String initial = "/";
  static const String popularfood = "/popular-food";
  static const String recommended = "/recommended-food";
  static const String cartpage = "/cart-page";
  static const String splashpage = "/splash-page";
  static const String addresspage = "/add-address";
  static const String SignIn = "/sign-in";
  static const String pickaddressmap = "/pick-address";
  static const String payment = "/payment";
  static const String orderSucess = "/order-successful";


  //to send parametres
  static String getPopularFood(int pageID, String page) =>
      '$popularfood?pageid=$pageID&page=$page';

  static String getinitial() => '$initial';

  static String getSplash() => '$splashpage';

  static String getRecommended(int pageid, String page) =>
      '$recommended?pageid=$pageid&page=$page';

  static String getcartpage() => '$cartpage';

  static String getSignIn() => '$SignIn';

  static String getAddressPage() => '$addresspage';

  static String getPickAddressPage() => '$pickaddressmap';

  static String getPaymentPage(String id, int userid) => '$payment?id=$id&userid=$userid';

  static String getOrderSuccessPage(String ordreId, String status) => '$orderSucess?id=$ordreId&status=$status';
  static List<GetPage> routes = [
    GetPage(name: splashpage, page: () => Splash_page()),
    GetPage(name: initial, page: () => HomePage()),
    GetPage(name: SignIn, page: () => Sign_in(), transition: Transition.fade),
    GetPage(name: pickaddressmap, page: () {
      Pick_Address_Map _pickAddress = Get.arguments;
      return _pickAddress;
    }),
    GetPage(name: popularfood, page: () {
      var pageid = Get.parameters['pageid'];
      var page = Get.parameters['page'];
      return Detail_page(pageid: int.parse(pageid!), page: page!);
    }, transition: Transition.fadeIn),
    GetPage(name: recommended, page: () {
      var pageid = Get.parameters['pageid'];
      var page = Get.parameters['page'];
      return Recom_food(pageid: int.parse(pageid!), page: page!);
    }, transition: Transition.fadeIn),
    GetPage(name: cartpage, page: () {
      return CartPage();
    },
        transition: Transition.fadeIn),
    GetPage(name: addresspage, page: () => Add_Address_page()),
    GetPage(name: payment, page: () =>
        Payment_page(
            orderModel: OrderModel(
              id: int.parse(Get.parameters['id']!),
              userId: int.parse(Get.parameters['userid']!),
            )
        )),
    GetPage(name: orderSucess, page: ()=>OrderSuccessPage(
      orderId: Get.parameters['id']!
      , status: Get.parameters["status"].toString().contains("success")?1:0,
    )),
  ];
}
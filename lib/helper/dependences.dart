import 'package:application/controllers/Auth_controller.dart';
import 'package:application/controllers/Ordre_controller.dart';
import 'package:application/controllers/location_controller.dart';
import 'package:application/data/api/respositary/Auth_repo.dart';
import 'package:application/data/api/respositary/Ordre_repo.dart';
import 'package:application/data/api/respositary/User_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pages/AppConstant.dart';
import '../controllers/cart_controller.dart';
import '../controllers/popular_product_cont.dart';
import '../controllers/recommended_popular_cont.dart';
import '../controllers/user_controller.dart';
import '../data/api/ApiClient.dart';
import '../data/api/respositary/cart_repo.dart';
import '../data/api/respositary/location_repo.dart';
import '../data/api/respositary/popular_product.dart';
import '../data/api/respositary/recommanded_food.dart';

Future<void> init()async {
  final sharedPreferences= await SharedPreferences.getInstance();
  Get.lazyPut(()=>sharedPreferences);
  Get.lazyPut(()=>ApiClient(appUrl: AppConstant.Base_URL, sharedPreferences: Get.find()));
  Get.lazyPut(() => Popular_product(apiclient:Get.find()));
  Get.lazyPut(() => Popular_product_controller(popular_product:Get.find()));
  Get.lazyPut(() => Recommanded_product(apiclient: Get.find()));
  Get.lazyPut(() => Recommanded_product_controller(recommand_product: Get.find()));
  Get.lazyPut(() => Cart_repo(sharedPreferences: Get.find()));
  Get.lazyPut(() => Auth_repo(apiclient: Get.find(), shareddata: Get.find()));
  Get.lazyPut(() => Location_repo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => User_repo(apiClient: Get.find()));
  Get.lazyPut(() => Order_repo(apiclient: Get.find()));
  Get.lazyPut(() => Cart_controller(cartrepo: Get.find()));
  Get.lazyPut(() => Auth_controller(authrepo: Get.find()));
  Get.lazyPut(() => user_controller( user_repo: Get.find()));
  Get.lazyPut(() => LocationController(location_repo: Get.find() ));
  Get.lazyPut(() => Ordre_Controller(order_repo: Get.find() ));

}
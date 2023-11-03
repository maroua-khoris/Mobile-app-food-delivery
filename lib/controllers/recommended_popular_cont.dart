import 'package:application/data/api/respositary/popular_product.dart';
import 'package:get/get.dart';

import '../data/api/respositary/recommanded_food.dart';
import '../models/product_model.dart';

class Recommanded_product_controller extends GetxController{
  final Recommanded_product recommand_product;
  final _recommandedproductlist=[].obs;
  bool Loading=false;
  List<dynamic> get recommandedproductlist =>_recommandedproductlist;
  Recommanded_product_controller({required this.recommand_product});


  @override
  onInit() async {
    super.onInit();
    await getRecommandedProductList();
  }

  Future<void> getRecommandedProductList()async{
    _recommandedproductlist.value=await recommand_product.getProductList();
    Loading=recommand_product.getLaod();
    // Response response = await popular_product.getProductList();
    // print(response.statusCode);
    // print(response.statusText);
    //   if(response.statusCode == 200) {
    //     print("got products");
    //     _popularproductlist = [];
    //     _popularproductlist.addAll(Product
    //         .fromJson(response.body)
    //         .products as Iterable);
    //     print(_popularproductlist);
    //     update();
    //   }else{
    //
    //   }
  }

}
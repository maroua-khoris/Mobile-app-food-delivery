import 'package:application/base/Custome_bar.dart';
import 'package:application/controllers/Auth_controller.dart';
import 'package:application/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../../controllers/Ordre_controller.dart';
import '../Home/color.dart';
import '../Home/dimension.dart';
import 'View_order.dart';
class Order_page extends StatefulWidget {
  const Order_page({Key? key}) : super(key: key);

  @override
  State<Order_page> createState() => _Order_pageState();
}

class _Order_pageState extends State<Order_page> with TickerProviderStateMixin{
  late TabController _tabController;
  late bool _isloggedin;
  @override
  void initState() {
    super.initState();
    _isloggedin=Get.find<Auth_controller>().Loggedin();
    if(_isloggedin){
      _tabController = TabController(length: 2, vsync: this);
      Get.find<Ordre_Controller>().getOrderList();
    }
  }
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: Cutome_app_bar(title: 'My orders',),
      body: Column(
        children: [
          Container(
            width: Dimensions.screenwidth,
            child: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              indicatorWeight: 3,
              labelColor: Colors.black,
              unselectedLabelColor: Theme.of(context).disabledColor,
              controller: _tabController,
              tabs: [
                Tab(text: "current",),
                Tab(text: "history",)
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
                children: [
                  ViewOrder(isCurrent: true,),
                  ViewOrder(isCurrent: false,)
                ]),
          )
        ],
      ),
    );
  }
}

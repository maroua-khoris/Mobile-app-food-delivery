import 'package:application/Pages/Address/Pick_address_map.dart';
import 'package:application/base/Custome_bar.dart';
import 'package:application/controllers/Auth_controller.dart';
import 'package:application/controllers/location_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../Road/road_file.dart';
import '../../models/Adresse_Model.dart';
import '../../widgets/App_Text_Flied.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/police_text.dart';
import '../Home/color.dart';
import '../../controllers/user_controller.dart';
import '../Home/dimension.dart';

class Add_Address_page extends StatefulWidget {
  const Add_Address_page({Key? key}) : super(key: key);

  @override
  State<Add_Address_page> createState() => _Add_Address_pageState();
}

class _Add_Address_pageState extends State<Add_Address_page> {
  TextEditingController _addressController= TextEditingController();
  final TextEditingController _namecontroller=TextEditingController();
  final TextEditingController _numbercontroller=TextEditingController();
  late bool _isloading;
  CameraPosition _cameraPosition= const CameraPosition(target: LatLng(
      33.5731104,-7.5898434
  ), zoom: 15);
  late LatLng _initialPosition=LatLng(
      33.5731104,-7.5898434
  );

  @override
  void initState(){
    super.initState();
    _isloading = Get.find<Auth_controller>().Loggedin();
    //Get.find<LocationController>().getAddressLIst();
    print("adresse test "+Get.find<LocationController>().addresslist.toString());
    if(_isloading && Get.find<user_controller>().user_model==null){
      Get.find<user_controller>().getUserinfo();
    }
    if(Get.find<LocationController>().addresslist.isNotEmpty&&Get.find<LocationController>().updateAddressData==true){
      if(Get.find<LocationController>().getuserAddressFromLocalStorage()==""){
        Get.find<LocationController>().SaveUserAddress(Get.find<LocationController>().addresslist.last);
      }
      Get.find<LocationController>().getuserAddress();
      _cameraPosition=CameraPosition(target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"])
      ));
      _initialPosition=LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"])
      );
    }else {
      _cameraPosition=CameraPosition(target: LatLng(
          Get.find<LocationController>().position.latitude,
          Get.find<LocationController>().position.longitude

      ),zoom: 15);
      _initialPosition=LatLng(
          Get.find<LocationController>().position.latitude,
          Get.find<LocationController>().position.longitude
      );
      print("latitude "+Get.find<LocationController>().position.latitude.toString()+"longitude "+Get.find<LocationController>().position.longitude.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Cutome_app_bar(title: 'Adresse',),
      body: GetBuilder<user_controller>(builder: (userController){
        if(userController.user_model!=null&&_namecontroller.text.isEmpty){
          _namecontroller.text='${userController.user_model?.name}';
          _numbercontroller.text='${userController.user_model?.phone}';
          if(Get.find<LocationController>().addresslist.isNotEmpty){
           _addressController.text= Get.find<LocationController>().getuserAddress().adresse;
          }
        }
        return GetBuilder<LocationController>(builder: (locationController){
          _addressController.text='${locationController.placemark.name??''}'
              '${locationController.placemark.locality??''}'
              '${locationController.placemark.postalCode??''}'
              '${locationController.placemark.country??''}';
          print("addresse in my view "+_addressController.text);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 5,right: 5,top: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 2,
                        color: color.maincolor,
                      )
                  ),
                  child: Stack(
                    children: [
                      GoogleMap(initialCameraPosition:
                      CameraPosition(target: _initialPosition, zoom: 15),
                          onTap: (latlng){
                              Get.toNamed(Road_Helper.getPickAddressPage(),arguments: Pick_Address_Map(
                                fromSignup: false,
                                fromAddressarea: true,
                                googleMapController: locationController.mapController,
                              ));
                          },
                          zoomControlsEnabled: false,
                          compassEnabled: false,
                          indoorViewEnabled: true,
                          mapToolbarEnabled: false,
                          myLocationEnabled: true,
                          onCameraIdle: (){
                              if(Get.find<LocationController>().updateAddressData==true){
                            locationController.updatePosition(_cameraPosition, true);}
                          }  ,onCameraMove: ((position)=>_cameraPosition=position),
                          onMapCreated: (GoogleMapController controller){
                            locationController.setMapController(controller);
                            if(Get.find<LocationController>().addresslist.isEmpty){
                              //locationController.getCurrentLocation(true, mapController: controller);

                            }
                          }
                      ),
                      Center(
                          child: Image.asset("image/pick_marker.png",
                            height: Dimensions.height10*5,width: Dimensions.width10*5,)

                      ),
                    ],
                  ),
                ),
                //les trois buttons
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20, top: Dimensions.height20),
                  child: SizedBox(height: Dimensions.height10*5,
                    child:ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: locationController.addressTypeList.length,
                        itemBuilder: (context, index){
                      return InkWell(
                        onTap: (){
                          locationController.setAddressTypeIndex(index);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height10),
                          margin: EdgeInsets.only(right: Dimensions.width10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                            color: Theme.of(context).cardColor,
                            boxShadow:[BoxShadow(
                              color: Colors.grey[200]!,
                              spreadRadius: 1,
                              blurRadius: 5,
                            )]
                          ),
                          child:  Icon(
                            index==0?Icons.home_filled:index==1?Icons.work:Icons.location_on,
                            color: locationController.addressTypeIndex==index?color.maincolor:Theme.of(context).disabledColor,
                          ),

                        ),
                      );
                    }) ,),
                ),
                SizedBox(height: Dimensions.height20,),
                //la partie contact et affichage de l'adresse
                Padding(
                    padding: EdgeInsets.only(left:  Dimensions.width20),
                    child: Police_text(text: "Adresse de livraison")),
                SizedBox(height: Dimensions.height20,),
                App_Text_Flied(textController: _addressController,hintext: "Votre adresse", icon: Icons.map,),
                SizedBox(height: Dimensions.height20,),
                Padding(
                    padding: EdgeInsets.only(left:  Dimensions.width20),
                    child: Police_text(text: "nom du contact")),
                SizedBox(height: Dimensions.height10,),
                App_Text_Flied(textController: _namecontroller,hintext: "Votre nom", icon: Icons.person,),
                SizedBox(height: Dimensions.height20,),
                Padding(
                    padding: EdgeInsets.only(left:  Dimensions.width20),
                    child: Police_text(text: "Numero  de téléphone")),
                SizedBox(height: Dimensions.height10,),
                App_Text_Flied(textController: _numbercontroller,hintext: "Votre téléphone", icon: Icons.phone,),

              ],

            ),
          );
        });
      },),
      bottomNavigationBar: GetBuilder<LocationController>(builder: (locationcontroller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: Dimensions.height120,
              padding: EdgeInsets.only( left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20*2),
                      topRight: Radius.circular(Dimensions.radius20*2)
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      AdresseModel _addressModel= AdresseModel(adresseType: locationcontroller.addressTypeList[locationcontroller.addressTypeIndex],
                      contactPersonName: _namecontroller.text,
                      contactPersonNumber: _numbercontroller.text,
                      adresse: _addressController.text,
                      latitude: locationcontroller.position.latitude.toString()??"",
                      longtitude: locationcontroller.position.longitude.toString()??"");
                      locationcontroller.addAddress(_addressModel).then((response){
                        if(response.isSucess){
                          Get.toNamed(Road_Helper.getinitial());
                          Get.snackbar("Address", "Adresse enregistrer successfully");
                        }else {
                          Get.snackbar("Address", "Adresse ne peut être enregistrer");
                        }
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.only(top: Dimensions.height20, left: Dimensions.width20, bottom: Dimensions.width20, right: Dimensions.width20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: color.maincolor,
                        ),
                        child: Police_text(text: "Enregistrer l'adresse", color: Colors.white,size: Dimensions.font26,),

                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },),
    );
  }
}

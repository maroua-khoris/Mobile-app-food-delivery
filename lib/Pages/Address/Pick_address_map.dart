import 'package:application/Pages/Address/widgets/search_location_page.dart';
import 'package:application/Road/road_file.dart';
import 'package:application/base/Custome_button.dart';
import 'package:application/controllers/location_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Home/color.dart';
import '../Home/dimension.dart';

class Pick_Address_Map extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddressarea;
  final GoogleMapController? googleMapController;
  const Pick_Address_Map({Key? key, required this.fromSignup, required this.fromAddressarea, this.googleMapController}) : super(key: key);

  @override
  State<Pick_Address_Map> createState() => _Pick_Address_MapState();
}

class _Pick_Address_MapState extends State<Pick_Address_Map> {
  late LatLng _initialposition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Get.find<LocationController>().addresslist.isEmpty){
      _initialposition=LatLng(33.5731104, -7.5898434);
      _cameraPosition=CameraPosition(target: _initialposition, zoom: 15);
    }else {
      if(Get.find<LocationController>().addresslist.isNotEmpty){
        _initialposition=LatLng(Get.find<LocationController>().position.latitude,
            Get.find<LocationController>().position.longitude);
        _cameraPosition=CameraPosition(target: _initialposition, zoom: 15);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController){
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(initialCameraPosition: CameraPosition(
                      target: _initialposition,zoom: 15

                  ),
                    zoomControlsEnabled: false,
                    onCameraMove: (CameraPosition cameraPosition){
                      _cameraPosition=cameraPosition;
                    },
                    onCameraIdle: (){
                      Get.find<LocationController>().updatePosition(_cameraPosition, false);
                    },
                    onMapCreated: (GoogleMapController mapController){
                    _mapController=mapController;
                    },
                  ),
                  Center(
                    child: !locationController.loading?Image.asset("image/pick_marker.png",
                      height: Dimensions.height10*5,width: Dimensions.width10*5,):CircularProgressIndicator()

                  ),
                  //la bare affiche l'adresse
                  Positioned(
                      top: Dimensions.height45,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      child: InkWell(
                        onTap: ()=>Get.dialog(Location_dialogue(mapController: _mapController,)),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                          height: Dimensions.height10*5,
                          decoration: BoxDecoration(
                            color: color.maincolor,
                            borderRadius: BorderRadius.circular(Dimensions.radius20/2),
                          ),

                          child: Row(
                            children: [
                              Icon(Icons.location_on,size: Dimensions.iconsize24,color: Colors.yellowAccent,),
                              Expanded(child: Text(
                                '${locationController.pickplacemark.name??''}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.font16
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                              SizedBox(width: Dimensions.width10,),
                              Icon(Icons.search, size: 25,color: Colors.yellowAccent,)
                            ],
                          ),
                        ),
                      ),
                  ),
                  //button pick address
                  Positioned(
                    bottom: 100,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      child: locationController.isLoading?Center(child: CircularProgressIndicator(),): Custome_button(
                        buttonText: locationController.inZone?widget.fromAddressarea?'Pick Adresse':'Pick Location':'hors la zone de livraison',
                        onPressed: (locationController.buttondisabl||locationController.loading)?null:(){
                          if(locationController.pickPosition.latitude!=0&&
                              locationController.pickplacemark.name!=null){
                            if(widget.fromAddressarea){
                              if(widget.googleMapController!=null){
                                print("adresse valide") ;
                                widget.googleMapController!.moveCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(target:LatLng(locationController.pickPosition.latitude,
                                            locationController.pickPosition.longitude)
                                        ))
                                );
                                locationController.setAddAdressData();
                              }
                              //Get.back();
                              Get.toNamed(Road_Helper.getAddressPage());
                            }
                          }
                        },
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

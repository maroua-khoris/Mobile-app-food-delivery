import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/src/places.dart';
import '../../../controllers/location_controller.dart';
import '../../Home/dimension.dart';

class Location_dialogue extends StatelessWidget {
  final GoogleMapController mapController;
  const Location_dialogue({Key? key, required this.mapController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller=TextEditingController();
    return Container(
      padding: EdgeInsets.all(Dimensions.width10),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius20/2),
        ),
        child: SizedBox(
          width: Dimensions.screenwidth,
          child: Container(
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _controller,
                textInputAction: TextInputAction.search,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  hintText: "search location",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius20/2),
                    borderSide: BorderSide(
                      style: BorderStyle.none,
                      width: 0,
                    ),
                  ),
                  hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                    color: Theme.of(context).disabledColor,
                          fontSize: Dimensions.font20,)
                )
              ),
              onSuggestionSelected: (Prediction suggestion) {
                Get.find<LocationController>().setLocation(suggestion.placeId!, suggestion.description!, mapController);
                Get.back();
                },
              suggestionsCallback: (pattern)async {
                return await Get.find<LocationController>().searchLocation(context, pattern);
              },
              itemBuilder: (BuildContext context, Prediction suggestions) {
                return Padding(
                  padding: EdgeInsets.all(Dimensions.width10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on),
                        Expanded(
                          child: Text(
                            suggestions.description!,
                                maxLines:1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline2?.copyWith(
                              color: Theme.of(context).textTheme.bodyText1?.color,
                              fontSize: Dimensions.font20,
                            ),

                          ),
                        )
                      ],
                    ),
                  ),
                );
              },

            ),
          ),
        ),
      ),
    );
  }
}

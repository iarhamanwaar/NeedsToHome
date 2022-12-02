import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:multisuperstore/src/helpers/helper.dart';
import 'package:multisuperstore/src/models/address.dart';
import 'package:multisuperstore/src/repository/home_repository.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

import '../../generated/l10n.dart';
import '../elements/AddressBoxLoaderWidget.dart';
import '../repository/settings_repository.dart';
class LocationDetector extends StatefulWidget {

  _LocationDetectorState createState() => _LocationDetectorState();
}

class _LocationDetectorState extends State<LocationDetector> {

  loc.Location locationR = loc.Location();
  int gate = 1;
  @override
  void initState() {

  _getCurrentLocation();

  super.initState();
  locationGate();
  }

  locationGate(){
    Timer(Duration(seconds: 20), () {
      setState(() {
        gate=2;
      });
    });
  }

  checkLocation() async {

 await locationR.requestService();
    if (!await locationR.serviceEnabled()) {
    locationR.requestService();

    print('enabled location');

    } else{

     _getCurrentLocation();
    }
  }

  String _currentAddress;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: Helper.of(context).onWillPop,

    child:Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: gate==1?Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

                        Container(
                          height: 220,width:220,
                          child:FlareActor(
                          "assets/img/location_place_holder.flr",
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                          animation: "record",
                        ),),
                        Container(
                          child:Text(_currentAddress == null?'${S.of(context).finding}...':'Find',
                          style: TextStyle(color:Theme.of(context).disabledColor.withOpacity(0.9),)
                          )
                        ),
                        Container(
                          padding: EdgeInsets.only(top:10),
                          child:  Wrap(
                              children:[
                                 Icon(Icons.location_on_outlined,color:Theme.of(context).disabledColor.withOpacity(0.9),),
                                Container(
                                    padding: EdgeInsets.only(left:5),
                                    child:Text(_currentAddress == null?S.of(context).getting_location:S.of(context).your_location,
                                   style: Theme.of(context).textTheme.headline3,
                                 )),
                              ]
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.only(top:10),
                            child:Text(_currentAddress != null?_currentAddress:'',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                              style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Colors.black)),
                            )
                        ),




            ],
          ):Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Container(
                  height: 220,width:220,
                child:Image.asset('assets/img/location_notfound.png',
                  height: 220,width:220,
                )
              ),

              Container(
                padding: EdgeInsets.only(top:10),
                child:  Wrap(
                    children:[
                      Icon(Icons.location_on_outlined,color:Theme.of(context).disabledColor.withOpacity(0.9),),
                      Container(
                          padding: EdgeInsets.only(left:5),
                          child:Text('${S.of(context).sorry} !',
                            style: Theme.of(context).textTheme.headline3,
                          )),
                    ]
                ),
              ),

              Container(
                  padding: EdgeInsets.only(top:10),
                  child:Text(S.of(context).your_location_cant_find_automatically_please_click_the_button_select_your_location,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Colors.black)),
                  )
              ),
              SizedBox(height:20),
              MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  elevation: 5.0,
                  minWidth: 200,
                  height: 50,
                  color: Theme.of(context).colorScheme.secondary,
                  child: new Text(S.of(context).choose_location,
                      style: Theme.of(context).textTheme.headline1.merge(TextStyle( color:Theme.of(context).primaryColorLight))
                  ),
                  onPressed: () async {
                    if(currentUser.value.latitude!=0.0 && currentUser.value.longitude!=0.0){
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlacePicker(
                            apiKey: setting.value.googleMapsKey,
                            initialPosition:LatLng(31.1975844, 29.9598339),
                            useCurrentLocation: false,

                            selectInitialPosition: true,
                            usePlaceDetailSearch: true,
                            forceSearchOnZoomChanged: true,

                            selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
                              if (isSearchBarFocused) {
                                return SizedBox();
                              }


                              //  Address _address = Address(address: selectedPlace?.formattedAddress ?? '');
                              return FloatingCard(
                                  height: 220,
                                  elevation: 0,
                                  width: double.infinity,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                  bottomPosition: 0.0,
                                  leftPosition: 0.0,
                                  rightPosition: 0.0,
                                  color: Theme.of(context).primaryColor,
                                  child: state == SearchingState.Searching
                                      ? AddressBoxLoaderWidget()
                                      : Container(
                                    padding: EdgeInsets.only(left:15,right:15,top:15),
                                    child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(S.of(context).select_delivery_location,style:Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Theme.of(context).hintColor))),
                                        SizedBox(height:20),
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:[
                                              Align(
                                                  alignment:Alignment.topLeft,
                                                  child:Icon(Icons.location_on_outlined,size:30)
                                              ),
                                              Expanded(
                                                  child:Container(
                                                      padding: EdgeInsets.only(left:10),
                                                      child:Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children:[
                                                            Text(S.of(context).address,style:Theme.of(context).textTheme.headline3),
                                                            SizedBox(height: 10,),
                                                            Text(selectedPlace?.formattedAddress,overflow: TextOverflow.ellipsis,maxLines: 2,
                                                                style:Theme.of(context).textTheme.bodyText2),
                                                          ]
                                                      )

                                                  )
                                              )
                                            ]
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom:15,top:35),
                                          width: double.infinity,
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.secondary,
                                            borderRadius: BorderRadius.circular(7),),

                                          child: MaterialButton(
                                            onPressed: () {
                                              currentUser.value.selected_address = selectedPlace?.formattedAddress;
                                              currentUser.value.latitude =  selectedPlace.geometry.location.lat;
                                              currentUser.value.longitude = selectedPlace.geometry.location.lng;
                                              Navigator.pop(context,selectedPlace?.formattedAddress);

                                            },
                                            child: Center(
                                                child: Text(
                                                    S.of(context).save_and_proceed,
                                                    style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                                                )),
                                          ),
                                        ),


                                      ],
                                    ),
                                  )
                              );
                            },
                          )
                      ),
                    );
                    if(currentUser.value.selected_address!='' && currentUser.value.selected_address!=null){
                      currentUser.value.locationType = 'manual';
                      setCurrentUserUpdate(currentUser.value);
                      Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
                    }
                    }


                  }

              ),



            ],
          ),
        ),
      ),
    ));
  }

  _getCurrentLocation() {
    print('location check');

    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {

      setState(() {
        print('get position');

        _getAddressFromLatLng(position);
      });
    }).catchError((e) {
      print(e);

      checkLocation();
    });
  }

  _getAddressFromLatLng(Position currentPosition) async {
    try {
      print('location loaded');
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition.latitude,
          currentPosition.longitude
      );

      Placemark place = placemarks[0];
      if (placemarks[0].locality != null && placemarks[0].locality.isNotEmpty) {
        setState(() {
          _currentAddress = "${place.street}, ${place.subLocality}, ${place
              .administrativeArea},${place.postalCode}, ${place.country}";
        });
      } else{
        setState(() {
          _currentAddress = "${place.street}, ${place.subAdministrativeArea}, ${place
              .administrativeArea},${place.postalCode}, ${place.country}";
        });
      }

      Address _addressData = Address();
      if(catchLocationList.value.length==0){

        _addressData.addressSelect = _currentAddress;
        _addressData.latitude = currentPosition.latitude;
        _addressData.longitude = currentPosition.longitude;
        _addressData.selected  = false;
        catchLocationList.value.add(_addressData);
        setCatchLocationList();
      } else {
        var contain = catchLocationList.value.where((element) => element.addressSelect==_currentAddress);

        _addressData.addressSelect = _currentAddress;
        _addressData.latitude = currentPosition.latitude;
        _addressData.longitude = currentPosition.longitude;
        _addressData.selected  = false;
        if (contain.isEmpty){

          catchLocationList.value.add(_addressData);
          setCatchLocationList();
        }





      }
      currentUser.value.selected_address =  _addressData.addressSelect;
      currentUser.value.latitude =  _addressData.latitude;
      currentUser.value.longitude =  _addressData.longitude;



      Timer(Duration(seconds: 1), () {
        currentUser.value.locationType = 'automatic';
        if(currentUser.value.latitude!=0 && currentUser.value.latitude!=null) {
          Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
        }
      });

    } catch (e) {
      print('location $e' );
      print(e);
    }
  }


}

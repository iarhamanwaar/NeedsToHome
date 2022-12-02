import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../generated/l10n.dart';
import '../../controllers/user_controller.dart';
import '../../elements/AddressBoxLoaderWidget.dart';
import '../../models/register.dart';
import '../../repository/settings_repository.dart';

// ignore: must_be_immutable
class RegisterFormStep2 extends StatefulWidget {
  RegisterFormStep2({Key key, this.registerData}) : super(key: key);
  Registermodel registerData;
  @override
  _RegisterFormStep2State createState() => _RegisterFormStep2State();
}

class _RegisterFormStep2State extends StateMVC<RegisterFormStep2> {
  int dropDownValue = 0;

  TextEditingController _controllerAddress1 = new TextEditingController();
  TextEditingController _controllerAddress2 = new TextEditingController();
  TextEditingController _controllerCity = new TextEditingController();
  TextEditingController _controllerState = new TextEditingController();
  TextEditingController _controllerZipcode = new TextEditingController();
  UserController _con;
  _RegisterFormStep2State() : super(UserController()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    var color = Colors.grey[300];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            //color: Theme.of(context).primaryColorDark,
              image: DecorationImage(
                  image: AssetImage('assets/img/background_image.jpg',
                  ),
                  fit: BoxFit.fill
              )
          ),
          child: SafeArea(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only( left: 10.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color:Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 10.0),
                      Text(S.of(context).address,
                        style: Theme.of(context).textTheme.headline4.merge(TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),


                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    width:double.infinity,
                    padding: EdgeInsets.only(left:20,right:20,top:20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              spreadRadius: 15
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Form(
                      key: _con.formKeys[1],
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                         Container(
                        child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[

                              Container(
                                padding: EdgeInsets.only(left:10,right:10),
                                width: double.infinity,
                                child:TextFormField(
                                    textAlign: TextAlign.left,
                                    controller: _controllerAddress1,
                                    onSaved: (input) => widget
                                        .registerData.address1 = input,
                                    validator: (input) => input.length < 1
                                        ? 'Please enter your address'
                                        : null,
                                    autocorrect: true,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: '${S.of(context).address} 1',
                                      labelStyle: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).hintColor)),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: color,
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                          Theme.of(context).colorScheme.secondary,
                                          width: 1.0,
                                        ),
                                      ),
                                    )
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(left:10,right:10),
                                  child: TextFormField(
                                      textAlign: TextAlign.left,
                                      controller: _controllerAddress2,
                                      onSaved: (input) => widget
                                          .registerData.address2 = input,
                                      autocorrect: true,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText: '${S.of(context).address} 2',
                                        labelStyle:  Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).hintColor)),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: color,
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme.secondary,
                                            width: 1.0,
                                          ),
                                        ),
                                      ))),


                              Container(
                                padding: EdgeInsets.only(left:10,right:10),
                                width: double.infinity,
                                child:TextFormField(
                                    textAlign: TextAlign.left,
                                    controller: _controllerCity,
                                    onSaved: (input) =>
                                    widget.registerData.city = input,
                                    autocorrect: true,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText:  S.of(context).city,
                                      labelStyle:  Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).hintColor)),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: color,
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                          Theme.of(context).colorScheme.secondary,
                                          width: 1.0,
                                        ),
                                      ),
                                    )
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(left:10,right:10),
                                  child: TextFormField(
                                      textAlign: TextAlign.left,
                                      controller: _controllerState,
                                      onSaved: (input) =>
                                      widget.registerData.state = input,
                                      autocorrect: true,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText: S.of(context).state,
                                        labelStyle: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).hintColor)),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: color,
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme.secondary,
                                            width: 1.0,
                                          ),
                                        ),
                                      ))),
                              Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(left:10,right:10),
                                  child: TextFormField(
                                      textAlign: TextAlign.left,
                                      autocorrect: true,
                                      keyboardType: TextInputType.number,
                                      controller: _controllerZipcode,
                                      onSaved: (input) => widget.registerData.zipcode = input,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter
                                            .digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        labelText:S.of(context).zipcode,

                                        labelStyle: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).hintColor)),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: color,
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme.secondary,
                                            width: 1.0,
                                          ),
                                        ),
                                      ))),

                            ]
                        )
                      ),
                            SizedBox(height: 20,),
                            InkWell(
                              onTap: () async {
                                LocationLatLog result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlacePicker(
                                        apiKey: setting.value.googleMapsKey,
                                        initialPosition: LatLng(31.1975844, 29.9598339),
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
                                                    Text('SELECT YOUR LOCATION',style:Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Theme.of(context).hintColor))),
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
                                                        onPressed: () async {

                                                          LocationLatLog  location = new LocationLatLog();
                                                          location.lat = selectedPlace.geometry.location.lat;
                                                          location.lng = selectedPlace.geometry.location.lng;
                                                          Navigator.pop(context,location);

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

                                List<Placemark> placemarks = await placemarkFromCoordinates(result.lat, result.lng);
                                int i = 1;
                                placemarks.forEach((element) {
                                  if(i==1) {

                                    _controllerAddress1.text = element.thoroughfare;
                                    _controllerAddress2.text = element.subLocality;
                                    _controllerCity.text = element.locality;
                                    _controllerState.text = element.administrativeArea;
                                    _controllerZipcode.text = element.postalCode;
                                  }
                                  i++;

                                });


                              },

                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text( S
                                      .of(context)
                                      .get_address_from_map,
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child:Container(
                      width: double.infinity,
                      height: 70,
                      color: Theme.of(context).primaryColor,
                      child:Container(
                          padding: EdgeInsets.only(left:10,right:10,top:10,bottom:10),
                          child:  MaterialButton(
                              onPressed:(){
                                _con.getLatLong(widget.registerData);
                              },
                              color: Theme.of(context).colorScheme.secondary,
                              child: Text(S.of(context).save_and_proceed,
                                style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).primaryColorLight)),
                              )
                          )
                      )
                  ),

                ),
              ],
            ),
          )
      ),
    );

  }
}

class LocationLatLog {
  LocationLatLog({this.lat, this.lng,});
  double lat;
  double lng;

}
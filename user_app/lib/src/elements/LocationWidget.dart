import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import '../controllers/user_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../models/address.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';
import '../../generated/l10n.dart';
import 'AddressBoxLoaderWidget.dart';



class LocationModalPart extends StatefulWidget {
  @override
  _LocationModalPartState createState() => _LocationModalPartState();
}

class _LocationModalPartState extends StateMVC<LocationModalPart> {
  UserController _con;

  Address address;
  _LocationModalPartState() : super(UserController()) {
    _con = controller;

  }

  String selectedRadio;

  @override
  void initState() {


    selectedRadio = 'Home';
   _con.addressData.id = 'Home';
    super.initState();
  }

  setSelectedRadio(val) {
    setState(() {
      selectedRadio = val;
    });
  }
  Widget removeAddress(address) {
    return PopupMenuButton(
        color: Theme.of(context).primaryColor,
        onSelected: (value) {

          if(value==1){
            setState(() {
              currentUser.value.address.removeWhere((item) => item.addressSelect == address);

            });
            setCurrentUserUpdate(currentUser.value);
          }
        },
        itemBuilder: (context) => [

          PopupMenuItem(
              value: 1,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                    child: Icon(Icons.delete),
                  ),
                  Text('Delete')
                ],
              )),

        ]);
  }
  @override
  Widget build(BuildContext context) {

    return Column(children: [
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
              )),
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Icon(
                      Icons.my_location,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5, top: 13),
                        child: Text(
                          S.of(context).select_your_location,
                          style: Theme.of(context).textTheme.headline1.merge(TextStyle(color: Colors.white)),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ]),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: () async {

                        /*Navigator.of(context).pushNamed('/Login');*/
                       /* LocationResult result = await PlacePicker(
                          context,
                          setting.value.googleMapsKey,
                          initialCenter: LatLng(31.1975844, 29.9598339),
                          automaticallyAnimateToCurrentLocation: true,
                          myLocationButtonEnabled: true,
                          layersButtonEnabled: true,
                          resultCardAlignment: Alignment.bottomCenter,
                        );

                        _con.addressData.latitude = result.latLng.latitude;
                        _con.addressData.longitude = result.latLng.longitude;
                        _con.addressData.addressSelect = result.address;
                        _con.addressData.isDefault = 'false';
                        currentUser.value.latitude = result.latLng.latitude;
                        currentUser.value.longitude = result.latLng.longitude;

                        AddressBottomsheet(_con.addressData); */
                        String result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlacePicker(
                              apiKey: setting.value.googleMapsKey,
                              initialPosition: LatLng(currentUser.value.latitude, currentUser.value.longitude),
                              useCurrentLocation: false,

                              selectInitialPosition: true,
                              usePlaceDetailSearch: true,
                              forceSearchOnZoomChanged: true,

                              selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
                                if (isSearchBarFocused) {
                                  return SizedBox();
                                }
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
                                        Text('SELECT DELIVERY LOCATION',style:Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Theme.of(context).hintColor))),
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
                                                Text('Address',style:Theme.of(context).textTheme.headline3),
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
                                              _con.addressData.latitude =  selectedPlace.geometry.location.lat;
                                              _con.addressData.longitude = selectedPlace.geometry.location.lng;
                                              _con.addressData.addressSelect = selectedPlace?.formattedAddress;
                                              _con.addressData.isDefault = 'false';
                                              currentUser.value.latitude = selectedPlace.geometry.location.lat;
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

                        AddressBottomsheet(result);
                      },
                      color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                      shape: StadiumBorder(),
                      child: Text(
                        S.of(context).add,
                        style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.white)),
                      ),
                    ),
                  )
                ],
              ),
              Text(
                S.of(context).turning_on_device_location_will_ensure_accurate_address_and_hassie_free_delivery,
                style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.white)),
                textAlign: TextAlign.left,
              ),
            ])),
      ),
      SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 1,
                    )),
              ),
              child: Text(S.of(context).select_delivery_address, style: Theme.of(context).textTheme.headline1)),
          currentUser.value.address.isNotEmpty
              ? ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: currentUser.value.address.length,
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.only(top: 10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, int index) {
                Address _addressData = currentUser.value.address.elementAt(index);


                return Column(children: <Widget>[
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => {
                      currentUser.value.address.forEach((_l) {
                        setState(() {
                          _l.isDefault = 'false';
                        });
                      }),
                      _addressData.isDefault = 'true',
                      currentUser.value.selected_address = _addressData.addressSelect,
                      currentUser.value.latitude = _addressData.latitude,
                      currentUser.value.longitude = _addressData.longitude,
                      setCurrentUserUpdate(currentUser.value),
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 1,
                            )),
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                        _addressData.isDefault == 'true'
                            ? Icon(
                          Icons.check_circle,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 24,
                        )
                            : SizedBox(
                          height: 25,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(_addressData.id=='Home'?S.of(context).home:_addressData.id=='Office'?S.of(context).home:S.of(context).others??'', style: Theme.of(context).textTheme.bodyText1),
                            Text(
                              _addressData.addressSelect,
                              style: Theme.of(context).textTheme.bodyText2,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ]),
                        ),
                        Container(
                            child:removeAddress( _addressData.addressSelect)),


                      ]),
                    ),
                  ),
                ]);
              })
              : Container()
        ]),
      ),
    ]);
  }

  // ignore: non_constant_identifier_names
  void AddressBottomsheet(address) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.49,
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            color: Color(0xff737373),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0)),
              ),
              child: SingleChildScrollView(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),

                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AddressModalPart(con: _con,  fullAddress: address,),
                            ]),

                    ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 5),
                      child:Container(
                        width: double.infinity,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(30),
                          /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))*/
                        ),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          onPressed: () {
                            _con.saveAddress();
                          },
                          child: Center(
                              child: Text(
                                S.of(context).save_and_proceed,
                                style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),),
            ),
          );
        });
  }


}

// ignore: must_be_immutable
class AddressModalPart extends StatefulWidget {
  AddressModalPart({Key key,this.con,  this.fullAddress});
  UserController con;

  String fullAddress;
  @override
  _AddressModalPartState createState() => _AddressModalPartState();
}

class _AddressModalPartState extends StateMVC<AddressModalPart> {
  String selectedRadio;
  Address address;
  @override
  void initState() {
    print('shop address');
    print(widget.fullAddress);
    super.initState();
    selectedRadio = 'Home';
    widget.con.addressData.id = 'Home';
  }

  setSelectedRadio(val) {
    setState(() {
      selectedRadio = val;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: widget.con.loginFormKey,
            child:Container(
              padding: const EdgeInsets.only(left: 15, right: 15,),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Padding(
                  padding: const EdgeInsets.only(top:20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on,color:Colors.blue),
                            Expanded(
                              child: Text(S.of(context).location_details,style:Theme.of(context).textTheme.subtitle2),
                            ),
                            SizedBox(width:20),
                            // ignore: deprecated_member_use


                          ],
                        ),


                        SizedBox(height: 5,),
                        Container(
                            width: double.infinity,
                            child: TextFormField(
                                textAlign: TextAlign.left,
                                autocorrect: true,
                                onSaved: (input) =>  widget.con.addressData.username = input,
                                validator: (input) =>input.length < 3 ? S.of(context).should_be_more_than_3_characters : null,
                                keyboardType: TextInputType.text,
                                initialValue: currentUser.value.name,
                                decoration: InputDecoration(
                                  labelText: 'Receivers Name',

                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .merge(TextStyle(color: Colors.grey)),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).colorScheme.secondary,
                                      width: 1.0,
                                    ),
                                  ),
                                ))),

                        SizedBox(height:5),
                        Container(
                            width: double.infinity,
                            child: TextFormField(
                                textAlign: TextAlign.left,
                                autocorrect: true,
                                keyboardType: TextInputType.text,
                                onSaved: (input) =>  widget.con.addressData.addressSelect = input,
                                validator: (input) => input.length < 3 ? S.of(context).should_be_more_than_3_characters : null,
                                initialValue: widget.fullAddress,
                                decoration: InputDecoration(
                                  labelText: 'Shop / office / home location address with Door/Flat No',
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .merge(TextStyle(color: Colors.grey)),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).colorScheme.secondary,
                                      width: 1.0,
                                    ),
                                  ),
                                ))),
                        SizedBox(height:5),
                        Container(
                            width: double.infinity,
                            child: TextFormField(
                                textAlign: TextAlign.left,
                                autocorrect: true,
                                keyboardType: TextInputType.text,
                                onSaved: (input) =>  widget.con.addressData.phone = input,
                                validator: (input) => input.length <= 0 ? S.of(context).invalid_mobile_number : null,
                                initialValue: currentUser.value.phone,
                                decoration: InputDecoration(
                                  labelText: 'Receivers phone number',
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .merge(TextStyle(color: Colors.grey)),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).colorScheme.secondary,
                                      width: 1.0,
                                    ),
                                  ),
                                ))),
                        SizedBox(height:10),
                        Row(mainAxisAlignment: MainAxisAlignment.start, children: [

                          Radio(
                              value: 'Home',
                              groupValue: selectedRadio,
                              activeColor: Colors.blue,
                              onChanged: (val) {
                                print("Radio $val");
                                widget.con.addressData.id = val;
                                setSelectedRadio(val);
                              }),
                          Text(S.of(context).home,style: Theme.of(context).textTheme.bodyText1,),

                          Radio(
                              value: 'Office',
                              groupValue: selectedRadio,
                              activeColor: Colors.blue,
                              onChanged: (val) {
                                widget.con.addressData.id = val;
                                setSelectedRadio(val);
                              }),
                          Text(S.of(context).office,style: Theme.of(context).textTheme.bodyText1,),
                          Radio(
                              value: 'Other',
                              groupValue: selectedRadio,
                              activeColor: Colors.blue,
                              onChanged: (val) {
                                widget.con.addressData.id = val;
                                setSelectedRadio(val);
                              }),
                          Text(S.of(context).others,style: Theme.of(context).textTheme.bodyText1,)
                        ]),

                      ]
                  )
              ),
            ),
          ),
















        ]);
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:just_audio/just_audio.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:products_deliveryboy/src/models/dashboard_model.dart';
import 'package:products_deliveryboy/src/repository/user_repository.dart';
import '../repository/user_repository.dart' as repository;

class HomeController extends ControllerMVC {

  GlobalKey<ScaffoldState> scaffoldKey;
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  bool liveStatus = true;
  double latitude;
  double longitude;
  DashboardModel dashboardData = new DashboardModel();
  HomeController() {

    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }


  @override
  // ignore: must_call_super
  void dispose() {
    /**if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose(); */
  }

  offLineMode(){
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
    // ignore: deprecated_member_use
    scaffoldKey?.currentState?.showSnackBar(SnackBar(
      content: Text('You are offline!'),
    ));
    status('false');

  }








  void getCurrentLocation() async {

    if(currentUser.value.liveStatus==true) {
      status('true');
    try {

       await _locationTracker.getLocation();
        loadBikeMusic();

        if (_locationSubscription != null) {
          _locationSubscription.cancel();
        }

        _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData) {
          if(currentUser.value.liveStatus==true) {
            locationUpdate(newLocalData.latitude, newLocalData.longitude);
            currentUser.value.latitude = newLocalData.latitude;
            currentUser.value.longitude = newLocalData.longitude;
            updateLatLong(newLocalData.latitude, newLocalData.longitude);
            locationUpdate(newLocalData.latitude, newLocalData.longitude);
          }
        });

        // ignore: deprecated_member_use
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text('You are online!'),
        ));


    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
    }
  }

  locationUpdate(latitude, longitude) {
 
  if(currentUser.value.currentOrderID!='' && currentUser.value.currentOrderID!=null && currentUser.value.liveStatus==true && currentUser.value.currentOrderID!='no_order') {
    FirebaseFirestore.instance
        .collection('orderDetails').doc(currentUser.value.currentOrderID)
        .update({'driverLatitude': latitude, 'driverLongitude': longitude}).catchError((e) {
      print(e);
    });
  }
  }
  getDashboardData() {

    repository.getDashboardDetails().then((value) {

      setState(() {
         dashboardData = value;
      });
    }).catchError((e) {

    }).whenComplete(() {

    });
  }


  final player = AudioPlayer();
  Future loadBikeMusic() async {

    await player.setAsset('assets/audio/BikeSounds.mp3');
    await player.play();
  }

  stateOff(state){
    status(state);
  }

}


Future<bool> status(status) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  bool res;
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}Api_delivery/statusUpdate/$status/${currentUser.value.id}?$_apiToken';
  print(url);
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );


  if (response.statusCode == 200) {
    res = true;
  } else {
    throw new Exception(response.body);
  }
  return res;
}

Future<bool> updateLatLong(double latitude, double longitude) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  bool res;
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}Api_delivery/latlongUpdate/$latitude/$longitude/${currentUser.value.id}?$_apiToken';

  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );
  print(url);

  if (response.statusCode == 200) {
    res = true;
  } else {
    throw new Exception(response.body);
  }
  return res;
}






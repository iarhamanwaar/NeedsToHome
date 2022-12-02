import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_and_signup_web/src/models/vendormodel.dart';
import 'package:login_and_signup_web/src/models/vendorshoptype.dart';
import 'package:login_and_signup_web/src/repository/market_repositry.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/helper.dart';
import '../models/address.dart';



class MapController extends ControllerMVC {

  List<Vendor> topMarkets = <Vendor>[];
  List<Marker> allMarkers = <Marker>[];
  List<Vendor> vendorlist = <Vendor>[];
  List<Marker> allProviderMarkers = <Marker>[];
  Address currentAddress;
  Set<Polyline> polylines = new Set();
  List<VendorShopType> shopTypeList = <VendorShopType>[];
  CameraPosition cameraPosition;

  // MapsUtil mapsUtil = new MapsUtil();
  Completer<GoogleMapController> mapController = Completer();
  OverlayEntry loader;
  bool pageLoader = true;

  MapController() {
    loader = Helper.overlayLoader(context);
  }


  void listenForNearMarkets(Address myLocation, Address areaLocation) async {
    final Stream<Vendor> stream = await getNearMarkets(
        myLocation, areaLocation, '');
    stream.listen((Vendor _market) {
      // Helper.calculateDistance();

      setState(() {
        if (_market.logo != null) {
          topMarkets.add(_market);
        }
      });
      Helper.getMarker(_market.toMap()).then((marker) {
        setState(() {
          allMarkers.add(marker);

        });
      });
    }, onError: (a) {}, onDone: () {});
  }

  Future<void> listenForVendor() async {
    final Stream<Vendor> stream = await getVendorList();
    stream.listen((Vendor _list) {
      setState(() => vendorlist.add(_list));
      print('vendoradress:${vendorlist[0].address}');
      print('vendorphone:${vendorlist[0].phone}');
      setState(() {
        if (_list.logo != null) {
          topMarkets.add(_list);
        }
      });
      Helper.getMarker(_list.toMap()).then((marker) {
        setState(() {
          allMarkers.add(marker);
          print('allmarkers:${allMarkers.length}');
        });
      });
    },
        onError: (a) {
          print(a);
        }, onDone: () {
          print('marker error');
        });
  }


  openMap(latitude, longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await
    canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }


/*
  void getDirectionSteps() async {
    currentAddress = await sett.getCurrentLocation();
    mapsUtil
        .get("origin=" +
            currentAddress.latitude.toString() +
            "," +
            currentAddress.longitude.toString() +
            "&destination=" +
            currentMarket.latitude +
            "," +
            currentMarket.longitude +
            "&key=${sett.setting.value?.googleMapsKey}")
        .then((dynamic res) {
      if (res != null) {
        List<LatLng> _latLng = res as List<LatLng>;
        _latLng?.insert(0, new LatLng(currentAddress.latitude, currentAddress.longitude));
        setState(() {
          polylines.add(new Polyline(
              visible: true,
              polylineId: new PolylineId(currentAddress.hashCode.toString()),
              points: _latLng,
              color: config.Colors().mainColor(0.8),
              width: 6));
        });
      }
    });
  }
 */

}
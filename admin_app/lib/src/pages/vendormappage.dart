import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_and_signup_web/src/controllers/map_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vrouter/vrouter.dart';
class VendorMapWidget extends StatefulWidget {

  final GlobalKey<ScaffoldState> parentScaffoldKey;

  VendorMapWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _VendorMapWidgetState createState() => _VendorMapWidgetState();
}

class _VendorMapWidgetState extends StateMVC<VendorMapWidget> {
  MapController _con;

  List<Marker> marker=<Marker>[];

  _VendorMapWidgetState() : super(MapController()) {
    _con = controller;
  }






  @override
  void initState() {
    /** _con.currentMarket = widget.routeArgument?.param as Market;
        if (_con.currentMarket?.latitude != null) {
        // user select a market
        _con.getMarketLocation();
        _con.getDirectionSteps();
        } else {
        _con.getCurrentLocation();
        } */

    // _con.getCurrentLocation();
    _con.listenForVendor();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){

            VRouter.of(context).to('/vendorlist');
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Stack(
//        fit: StackFit.expand,
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          GoogleMap(
            mapToolbarEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target:LatLng(13.082680,80.270721),
              zoom:10,
            ),
            markers: Set.from(_con.allMarkers),
          ),


        ],
      ),
    );
  }
}

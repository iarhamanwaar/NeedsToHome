import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multisuperstore/src/elements/ShopTypesSlider.dart';
import 'package:multisuperstore/src/models/shop_type.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/map_controller.dart';
import 'package:multisuperstore/generated/l10n.dart';
import '../elements/CircularLoadingWidget.dart';


class VendorMapWidget extends StatefulWidget {

  final GlobalKey<ScaffoldState> parentScaffoldKey;

  VendorMapWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _VendorMapWidgetState createState() => _VendorMapWidgetState();
}

class _VendorMapWidgetState extends StateMVC<VendorMapWidget> {
  MapController _con;

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

    _con.getCurrentLocation();
    _con.listenForShopType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: _con.currentAddress?.latitude == null
            ? new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
        )
            : IconButton(
          icon: new Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pushNamed('/Pages', arguments: 2),
        ),
        title: Text(
            S.of(context).explorer,
            style: Theme.of(context).textTheme.headline3
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.my_location,
              color: Theme.of(context).hintColor,
            ),
            onPressed: () {
              _con.goCurrentLocation();
            },
          ),

        ],
      ),
      body: Stack(
//        fit: StackFit.expand,
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          _con.cameraPosition == null
              ? CircularLoadingWidget(height: 0)
              : GoogleMap(
            mapToolbarEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: _con.cameraPosition,
            markers: Set.from(_con.allMarkers),
            onMapCreated: (GoogleMapController controller) {
              _con.mapController.complete(controller);
            },
            onCameraMove: (CameraPosition cameraPosition) {
              _con.cameraPosition = cameraPosition;
            },
            onCameraIdle: () {
              _con.getMarketsOfArea();
            },
            polylines: _con.polylines,
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children:[
                Container(
                  padding: EdgeInsets.only(top:20),
                  child:Container(
                    height: 85,
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: List<Widget>.generate(_con.shopTypeList.length, (index) {
                        ShopType _shopType = _con.shopTypeList.elementAt(index);
                        return Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(7.0)),
                            ),
                            child: Column(children: [
                              Container(
                                height: 55,
                                width: 55,
                                child: GestureDetector(
                                  onTap: () {
                                    _con.listenForNearMarketsWithID(_con.currentAddress, _con.currentAddress,_shopType.id);
                                  },
                                  child: new CircleAvatar(
                                    backgroundImage: new NetworkImage(_shopType.previewImage),
                                    radius: 80.0,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                child: Text(
                                  _shopType.title,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ]),
                          ),
                        );
                      }),
                    ),
                  ),),

              ]
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children:[
                ShopTopSlider(vendorList: _con.topMarkets, key: null,),

              ]
          ),

        ],
      ),
    );
  }
}

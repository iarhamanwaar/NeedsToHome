import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:products_deliveryboy/src/models/order_list.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../components/directions_model.dart';
import '../components/directions_repository.dart';
import '../controllers/order_controller.dart';
import '../helpers/helper.dart';
import '../repository/user_repository.dart';
import 'Widget/custom_divider_view.dart';
import '../../generated/l10n.dart';

// ignore: must_be_immutable
class MapWidget extends StatefulWidget {
  OrderList orderDetails;
  MapWidget({Key key, this.orderDetails}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends StateMVC<MapWidget> {
  final double _initFabHeight = 270.0;
  double _fabHeight;
  double _panelHeightOpen;
  double _panelHeightClosed = 250.0;

  OrderController _con;

  _MapWidgetState() : super(OrderController()) {
    _con = controller;
  }

  var _initialCameraPosition = CameraPosition(
    target: LatLng(currentUser.value.latitude, currentUser.value.longitude),
    zoom: 17.5,
  );

  // ignore: unused_field
  GoogleMapController _googleMapController;
  Marker _origin;
  Marker _destination;
  Directions _info;
  String status;

  List<LatLng> latlng = <LatLng>[];
  bool timerLimit = true;
  BitmapDescriptor customIcon;
  @override
  void initState() {
    //_con.listenForPaymentDetails(widget.orderId);
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(5, 5)), 'assets/img/deliveryboy.png')
        .then((d) {
      customIcon = d;

      getTrackDetails();
    });
    super.initState();
  }

  @override
  void dispose() {
    // _googleMapController.dispose();
    super.dispose();
  }

  getTrackDetails() {
    LatLng _destination;
    LatLng _driver;
    FirebaseFirestore.instance
        .collection("orderDetails")
        .where("orderId", isEqualTo: widget.orderDetails.sale_code)
        .snapshots()
        .listen((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()["status"] == 'RShipped') {
          _destination = LatLng(
              result.data()["shopLatitude"], result.data()["shopLongitude"]);
        } else {
          _destination = LatLng(result.data()["originLatitude"],
              result.data()["originLongitude"]);
        }

        _driver = LatLng(
            result.data()["driverLatitude"], result.data()["driverLongitude"]);

        latlng.add(_driver);
        latlng.add(_destination);
        _addMarker(_driver);
        _addMarker(_destination);
      });
    });
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeLeft: true,
      removeRight: true,
      child: Container(
          color: Theme.of(context).primaryColor,
          child: ListView(
            controller: sc,
            children: <Widget>[
              // ignore: unrelated_type_equality_checks
              widget.orderDetails.delivery_state == 'Start'
                  ? Container(
                      padding: EdgeInsets.only(left: 18, right: 18, bottom: 18),
                      color: Theme.of(context).primaryColor,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              _con.openMap(widget.orderDetails.shop.latitude,
                                  widget.orderDetails.shop.longitude);
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Icon(Icons.directions),
                                ),
                                Container(
                                    height: 15,
                                    color: Colors.deepOrange,
                                    padding: EdgeInsets.all(3),
                                    child: Center(
                                        child: Text(
                                      S.of(context).direction,
                                      style: TextStyle(
                                          fontSize: 7,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor),
                                    ))),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 30),
                                child: Text(
                                  S.of(context).order_pick_up,
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                child: Text(
                                  widget.orderDetails.shop.username,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                child: Text(
                                  widget.orderDetails.shop.addressSelect,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ),
                            ],
                          )),
                          Badge(
                            position:
                                BadgePosition.bottomEnd(bottom: -10, end: -5),
                            badgeContent: Container(
                              alignment: Alignment.center,
                              height: 25,
                              width: 25,
                              child: InkWell(
                                onTap: () {
                                  _callNumber(widget.orderDetails.shop.phone);
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))
                  : widget.orderDetails.delivery_state == 'Pickuped'
                      ? Container(
                          padding:
                              EdgeInsets.only(left: 18, right: 18, bottom: 18),
                          color: Theme.of(context).primaryColor,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  _con.openMap(
                                      widget.orderDetails.address.latitude,
                                      widget.orderDetails.address.longitude);
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Icon(Icons.directions),
                                    ),
                                    Container(
                                        height: 15,
                                        color: Colors.deepOrange,
                                        padding: EdgeInsets.all(3),
                                        child: Center(
                                            child: Text(
                                          S.of(context).direction,
                                          style: TextStyle(
                                              fontSize: 7,
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor),
                                        ))),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 30),
                                    child: Text(
                                     S.of(context).order_deliver,
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: Text(
                                      widget.orderDetails.address.username,
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: Text(
                                      widget.orderDetails.address.addressSelect,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ),
                                ],
                              )),
                              Badge(
                                position: BadgePosition.bottomEnd(
                                    bottom: -10, end: -5),
                                badgeContent: Container(
                                  alignment: Alignment.center,
                                  height: 25,
                                  width: 25,
                                  child: InkWell(
                                    onTap: () {
                                      _callNumber(
                                          widget.orderDetails.address.phone);
                                    },
                                    child: Center(
                                      child: Icon(
                                        Icons.call,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ))
                      : Container(),
              CustomDividerView(dividerHeight: 15.0),
              Container(
                padding: const EdgeInsets.all(20.0),
                color: Theme.of(context).primaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(S.of(context).bill_details,
                        style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(S.of(context).payment_model,
                            style: Theme.of(context).textTheme.subtitle2),
                        Text(  widget.orderDetails.payment_type=='cash on delivery'?S.of(context).cash_on_delivery:'Online',
                            style: Theme.of(context).textTheme.subtitle2),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      child: Row(
                        children: <Widget>[
                          Text(
                            S.of(context).to_pay,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Spacer(),
                          Text(
                            Helper.pricePrint(widget.orderDetails.paymentDetails.grand_total),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .95;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
        return false;
      },
      child: Scaffold(
        floatingActionButton: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Container(
                height: MediaQuery.of(context).size.width * 0.15,
                color: Colors.transparent,
                width: double.infinity,
                child: widget.orderDetails.delivery_state != 'Delivered'
                    ? Center(
                        child: Card(
                          elevation: 5,
                          shape: StadiumBorder(),
                          color: Theme.of(context).colorScheme.secondary,
                          // ignore: deprecated_member_use
                          child: FlatButton(
                            onPressed: () {
                              if (widget.orderDetails.delivery_state ==
                                  'Start') {
                                _con.statusUpdate('Pickuped',
                                    widget.orderDetails.sale_code, '');
                                setState(() {
                                  widget.orderDetails.delivery_state =
                                      'Pickuped';
                                });
                              } else {
                                _con.statusUpdate('Delivered',
                                    widget.orderDetails.sale_code, '');
                                setState(() {
                                  widget.orderDetails.delivery_state =
                                      'Delivered';
                                });
                              }
                            },
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 28),
                            color: Theme.of(context).colorScheme.secondary,
                            shape: StadiumBorder(),
                            child: widget.orderDetails.delivery_state == 'Start'
                                ? Text(
                                    S.of(context).pickuped,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .merge(TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                  )
                                : widget.orderDetails.delivery_state ==
                                        'Pickuped'
                                    ? Text(
                                        S.of(context).delivered,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .merge(TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600)),
                                      )
                                    : Container(),
                          ),
                        ),
                      )
                    : Container())),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          /**  leading: _con.currentMarket?.latitude == null
              ? new IconButton(
              icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
              onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
              )
              : IconButton(
              icon: new Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
              onPressed: () => Navigator.of(context).pushNamed('/Pages', arguments: 2),
              ), */
          title: Text(
            'Live Track',
            style: Theme.of(context)
                .textTheme
                .headline6
                .merge(TextStyle(letterSpacing: 1.3)),
          ),
        ),
        body: Stack(
//        fit: StackFit.expand,
          alignment: AlignmentDirectional.bottomStart,
          children: <Widget>[
            SlidingUpPanel(
              maxHeight: _panelHeightOpen,
              minHeight: _panelHeightClosed,
              parallaxEnabled: true,
              parallaxOffset: .5,
              panelBuilder: (sc) => _panel(sc),
              body: GoogleMap(
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: (controller) => _googleMapController = controller,
                markers: {
                  if (_origin != null) _origin,
                  if (_destination != null) _destination
                },
                polylines: {
                  if (_info != null)
                    Polyline(
                      polylineId: PolylineId('overview_polyline'),
                      color: Colors.black,
                      width: 4,
                      points: _info.polylinePoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList(),
                    ),
                },
              ),
              onPanelSlide: (double pos) => setState(() {
                _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                    _initFabHeight;
              }),
            ),
            Positioned(
                right: 20.0,
                bottom: _fabHeight,
                child: Container(
                    padding: EdgeInsets.all(5),
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black),
                    child: Column(
                      children: [
                        Text('food'),
                        SizedBox(height: 6),
                        _info == null
                            ? Text('--',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .merge(TextStyle(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        fontWeight: FontWeight.w600)))
                            : Text('${_info.totalDuration}',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .merge(TextStyle(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        fontWeight: FontWeight.w600))),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(3),
                            color: Theme.of(context).primaryColor,
                            width: 100,
                            child: Center(
                              child: Text(
                                'ON TIME',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .merge(TextStyle(
                                        color:
                                            Theme.of(context).backgroundColor)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      setState(() {
        print(customIcon);
        _origin = Marker(
          markerId: MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon: customIcon,
          position: pos,
        );
        // Reset destination
        _destination = null;

        // Reset info
        _info = null;
      });
    } else {
      // Origin is already set
      // Set destination
      setState(() {
        _destination = Marker(
          markerId: MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });

      // Get directions
      final directions = await DirectionsRepository()
          .getDirections(origin: _origin.position, destination: pos);
      setState(() => _info = directions);
    }
  }

  _callNumber(phone) async {
    String number = phone; //set the number here
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}

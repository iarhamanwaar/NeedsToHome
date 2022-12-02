import 'dart:typed_data';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_and_signup_web/src/components/light_color.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:login_and_signup_web/src/elements/VendorDetailsPopup.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/payment_report.dart';
import 'package:login_and_signup_web/src/models/walletmodel.dart';
import 'package:login_and_signup_web/src/pages/user_card.dart';
import 'package:login_and_signup_web/src/repository/secondary_repository.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;
import '../pages/product_list.dart';
import 'EmptyOrdersWidget.dart';
import 'WalletVendorTransactionListWidget.dart';


// ignore: must_be_immutable
class VendorDetailsWidget extends StatefulWidget {
  VendorDetailsWidget({this.con,this.walletModel,this.shopId});
  UserController con;
  WalletModel walletModel;
  int shopId;
  @override
  _VendorDetailsWidgetState createState() => _VendorDetailsWidgetState();
}

class _VendorDetailsWidgetState extends StateMVC<VendorDetailsWidget>
    with SingleTickerProviderStateMixin {
  bool status = false;
  SecondaryController _con;
  _VendorDetailsWidgetState() : super(SecondaryController()) {
    _con = controller;
  }
  TabController _tabController;

  bool _isSearch = false;
  //List<PaymentReport> _source = <PaymentReport>[];
  // ignore: deprecated_member_use

  // ignore: deprecated_member_use
  List<Map<String, dynamic>> _selecteds = List<Map<String, dynamic>>();


  String _sortColumn;
  bool _sortAscending = true;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  bool switchKey =false;
  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }


    Future<void> _addMarker() async {
      final Uint8List markerIcon = await getBytesFromAsset('assets/img/marker.png', 120);
      var markerIdVal = widget.con.profileDetails.general.companyLegalName;
      final MarkerId markerId = MarkerId(markerIdVal);

      final Marker marker = Marker(
        markerId: markerId,
        icon: BitmapDescriptor.fromBytes(markerIcon),
        position: LatLng(
          double.parse(widget.con.profileDetails.general.latitude),
          double.parse(widget.con.profileDetails.general.longitude),
        ),
      );
      setState(() {
        markers[markerId] = marker;
      });
  }

  getPoints(id) {
    try {
      /**  _con.zoneList.forEach((element) {
          if(element.zoneId==id){
          element.position.forEach((element1) {

          var parts = element1.split(' ');
          var latitude = parts[0].trim();
          var longitude = parts[1].trim();
          LatLng _driver = LatLng(latitude, longitude);

          polyLines.add(_driver);

          });
          }
          }); */
      print('error1');

      return [
        LatLng(13.494231, 80.177112),
        LatLng(13.46218, 79.452014),
        LatLng(13.144108, 79.116931),
        LatLng(12.889888, 79.171863),
        LatLng(12.772056, 79.421802),
        LatLng(12.683646, 79.80907),
        LatLng(12.705081, 80.23479),
        LatLng(13.026396, 80.278735),
        LatLng(13.205616, 80.319934),
        LatLng(13.349967, 80.3474),


      ];
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
    }
  }
  final _gap = 20.0;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 5);
    _con.listenForCOH('driver');
    _con.listenForSummary(currentUser.value.id);
    print('lat:${widget.con.profileDetails.general.latitude} Long:${widget.con.profileDetails.general.longitude}');
    _con.listenForInvoiceList(widget.shopId);
    _con.listenForReview(widget.shopId);

    _addMarker();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   var size = MediaQuery.of(context).size;
    List<DatatableHeader> _headers = [
      DatatableHeader(
          text: "ID",
          value: "id",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: S.of(context).invoice_id,
          value: "invoiceID",
          show: true,
          flex: 2,
          sortable: true,
          editable:false,
          textAlign: TextAlign.left),
      DatatableHeader(
        text: S.of(context).item_amount,
        value: "itemAmount",
        show: true,
        sortable: true,
        textAlign: TextAlign.left,
        sourceBuilder: (value, row) {

          return Container(child:Text(Helper.pricePrint(value)));},
      ),

      DatatableHeader(
          text: S.of(context).settlement_value,
          value: "settlementAmount",
          show: true,
          sortable: true,

          sourceBuilder: (value, row) {

            return Container(child:Text(Helper.pricePrint(value)));},
          textAlign: TextAlign.center),
      DatatableHeader(
          text: S.of(context).commission,
          value: "commission",
          show: true,
          sortable: true,
          sourceBuilder: (value, row) {

            return Container(child:Text(Helper.pricePrint(value)));},
          textAlign: TextAlign.left),

      DatatableHeader(
          text: S.of(context).driver_commision,
          value: "driverComission",
          show: true,
          sortable: true,
          sourceBuilder: (value, row) {

            return Container(child:Text(Helper.pricePrint(value)));},
          textAlign: TextAlign.left),
      DatatableHeader(
          text: S.of(context).driver_fees,
          value: "driverfees",
          show: true,
          sortable: true,
          sourceBuilder: (value, row) {

            return Container(child:Text(Helper.pricePrint(value)));},
          textAlign: TextAlign.left),

      DatatableHeader(
          text: S.of(context).payment_method,
          value: "paymentMethod",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
        text: S.of(context).payment_status,
        value: "status",
        show: true,
        sortable: true,
        textAlign: TextAlign.left,
        sourceBuilder: (value, row) {

          return Container(

            child: Wrap(
              alignment: WrapAlignment.start,
              children: [
                Badge(
                  toAnimate: false,
                  shape: BadgeShape.square,
                  badgeColor: value=='due'?Colors.red:Colors.green,
                  borderRadius: BorderRadius.circular(8),
                  badgeContent: Text(value, style: TextStyle(color: Colors.white)),
                ),

              ],
            ),
          );
        },),


      DatatableHeader(
          text: S.of(context).date,
          value: "date",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),


    ];
    if (widget.con.profileDetails.bankDetails.personalProof!=null) {
      return Container(
      decoration:BoxDecoration(
          color:Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight:Radius.circular(8)
          )
      ),
      margin:EdgeInsets.only(bottom:25),
      padding: EdgeInsets.only(bottom: 20),
      child: Column(

        children: [
          TabBar(
            isScrollable:true,
            controller: _tabController,
            indicatorColor: Color(0xFF5e078e),
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,

            tabs: [
              Tab(
                child: Text('Shop Info'),
              ),
              Tab(
                child: Text(S.of(context).general_details),
              ),
              Tab(
                child: Text('Transaction'),
              ),
              Tab(
                child: Text(S.of(context).reviews),
              ),
              Tab(
                child: Text('Items'),
              ),

            ],
          ),
          SizedBox(
            height: size.width > 769 ? 1000 : size.height,
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                    child:SingleChildScrollView(
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left:size.width > 769 ?25 :10,right:size.width > 769 ?25 :10),
                              child:Wrap(
                                  children:[
                                    Div(
                                        colS:11,
                                        colM:12,
                                        colL:5,
                                        child:Container(
                                          width:double.infinity,
                                          padding: EdgeInsets.only(left:size.width > 769 ? 10:0,right:size.width > 769 ? 10:0,top:20,bottom:10),
                                          child:UserCard(gap: _gap, con:widget.con , title: 'test',),
                                        )
                                    ),
                                    Div(
                                        colS: 12,
                                        colM: 12,
                                        colL: 6,
                                        child: Container(
                                          padding: EdgeInsets.only(left:size.width > 769 ? 10:5,right:size.width > 769 ? 10:5,top:20),
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              child: Container(
                                                width: MediaQuery.of(context).size.width,
                                                height: MediaQuery.of(context).size.height * 0.44,
                                                color: LightColor.navyBlue1,
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: <Widget>[
                                                    Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      children: <Widget>[
                                                        Text(
                                                            'total balance',
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .headline4
                                                                .merge(TextStyle(
                                                                color: Theme.of(
                                                                    context)
                                                                    .primaryColorLight))),
                                                        SizedBox(height: 10),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: <Widget>[
                                                            Text(
                                                                widget.walletModel.totalWalletBalance.toString(),
                                                                style: TextStyle(
                                                                    fontSize: 35,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                    color: LightColor
                                                                        .yellow2)),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),


                                                      ],
                                                    ),
                                                    Positioned(
                                                      left: -170,
                                                      top: -170,
                                                      child: CircleAvatar(
                                                        radius: 130,
                                                        backgroundColor:
                                                        LightColor.lightBlue2,
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: -160,
                                                      top: -190,
                                                      child: CircleAvatar(
                                                        radius: 130,
                                                        backgroundColor:
                                                        LightColor.lightBlue1,
                                                      ),
                                                    ),
                                                    Positioned(
                                                      right: -170,
                                                      bottom: -170,
                                                      child: CircleAvatar(
                                                        radius: 130,
                                                        backgroundColor:
                                                        LightColor.yellow2,
                                                      ),
                                                    ),
                                                    Positioned(
                                                      right: -160,
                                                      bottom: -190,
                                                      child: CircleAvatar(
                                                        radius: 130,
                                                        backgroundColor:
                                                        LightColor.yellow,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )),
                                        )),

                                  ]
                              ),
                            ),

                            Wrap(children: [
                              Div(
                                colS: 12,
                                colM: 12,
                                colL: 3,
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: ProjectProgressCard(
                                          color: Color(0xffFF4C60),
                                          projectName: 'request amount',
                                          percentComplete: '34%',
                                          progressIndicatorColor: Colors.redAccent[100],
                                          icon: Feather.box,
                                          amount: widget.walletModel.requestedCount.toString(),
                                          count: widget.walletModel.requestedAmount.toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Div(
                                colS: 12,
                                colM: 12,
                                colL: 3,
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: ProjectProgressCard(
                                          color: Color(0xff6C6CE5),
                                          projectName: 'collected cash',
                                          percentComplete: '78%',
                                          progressIndicatorColor: Colors.blue[200],
                                          icon: Feather.loader,
                                          amount: widget.walletModel.cashCollectCount.toString(),
                                          count: widget.walletModel.cashCollectAmount.toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Div(
                                colS: 12,
                                colM: 12,
                                colL: 3,
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: ProjectProgressCard(
                                          color: Color(0xffFF4C60),
                                          projectName: 'total withdraw',
                                          percentComplete: '34%',
                                          progressIndicatorColor: Colors.redAccent[100],
                                          icon: Icons.two_wheeler_outlined,
                                          amount: '0',
                                          count: widget.walletModel.totalWithdraw.toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Div(
                                colS: 12,
                                colM: 12,
                                colL: 3,
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: ProjectProgressCard(
                                          color: Color(0xffFAAA1E),
                                          projectName: S.of(context).total_earn,
                                          percentComplete: '82%',
                                          progressIndicatorColor: Colors.amber[200],
                                          icon: Icons.wifi_tethering,
                                          amount: '0',
                                          count: widget.walletModel.totalEarn.toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]),

                            Container(
                              padding: EdgeInsets.only(top:30,left:20,right:20),
                              child:Wrap(
                                  children:[
                                  Div(
                                  colS:12,
                                  colM:12,
                                  colL:5,
                                    child:VendorFullDetailsPopWidget(vendorBusinessCard: widget.con.businessCardData,)
                                  ),
                                    Div(
                                      colS:12,
                                      colM:12,
                                      colL:7,
                                      child: Column(
                                        children: [
                                          Text('ZoneId:${widget.con.profileDetails.zoneId} (${widget.con.profileDetails.zoneName})',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                          SizedBox(height: 10,),
                                          Container(
                                              padding: EdgeInsets.only(top:10,left:10,right:10),
                                              height:500,
                                              width:double.infinity,
                                              child:   GoogleMap(
                                                markers: Set<Marker>.of(markers.values),
                                                myLocationEnabled: true,
                                                initialCameraPosition: CameraPosition(
                                                  target: LatLng(double.parse(widget.con.profileDetails.general.latitude), double.parse(widget.con.profileDetails.general.longitude)),
                                                  zoom: 10.99,
                                                ),
)
                                          ),
                                        ],
                                      ),
                                    )
                                  ]
                              ),
                            )

                          ],
                        )
                    )
                ),
                Container(
                  child:SingleChildScrollView(
                    child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[

                          Wrap(
                              children:[
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:20,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,
                                        child:Text(S.of(context).name,style: Theme.of(context).textTheme.bodyText1,)
                                    ),
                                  ),
                                ),
                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:20,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(widget.con.profileDetails.general.ownerName,style: Theme.of(context).textTheme.subtitle2,)
                                    ),
                                  ),
                                ),

                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(S.of(context).shop_name,style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),
                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(widget.con.profileDetails.general.storeName,style: Theme.of(context).textTheme.subtitle2,)),
                                  ),
                                ),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text('Company Name',style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),
                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(widget.con.profileDetails.general.companyLegalName,style: Theme.of(context).textTheme.subtitle2,)),
                                  ),
                                ),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(S.of(context).subtitle,style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),
                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(widget.con.profileDetails.general.subtitle,style: Theme.of(context).textTheme.subtitle2,)),
                                  ),
                                ),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(S.of(context).email,style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),
                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(widget.con.profileDetails.general.email,style: Theme.of(context).textTheme.subtitle2,)),
                                  ),
                                ),

                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(S.of(context).phone,style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),
                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text('${widget.con.profileDetails.general.mobile}',style: Theme.of(context).textTheme.subtitle2,)),
                                  ),
                                ),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(S.of(context).alternative_mobile,style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),
                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text('${widget.con.profileDetails.general.alterMobile}',style: Theme.of(context).textTheme.subtitle2,)),
                                  ),
                                ),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(S.of(context).address,style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),
                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(widget.con.profileDetails.general.pickupAddress,style: Theme.of(context).textTheme.subtitle2,)),
                                  ),
                                ),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(S.of(context).landmark,style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),
                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(widget.con.profileDetails.general.landmark,style: Theme.of(context).textTheme.subtitle2,)),
                                  ),
                                ),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text('Holidays',style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),
                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(widget.con.profileDetails.general.holidays.monVal?'Mon':
                                        widget.con.profileDetails.general.holidays.tueVal?'Tue':
                                        widget.con.profileDetails.general.holidays.wedVal?'Weds':
                                        widget.con.profileDetails.general.holidays.thurVal?'Thur':
                                        widget.con.profileDetails.general.holidays.friVal?'Fri':
                                        widget.con.profileDetails.general.holidays.satVal?'Sat':
                                        widget.con.profileDetails.general.holidays.sunVal?'Sun':'No Holidays',style: Theme.of(context).textTheme.subtitle2,)),
                                  ),
                                ),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(S.of(context).open_time,style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),
                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text( widget.con.profileDetails.general.openingTime,style: Theme.of(context).textTheme.subtitle2,)),
                                  ),
                                ),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(S.of(context).close_time,style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),
                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(widget.con.profileDetails.general.closingTime,style: Theme.of(context).textTheme.subtitle2,)),
                                  ),
                                ),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(S.of(context).started_year,style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),
                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text( widget.con.profileDetails.bankDetails.selectedYear,style: Theme.of(context).textTheme.subtitle2,)),
                                  ),
                                ),

                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(S.of(context).status
                                          ,style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),
                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(S.of(context).success,style: Theme.of(context).textTheme.subtitle2,)),
                                  ),
                                ),


                                Div(
                                  colS:12,
                                  colM:12,
                                  colL:12,
                                  child:Container(
                                      padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                      child:Text('KYC Seller',
                                          style:Theme.of(context).textTheme.headline1
                                      )
                                  ),),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text('Government Proof ID',style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),

                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(widget.con.profileDetails.bankDetails.personalProof,style: Theme.of(context).textTheme.subtitle2,)),
                                  ),
                                ),



                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text( 'Business Type',style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),

                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(widget.con.profileDetails.bankDetails.businessType,style: Theme.of(context).textTheme.subtitle2,)),
                                  ),
                                ),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(S.of(context).account_number,style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),
                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(widget.con.profileDetails.bankDetails.accountNumber,style: Theme.of(context).textTheme.subtitle2,)),
                                  ),
                                ),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(S.of(context).swift_code,style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),
                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(widget.con.profileDetails.bankDetails.accountNumber,style: Theme.of(context).textTheme.subtitle2,)),
                                  ),
                                ),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text( 'Bank ACC Holder Name',style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),

                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(widget.con.profileDetails.bankDetails.holdersName,style: Theme.of(context).textTheme.subtitle2,)),
                                  ),
                                ),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:20,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(S.of(context).bank_name,style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),
                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:20,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(widget.con.profileDetails.bankDetails.bankName,style: Theme.of(context).textTheme.subtitle2,)),
                                  ),
                                ),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:20,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text('Proof Type',style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),
                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:20,left:20,right:20,bottom:10),
                                    child: InkWell(
                                      onTap: () async{
                                        final url = '${GlobalConfiguration().getValue('base_upload')}vendor_proof_image/vendor_proof_${widget.shopId}.png';
                                        print( url);
                                        if (await canLaunch(url)) {
                                        await launch(
                                        url,
                                        forceSafariVC: false,
                                        );
                                        }
                                      },
                                      child: Container(
                                          width: double.infinity,

                                          child: Text('click - ${widget.con.profileDetails.bankDetails.proofType}',style: Theme.of(context).textTheme.subtitle2,)),
                                    ),
                                  ),
                                ),


                              ]
                          ),


                        ]
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left:20,right:20,bottom:0,top:0),
                    child:DefaultTabController(
                        length: 2,
                        child:Scaffold(
                          appBar:AppBar(
                            elevation: 0,
                            toolbarHeight: 50,
                            backgroundColor: Theme.of(context).primaryColor,
                            automaticallyImplyLeading: false,
                            bottom:TabBar(
                                indicatorColor: Color(0xFF5e078e),
                                unselectedLabelColor: Colors.grey,
                                tabs:[
                                  Tab(
                                      child:Text(S.of(context).order)
                                  ),
                                  Tab(
                                      child:Text(S.of(context).settelment)
                                  )
                                ]
                            ),
                          ),
                          body: TabBarView(
                              children:[
                                Container(
                                    child:SingleChildScrollView(
                                        child:Column(
                                            children:[
                                              Container(
                                                margin: EdgeInsets.all(10),
                                                padding: EdgeInsets.all(0),
                                                constraints: BoxConstraints(
                                                  maxHeight: 700,
                                                ),
                                                child: Card(
                                                  elevation: 1,
                                                  shadowColor: Colors.black,
                                                  clipBehavior: Clip.none,
                                                  child: ResponsiveDatatable(

                                                    actions: [
                                                      if (_isSearch)
                                                        Expanded(
                                                            child: TextField(
                                                              onChanged: (e){


                                                                setState((){
                                                                  _con.source = filterListReport(_con.originalSource, e);
                                                                });
                                                              },
                                                              decoration: InputDecoration(
                                                                  prefixIcon: IconButton(
                                                                      icon: Icon(Icons.cancel),
                                                                      onPressed: () {
                                                                        setState(() {
                                                                          _isSearch = false;
                                                                        });
                                                                      }),
                                                                  suffixIcon: IconButton(
                                                                      icon: Icon(Icons.search), onPressed: () {})),
                                                            )),
                                                      if (!_isSearch)
                                                        IconButton(
                                                            icon: Icon(Icons.search),
                                                            onPressed: () {
                                                              setState(() {
                                                                _isSearch = true;
                                                              });
                                                            })
                                                    ],
                                                    headers: _headers,
                                                    source: _con.source,
                                                    selecteds: _selecteds,
                                                    autoHeight: false,
                                                    onTabRow: (data) {
                                                      print(data);
                                                    },
                                                    onSort: (value) {
                                                      setState(() {
                                                        _sortColumn = value;
                                                        _sortAscending = !_sortAscending;
                                                        if (_sortAscending) {
                                                          _con.source.sort((a, b) =>
                                                              b["$_sortColumn"].compareTo(a["$_sortColumn"]));
                                                        } else {
                                                          _con.source.sort((a, b) =>
                                                              a["$_sortColumn"].compareTo(b["$_sortColumn"]));
                                                        }
                                                      });
                                                    },
                                                    sortAscending: _sortAscending,
                                                    sortColumn: _sortColumn,
                                                    isLoading: _con.isLoading,

                                                    /*footers: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text("Rows per page:"),
                        ),
                        if (_perPages != null)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: DropdownButton(
                                value: _currentPerPage,
                                items: _perPages
                                    .map((e) => DropdownMenuItem(
                                  child: Text("$e"),
                                  value: e,
                                ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _currentPerPage = value;
                                  });
                                }),
                          ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child:
                          Text("$_currentPage - $_currentPerPage of $_total"),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                          ),
                          onPressed: () {
                            setState(() {
                              _currentPage =
                              _currentPage >= 2 ? _currentPage - 1 : 1;
                            });
                          },
                          padding: EdgeInsets.symmetric(horizontal: 15),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios, size: 16),
                          onPressed: () {
                            setState(() {
                              _currentPage++;
                            });
                          },
                          padding: EdgeInsets.symmetric(horizontal: 15),
                        )
                      ]*/
                                                  ),
                                                ),
                                              ),
                                            ]
                                        )
                                    )

                                ),
                                Container(
                                  padding: EdgeInsets.only(left:20,right:20),
                                  child:SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        WalletVendorTransactionListWidget(
                                          type: 'vendor',
                                          vendorId: widget.shopId,
                                        ),
                                        //WalletTransactionListWidget(type: 'vendor',vendorId: int.parse(widget.con.profileDetails.general.id),),
                                      ],
                                    ),

                                  ),
                                )
                              ]
                          ),
                        )
                    )

                ),
                (_con.shopRatingList.length == 0)
                    ? EmptyOrdersWidget()
                    :
                Container(
                    child:SingleChildScrollView(
                        child:Column(
                            children:[
                              Wrap(
                                  children:List.generate(_con.shopRatingList.length, (index) {
                                    return Div(
                                        colS:12,
                                        colM:6,
                                        colL:6,child:Container(
                                      padding: EdgeInsets.only(bottom:20,left: 20,top:20,right:20),
                                      child:Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.0),
                                            color: Colors.purple),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      width:60.0,
                                                      child:Text(_con.shopRatingList[index].buyerId,
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 1,
                                                          style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                                                      ),
                                                    ),

                                                    Text(_con.shopRatingList[index].date,
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                        style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                                                    ),

                                                    RatingBar.builder(
                                                      initialRating: double.parse(_con.shopRatingList[index].rating),
                                                      minRating: 1,
                                                      direction: Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: 12,
                                                      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                                      itemBuilder: (context, _) => Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ), onRatingUpdate: (double value) {  },
                                                      /*onRatingUpdate: (rating) {
                                                        print(rating);
                                                      },*/

                                                    ),

                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                  child:Row(
                                                      children:[
                                                        Expanded(
                                                          child:Container(
                                                            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                                                            child: Text(_con.shopRatingList[index].message,
                                                                style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Tooltip(
                                                            message: 'Hide Comment',
                                                            child: FlutterSwitch(
                                                              width: 55.0,
                                                              height: 25.0,
                                                              valueFontSize: 55.0,
                                                              toggleSize: 15.0,
                                                              value: _con.shopRatingList[index].status,
                                                              borderRadius: 30.0,
                                                              padding: 8.0,
                                                              showOnOff: true,
                                                              onToggle: (val) {
                                                                setState(() {
                                                                  if(val==true){
                                                                    statusUpdate('shop_rating',_con.shopRatingList[index].id,'status','1');
                                                                  } else{

                                                                    statusUpdate('shop_rating',_con.shopRatingList[index].id,'status','0');
                                                                  }
                                                                  _con.shopRatingList[index].status= val;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ),




                                                      ]
                                                  )
                                              ),

                                            ]),
                                      ),
                                    ));
                                  })
                              ),
                            ]
                        )
                    )
                ),
                ProductList(shopId: widget.shopId,shopType: widget.con.profileDetails.shopType,),
               // ProductBox(),
              ],
            ),
          ),
        ],
      ),
    );
    } else {
      return Container();
    }
  }
  filterListReport( List<Map<String, dynamic>> list, String filterString) {

    List<PaymentReport> tempList = list.map<PaymentReport>((json)=>PaymentReport.fromJSON(json)).toList();


    List<PaymentReport> _list = tempList
        .where(( u) =>
    (u.paymentMethod.toLowerCase().contains(filterString.toLowerCase()) || u.invoiceID.toLowerCase().contains(filterString.toLowerCase()) || u.transactionID.toLowerCase().contains(filterString.toLowerCase())) ).toList();
    //  List<Map<String, dynamic>> _result =  _list.cast();
    List<Map<String, dynamic>> _result = _list.map<Map<String, dynamic>>((json)=> Map<String, dynamic>.from(json.toMap()) ).toList();
    print(_result.length);
    return _result;
  }
}


class ProjectProgressCard extends StatefulWidget {
  final Color color;
  final Color progressIndicatorColor;
  final String projectName;
  final String percentComplete;
  final IconData icon;
  final String amount;
  final String count;

  ProjectProgressCard({
    this.color,
    this.progressIndicatorColor,
    this.percentComplete,
    this.projectName,
    this.icon,
    this.amount,
    this.count,
  });

  @override
  _ProjectProgressCardState createState() => _ProjectProgressCardState();
}

class _ProjectProgressCardState extends State<ProjectProgressCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: MouseRegion(
        onEnter: (value) {
          setState(() {
            hovered = true;
          });
        },
        onExit: (value) {
          setState(() {
            hovered = false;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 275),
          width: 200,
          padding: EdgeInsets.only(top: 20, bottom: 20, right: 18, left: 18),
          decoration: BoxDecoration(
              color: hovered ? widget.color : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20.0,
                  spreadRadius: 5.0,
                ),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.projectName,
                                style: hovered
                                    ? Theme.of(context).textTheme.bodyText1.merge(
                                    TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context)
                                            .primaryColorLight))
                                    : Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .merge(TextStyle(
                                  fontWeight: FontWeight.w700,
                                )),
                                /*style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: hovered ? Colors.white : Colors.black,
                      ),*/
                              ),
                              Text(
                                widget.amount,
                                style: hovered
                                    ? Theme.of(context).textTheme.caption.merge(
                                    TextStyle(
                                        color: Theme.of(context)
                                            .primaryColorLight))
                                    : Theme.of(context).textTheme.caption,
                              )
                            ])),
                  ),
                  Container(
                    height: 30.0,
                    width: 30.0,
                    child: Icon(
                      widget.icon,
                      color: !hovered ? Colors.grey : Colors.grey,
                      size: 16.0,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: hovered
                            ? Theme.of(context).scaffoldBackgroundColor
                            : Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(children: [
                Expanded(
                  child: RichText(
                    text: new TextSpan(
                      text: Helper.pricePrint(widget.count),
                      style: hovered
                          ? Theme.of(context).textTheme.bodyText1.merge(
                          TextStyle(
                              color: Theme.of(context).primaryColorLight))
                          : Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                        child: Icon(Icons.more_vert,
                            color: Theme.of(context).disabledColor)))
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
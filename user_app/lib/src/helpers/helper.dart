import 'dart:async';
import 'dart:math' as Math;
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:html/parser.dart';
import 'package:multisuperstore/src/models/product_details2.dart';
import 'package:multisuperstore/src/models/vendor.dart';
import '../elements/ClearCartWidget.dart';
import '../repository/order_repository.dart';
import '../repository/settings_repository.dart';
import '../elements/CircularLoadingWidget.dart';
import 'custom_trace.dart';

class Helper {
  BuildContext context;
  DateTime currentBackPressTime;

  Helper.of(BuildContext _context) {
    this.context = _context;
  }

  // for mapping data retrieved form json array
  static getData(Map<String, dynamic> data) {

    return data['data'] ?? [];
  }



  static int getIntData(Map<String, dynamic> data) {
    return (data['data'] as int) ?? 0;
  }

  static bool getBoolData(Map<String, dynamic> data) {
    return (data['data'] as bool) ?? false;
  }

  static getObjectData(Map<String, dynamic> data) {
    return data['data'] ?? new Map<String, dynamic>();
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  static List<Icon> getStarsList(double rate, {double size = 18}) {
    var list = <Icon>[];
    list = List.generate(rate.floor(), (index) {
      return Icon(Icons.star, size: size, color: Color(0xFFFFB24D));
    });
    if (rate - rate.floor() > 0) {
      list.add(Icon(Icons.star_half, size: size, color: Color(0xFFFFB24D)));
    }
    list.addAll(List.generate(5 - rate.floor() - (rate - rate.floor()).ceil(), (index) {
      return Icon(Icons.star_border, size: size, color: Color(0xFFFFB24D));
    }));
    return list;
  }

  static String getDistance(double distance, String unit) {
    String _unit = setting.value.distanceUnit;
    if (_unit == 'km') {
      distance *= 1.60934;
    }
    return distance != null ? distance.toStringAsFixed(2) + " " + unit : "";
  }

  static String skipHtml(String htmlString) {
    try {
      var document = parse(htmlString);
      String parsedString = parse(document.body.text).documentElement.text;
      return parsedString;
    } catch (e) {
      return '';
    }
  }

  static calculateDeliveryFees(){

    int deliveryFees =0;

    currentLogisticsPricing.value.forEach((item) {
      if(item.fromRange <= currentCheckout.value.km && item.toRange >= currentCheckout.value.km){
        deliveryFees = item.amount;
      }
    });
    return deliveryFees;
  }

  static shopOpenStatus(Vendor vendorList){
    var openTime = vendorList.openingTime.split(" ");
    var closeTime = vendorList.closingTime.split(" ");
    var openHrm = openTime[0].split(":");
    var closeHrm = closeTime[0].split(":");

    DateTime now = DateTime.now();
    String currentDay = DateFormat('EEEE').format(DateTime.now());
    bool currentDayStatus = false;
    DateTime startTime;
    DateTime endTime;
    String dayVelocity;
    if(currentDay=='Monday'){
      currentDayStatus = vendorList.holidays.monVal;
    }if(currentDay=='Tuesday'){
      currentDayStatus = vendorList.holidays.tueVal;
    }if(currentDay=='Wednesday'){
      currentDayStatus = vendorList.holidays.wedVal;
    }if(currentDay=='Thursday'){
      currentDayStatus = vendorList.holidays.thurVal;
    }if(currentDay=='Friday'){
      currentDayStatus = vendorList.holidays.friVal;
    }if(currentDay=='Saturday'){
      currentDayStatus = vendorList.holidays.satVal;
    }if(currentDay=='Sunday'){
      currentDayStatus = vendorList.holidays.sunVal;
    } bool status = false;

  if(currentDayStatus==false) {

    if (openTime[1] == 'AM' && closeTime[1] == 'AM') {
      startTime = DateTime(
          now.year, now.month, now.day, int.parse(openHrm[0].trim()),
          int.parse(openHrm[1].trim()));
      endTime = DateTime(
          now.year, now.month, now.day, int.parse(closeHrm[0].trim()),
          int.parse(closeHrm[1].trim()));
      dayVelocity = 'straight';
    } else if (openTime[1] == 'AM' && closeTime[1] == 'PM') {
      startTime = DateTime(
          now.year, now.month, now.day, int.parse(openHrm[0].trim()),
          int.parse(openHrm[1].trim()));
      endTime = DateTime(
          now.year, now.month, now.day, int.parse(closeHrm[0].trim()) + 12,
          int.parse(closeHrm[1].trim()));
      dayVelocity = 'straight';
    } else if (openTime[1] == 'PM' && closeTime[1] == 'PM') {
      startTime = DateTime(
          now.year, now.month, now.day, int.parse(openHrm[0].trim()) + 12,
          int.parse(openHrm[1].trim()));
      endTime = DateTime(
          now.year, now.month, now.day, int.parse(closeHrm[0].trim()) + 12,
          int.parse(closeHrm[1].trim()));
      dayVelocity = 'straight';
    } else if (openTime[1] == 'PM' && closeTime[1] == 'AM') {
      startTime = DateTime(
          now.year, now.month, now.day, int.parse(openHrm[0].trim()) + 12,
          int.parse(openHrm[1].trim()));
      endTime = DateTime(
          now.year, now.month, now.day, int.parse(closeHrm[0].trim()),
          int.parse(closeHrm[1].trim()));
      dayVelocity = 'reverse';
    }

    if (now.isAfter(startTime) && now.isBefore(endTime) && dayVelocity=='straight') {

      // do something
      status = true;
    } else if (now.isAfter(endTime) && now.isAfter(startTime)&& dayVelocity=='reverse'){

      status = true;
    }


  }else{
    print('closed');
    status = false;
  }

       return status;
  }





  static itemAvailableStatus(ProductDetails2 product){
    var openTime = product.fromTime.split(" ");
    var closeTime = product.toTime.split(" ");
    var openHrm = openTime[0].split(":");
    var closeHrm = closeTime[0].split(":");
    DateTime now = DateTime.now();
    bool status = false;
    DateTime startTime;
    DateTime endTime;

        print('productname - ${product.id} ${product.product_name} - ${openTime[1]}: ${openHrm}');

      if (openTime[1] == 'AM' && closeTime[1] == 'AM') {
        startTime = DateTime(
            now.year, now.month, now.day, int.parse(openHrm[0].trim()),
            int.parse(openHrm[1].trim()));
        endTime = DateTime(
            now.year, now.month, now.day, int.parse(closeHrm[0].trim()),
            int.parse(closeHrm[1].trim()));
      } else if (openTime[1] == 'AM' && closeTime[1] == 'PM') {
        startTime = DateTime(
            now.year, now.month, now.day, int.parse(openHrm[0].trim()),
            int.parse(openHrm[1].trim()));
        endTime = DateTime(
            now.year, now.month, now.day, int.parse(closeHrm[0].trim()) + 12,
            int.parse(closeHrm[1].trim()));
      } else if (openTime[1] == 'PM' && closeTime[1] == 'PM') {
        startTime = DateTime(
            now.year, now.month, now.day, int.parse(openHrm[0].trim()) + 12,
            int.parse(openHrm[1].trim()));
        endTime = DateTime(
            now.year, now.month, now.day, int.parse(closeHrm[0].trim()) + 12,
            int.parse(closeHrm[1].trim()));
      }
   if(startTime!= null) {
     if (now.isAfter(startTime) && now.isBefore(endTime)) {
       // do something

       status = true;
     }
   }


    return status;
  }


  static checkCancellationStatus(  timestamp, int min){
    int timeInMillis = int.parse(timestamp);
    var cancellationDate = DateTime.fromMillisecondsSinceEpoch(timeInMillis * 1000).add(Duration(minutes: min ));

    int cancellationTs = cancellationDate.millisecondsSinceEpoch;
    int currentTs = DateTime.now().millisecondsSinceEpoch;
     if(currentTs>cancellationTs){

       return false;
     }else {

       return true;
     }
  }

  static OverlayEntry overlayLoader(context) {
    OverlayEntry loader = OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      return Positioned(
        height: size.height,
        width: size.width,
        top: 0,
        left: 0,
        child: Material(
          color: Theme.of(context).primaryColor.withOpacity(0.85),
          child: CircularLoadingWidget(height: 200),
        ),
      );
    });
    return loader;
  }

  static pricePrint(amount) {
    // ignore: unrelated_type_equality_checks
    if (setting.value.currencyRight) {
      return '$amount ${setting.value.defaultCurrency}';
    } else {
      return '${setting.value.defaultCurrency} $amount';

    }
  }



  static priceDistance(km) {

      if(setting.value.distanceUnit=='miles') {

        return '$km Mi';
      } else{

        return '$km Km';

      }

  }

  static calculateTime(double distance, int handoverTime, bool minLock){
    var avgSpeed = (1/ 48);
    var hours  =  avgSpeed* distance;
    var mins   =  hours * 60;
    var totalMinutes   = (mins+handoverTime).toStringAsFixed(0);
    if(minLock){
      return "$totalMinutes";
    }else {
      return "$totalMinutes mins";
    }

  }

  static hideLoader(OverlayEntry loader) {
    Timer(Duration(milliseconds: 500), () {
      try {
        loader?.remove();
      } catch (e) {}
    });
  }

  static String limitString(String text, {int limit = 24, String hiddenText = "..."}) {
    return text.substring(0, Math.min<int>(limit, text.length)) + (text.length > limit ? hiddenText : '');
  }

  static String getCreditCardNumber(String number) {
    String result = '';
    if (number != null && number.isNotEmpty && number.length == 16) {
      result = number.substring(0, 4);
      result += ' ' + number.substring(4, 8);
      result += ' ' + number.substring(8, 12);
      result += ' ' + number.substring(12, 16);
    }
    return result;
  }

  static Uri getUri(String path) {
    // ignore: deprecated_member_use
    String _path = Uri.parse(GlobalConfiguration().getString('base_url')).path;
    if (!_path.endsWith('/')) {
      _path += '/';
    }
    Uri uri = Uri(
        // ignore: deprecated_member_use
        scheme: Uri.parse(GlobalConfiguration().getString('base_url')).scheme,
        // ignore: deprecated_member_use
        host: Uri.parse(GlobalConfiguration().getString('base_url')).host,
        // ignore: deprecated_member_use
        port: Uri.parse(GlobalConfiguration().getString('base_url')).port,
        path: _path + path);
    return uri;
  }

  Color getColorFromHex(String hex) {
    if (hex.contains('#')) {
      return Color(int.parse(hex.replaceAll("#", "0xFF")));
    } else {
      return Color(int.parse("0xFF" + hex));
    }
  }
  static Future<Marker> getMyPositionMarker(double latitude, double longitude) async {
    final Uint8List markerIcon = await getBytesFromAsset('assets/img/my_marker.png', 120);
    final Marker marker = Marker(
        markerId: MarkerId(Random().nextInt(100).toString()),
        icon: BitmapDescriptor.fromBytes(markerIcon),
        anchor: Offset(0.5, 0.5),
        position: LatLng(latitude, longitude));

    return marker;
  }
  static BoxFit getBoxFit(String boxFit) {
    switch (boxFit) {
      case 'cover':
        return BoxFit.cover;
      case 'fill':
        return BoxFit.fill;
      case 'contain':
        return BoxFit.contain;
      case 'fit_height':
        return BoxFit.fitHeight;
      case 'fit_width':
        return BoxFit.fitWidth;
      case 'none':
        return BoxFit.none;
      case 'scale_down':
        return BoxFit.scaleDown;
      default:
        return BoxFit.cover;
    }
  }

  static Future<Marker> getMarker(Map<String, dynamic> res) async {

    final Uint8List markerIcon = await getBytesFromAsset('assets/img/marker.png', 120);
    final Marker marker = Marker(
        markerId: MarkerId(res['shopId']),
        icon: BitmapDescriptor.fromBytes(markerIcon),
//        onTap: () {
//          //print(res.name);
//        },
        anchor: Offset(0.5, 0.5),
        infoWindow: InfoWindow(
            title: res['shopName'],
            snippet: Helper.priceDistance(res['distance']),
            onTap: () {
              print(CustomTrace(StackTrace.current, message: 'Info Window'));
            }),
        position: LatLng(double.parse(res['latitude']), double.parse(res['longitude'])));

    return marker;
  }


  static Future<Marker> getMarkerProvider(Map<String, dynamic> res) async {

    final Uint8List markerIcon = await getBytesFromAsset('assets/img/marker.png', 120);
    final Marker marker = Marker(
        markerId: MarkerId(res['id']),
        icon: BitmapDescriptor.fromBytes(markerIcon),
//        onTap: () {
//          //print(res.name);
//        },
        anchor: Offset(0.5, 0.5),
        infoWindow: InfoWindow(
            title: res['name'],
            snippet: '2',
            onTap: () {
              print(CustomTrace(StackTrace.current, message: 'Info Window'));
            }),
        position: LatLng(double.parse(res['latitude']), double.parse(res['longitude'])));

    return marker;
  }



  static distance(
      double lat1, double lon1, double lat2, double lon2, String unit) {
    double theta = lon1 - lon2;
    double dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) +
        cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta));
    dist = acos(dist);
    dist = rad2deg(dist);
    dist = dist * 60 * 1.1515;
    if (unit == 'miles') {
      dist = dist * 0.8684;
    } else  {
      dist = dist * 1.609344;
    }

    return double.parse(dist.toStringAsFixed(2));
  }

  static double deg2rad(double deg) {
    return (deg * pi / 180.0);
  }

  static  double rad2deg(double rad) {
    return (rad * 180.0 / pi);
  }


  // ignore: non_constant_identifier_names
  void ClearCartShow() {
    var size = MediaQuery.of(context)
        .size;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: size.height * 0.3,
            color: Color(0xff737373),
            child: Container(

              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left:size.width * 0.05,right:size.width * 0.05),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClearCart(),
                            ]),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left:size.width * 0.05,right:size.width * 0.05,top: 5, bottom: 5),
                      child:Row(
                        children: [
                          Container(
                            width: size.width * 0.44,
                            height: 45.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: Colors.grey[200],
                                    width:1
                                )
                              /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))*/
                            ),
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Center(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                            ),
                          ),
                          SizedBox(width:size.width * 0.02),
                          Container(
                            width: size.width * 0.44,
                            height: 45.0,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(30),
                              /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))*/
                            ),
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              onPressed: () {},
                              child: Center(
                                  child: Text(
                                    'Clear Cart',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),

                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  static AlignmentDirectional getAlignmentDirectional(String alignmentDirectional) {
    switch (alignmentDirectional) {
      case 'top_start':
        return AlignmentDirectional.topStart;
      case 'top_center':
        return AlignmentDirectional.topCenter;
      case 'top_end':
        return AlignmentDirectional.topEnd;
      case 'center_start':
        return AlignmentDirectional.centerStart;
      case 'center':
        return AlignmentDirectional.topCenter;
      case 'center_end':
        return AlignmentDirectional.centerEnd;
      case 'bottom_start':
        return AlignmentDirectional.bottomStart;
      case 'bottom_center':
        return AlignmentDirectional.bottomCenter;
      case 'bottom_end':
        return AlignmentDirectional.bottomEnd;
      default:
        return AlignmentDirectional.bottomEnd;
    }
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;

      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }
}

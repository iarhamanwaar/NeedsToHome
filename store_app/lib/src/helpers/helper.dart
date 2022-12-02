import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:firedart/auth/firebase_auth.dart';
import 'package:firedart/auth/token_store.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:global_configuration/global_configuration.dart';
import 'package:html/parser.dart';
import 'package:login_and_signup_web/src/elements/CircularLoadingWidget.dart';
import 'package:login_and_signup_web/src/repository/settings_repository.dart';
import 'desktop_con.dart';



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

  static pricePrint(amount) {
    // ignore: unrelated_type_equality_checks
    if (setting.value.currencyRight) {
      return '$amount ${setting.value.defaultCurrency}';

    } else {
      return '${setting.value.defaultCurrency} $amount';
    }
  }

  static getDecimalPointLimit() {
    if (setting.value.currencyDecimalDigits == 1) {
      return RegExp(r'^(\d+)?\.?\d{0,1}');
    } else if (setting.value.currencyDecimalDigits == 2) {
      return RegExp(r'^(\d+)?\.?\d{0,3}');
    } else if (setting.value.currencyDecimalDigits == 3) {
      return RegExp(r'^(\d+)?\.?\d{0,3}');
    }
  }

  static tConvert (time, min) {


    String h = (time % 12).toString();
    String ampm = (time < 12 || time == 24) ? "AM" : "PM";
    if(ampm=='PM' && h=='0'){
      h = '12';
    }
    return h+':'+min+' '+ ampm;
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



  static hideLoader(OverlayEntry loader) {
    Timer(Duration(milliseconds: 500), () {
      try {
        loader?.remove();
      } catch (e) {}
    });
  }

  static String limitString(String text, {int limit = 24, String hiddenText = "..."}) {
    return text.substring(0, min<int>(limit, text.length)) + (text.length > limit ? hiddenText : '');
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



  static String calculateTimeDifferenceBetween(
      {@required DateTime startDate, @required DateTime endDate}) {


    startDate = DateTime(startDate.year, startDate.month, startDate.day,startDate.hour,startDate.minute);
    endDate = DateTime(endDate.year, endDate.month, endDate.day,endDate.hour,endDate.minute);
    int days=(endDate.difference(startDate).inSeconds);



    return days.toString();
  }


  Color getColorFromHex(String hex) {
    if (hex.contains('#')) {
      return Color(int.parse(hex.replaceAll("#", "0xFF")));
    } else {
      return Color(int.parse("0xFF" + hex));
    }
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

  static fireBaseDeskTopCon() async {
    const apiKey = DesktopConnection.desktopKey;
    const projectId =  DesktopConnection.desktop_projectID;
    const email =  DesktopConnection.desktopConMail;
    const password =  DesktopConnection.desktopConPassword;
    FirebaseAuth.initialize(apiKey, VolatileStore());
    Firestore.initialize(projectId);
    var auth = FirebaseAuth.instance;
    auth.signInState.listen((state) => print("Signed ${state ? "in" : "out"}"));
    await auth.signIn(email, password);
  }
}

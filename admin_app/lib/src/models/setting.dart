import 'package:flutter/material.dart';
import '../helpers/custom_trace.dart';

class Setting {
  String appName = '';
  // ignore: non_constant_identifier_names
  int default_delivery_fees;
  String defaultCurrency;
  String distanceUnit;
  bool currencyRight = false;
  int currencyDecimalDigits = 2;
  // ignore: non_constant_identifier_names
  String razorpay_key;
  String googleMapsKey;
  ValueNotifier<Locale> mobileLanguage = new ValueNotifier(Locale('en', ''));
  String language = 'English';
  String appVersion;
  bool enableVersion = true;

  ValueNotifier<Brightness> brightness = new ValueNotifier(Brightness.light);

  Setting();

  Setting.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      appName = jsonMap['app_name'] ?? null;
      googleMapsKey = jsonMap['google_maps_key'] ?? null;
      mobileLanguage.value = Locale(jsonMap['mobile_language'] ?? "en", '');
      appVersion = jsonMap['app_version'] ?? '';
      distanceUnit = jsonMap['distance_unit'] ?? 'km';
      enableVersion = jsonMap['enable_version'] == null || jsonMap['enable_version'] == '0' ? false : true;
      default_delivery_fees = int.tryParse(jsonMap['default_delivery_fees'] ?? '0') ?? 0.0; //double.parse(jsonMap['default_tax'].toString());
      defaultCurrency = jsonMap['default_currency']!= null ? jsonMap['default_currency'] : '';
      currencyDecimalDigits = int.tryParse(jsonMap['default_currency_decimal_digits'] ?? '2') ?? 2;
      currencyRight = jsonMap['currency_right'] != null ? jsonMap['currency_right'] : false;
      razorpay_key = jsonMap['razorpay_key'];
    } catch (e) {
      razorpay_key = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["app_name"] = appName;
    map["default_delivery_fees"] = default_delivery_fees;
    map["default_currency"] = defaultCurrency;
    map["default_currency_decimal_digits"] = currencyDecimalDigits;
    map["currency_right"] = currencyRight;
    map["razorpay_key"] = razorpay_key;
    map["mobile_language"] = mobileLanguage.value.languageCode;
    return map;
  }
}

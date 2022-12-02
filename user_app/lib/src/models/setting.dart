import 'package:flutter/material.dart';

import '../helpers/custom_trace.dart';

class Setting {
  String appName = '';
  // ignore: non_constant_identifier_names
  int minimum_purchase;
  String defaultCurrency;
  String distanceUnit;
  bool currencyRight = false;
  int currencyDecimalDigits = 2;
  // ignore: non_constant_identifier_names
  String razorpay_key;
  String googleMapsKey;
  ValueNotifier<Locale> mobileLanguage = new ValueNotifier(Locale('en', ''));
  String appVersion;
  bool enableVersion = true;
  bool rayzorPay = true;
  bool upi = true;
  bool paypal = true;
  bool stripe = true;
  bool flutterWave = true;
  bool mpesa = false;
  bool codMode = true;
  String mpesaConsumerKey;
  String mpesaConsumerSecret;
  String mpesaPasskey;
  bool instanceDelivery;
  bool deliveryTips;
  // ignore: non_constant_identifier_names
  int cancel_timer = 6;
  double coverDistance;
  String noticeboard;
  String dailCode;
  String isoCode;
  String upiKey;
  String customerSupport;
  ValueNotifier<Brightness> brightness = new ValueNotifier(Brightness.light);
  String version = '2.5';
  String appLink;
  String featuredText;
  bool payStack = false;
  bool scheduleCancellation;
  String scheduleCancellationTimeLimit = '0';
  bool takeawayCancellation;
  String takeawayCancellationTimeLimit = '0';
  String handyTax;


  Setting();

  Setting.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      appName = jsonMap['app_name'] ?? null;
      googleMapsKey = jsonMap['google_maps_key'] ?? null;
      mobileLanguage.value = Locale(jsonMap['mobile_language'] ?? "en", '');
      appVersion = jsonMap['app_version'] ?? '';
      noticeboard = jsonMap['noticeboard'] ?? '';
      distanceUnit = jsonMap['distance_unit'] ?? 'km';
      enableVersion = jsonMap['enable_version'] == null || jsonMap['enable_version'] == '0' ? false : true;
      coverDistance = jsonMap['coverDistance'].toDouble() != null ? jsonMap['coverDistance'].toDouble()  : 0;
      instanceDelivery = jsonMap['instanceDelivery'];
      deliveryTips = jsonMap['deliveryTips'];
      minimum_purchase = int.tryParse(jsonMap['minimum_purchase'] ?? '0') ?? 0.0; //double.parse(jsonMap['default_tax'].toString());
      defaultCurrency = jsonMap['default_currency'] ?? '';
      currencyDecimalDigits = int.tryParse(jsonMap['default_currency_decimal_digits'] ?? '2') ?? 2;
      cancel_timer = int.tryParse(jsonMap['cancel_timer'] ?? '2') ?? 2;
      currencyRight = jsonMap['currency_right'] != null? jsonMap['currency_right'] : false;
      rayzorPay = jsonMap['rayzorPay'] == null || jsonMap['rayzorPay'] == false ? false : true;
      upi = jsonMap['upi'] == null || jsonMap['upi'] == false ? false : true;
      paypal = jsonMap['paypal'] == null || jsonMap['paypal'] == false ? false : true;
      stripe = jsonMap['stripe'] == null || jsonMap['stripe'] == false ? false : true;
      flutterWave = jsonMap['flutterWave'] == null || jsonMap['flutterWave'] == false ? false : true;
      razorpay_key = jsonMap['razorpay_key'];
      handyTax = jsonMap['handyTax'];
      dailCode = jsonMap['dailCode']!= null ?jsonMap['dailCode']: '';
      customerSupport = jsonMap['customerSupport']!= null ?jsonMap['customerSupport']: '';
      isoCode = jsonMap['isoCode']!= null ?jsonMap['isoCode']: '';
      upiKey = jsonMap['upiKey']!= null ?jsonMap['upiKey']: '';
      appLink = jsonMap['appLink']!= null ?jsonMap['appLink']: '';
      mpesaConsumerKey = jsonMap['mpesaConsumerKey'] != null ? jsonMap['mpesaConsumerKey'] : '';
      mpesaConsumerSecret = jsonMap['mpesaConsumerSecret'] != null ? jsonMap['mpesaConsumerSecret'] : '';
      mpesaPasskey = jsonMap['mpesaPasskey'] != null ? jsonMap['mpesaPasskey'] : '';
      mpesa = jsonMap['mpesa'] == null || jsonMap['mpesa'] == false ? false : true;
      payStack = jsonMap['payStack'] == null || jsonMap['payStack'] == false ? false : true;
      codMode = jsonMap['codMode'] == null || jsonMap['codMode'] == false ? false : true;
      featuredText = jsonMap['featuredText'] != null ? jsonMap['featuredText'] : '';
      scheduleCancellation = jsonMap['scheduleCancellation'] != null ? jsonMap['scheduleCancellation'] : false;
      scheduleCancellationTimeLimit = jsonMap['scheduleCancellationTimeLimit'] != null ? jsonMap['scheduleCancellationTimeLimit'] : false;
      takeawayCancellation = jsonMap['takeawayCancellation'] != null ? jsonMap['takeawayCancellation'] : false;
      takeawayCancellationTimeLimit = jsonMap['takeawayCancellationTimeLimit'] != null ? jsonMap['takeawayCancellationTimeLimit'] : false;

    } catch (e) {
      razorpay_key = '';
      print('setting error$e');
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["app_name"] = appName;
    map["minimum_purchase"] = minimum_purchase;
    map["instanceDelivery"] = instanceDelivery;
    map["default_currency"] = defaultCurrency;
    map["default_currency_decimal_digits"] = currencyDecimalDigits;
    map["currency_right"] = currencyRight;
    map["razorpay_key"] = razorpay_key;
    map["mobile_language"] = mobileLanguage.value.languageCode;
    map["deliveryTips"] = deliveryTips;
    map["coverDistance"] = coverDistance;
    map["scheduleCancellation"] = scheduleCancellation;
    map["scheduleCancellationTimeLimit"] = scheduleCancellationTimeLimit;
    map["takeawayCancellation"] = takeawayCancellation;
    map["takeawayCancellationTimeLimit"] = takeawayCancellationTimeLimit;
    return map;
  }
}

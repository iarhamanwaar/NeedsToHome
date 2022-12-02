import 'package:flutter/cupertino.dart';

class Setting {
  String appName = '';
  String phone;
  String defaultCurrency;
  String address;
  bool currencyRight = false;
  String googleMapsKey;
  ValueNotifier<Locale> mobileLanguage = new ValueNotifier(Locale('en', ''));
  String appVersion;
  bool enableVersion = true;
  double defaultTax;
  double commission;
  String distanceUnit;

  ValueNotifier<Brightness> brightness = new ValueNotifier(Brightness.light);

  Setting();

  Setting.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      appName = jsonMap['app_name'] ?? null;
      googleMapsKey = jsonMap['google_maps_key'] ?? null;
      mobileLanguage.value = Locale(jsonMap['mobile_language'] ?? "en", '');
      currencyRight = jsonMap['currency_right'] != null? jsonMap['currency_right'] : false;
      defaultCurrency = jsonMap['default_currency'] ?? '';
      appVersion = jsonMap['app_version'] ?? '';
      enableVersion = jsonMap['enable_version'] == null || jsonMap['enable_version'] == '0' ? false : true;
      phone = jsonMap['phone'];
      address = jsonMap['address'];
      distanceUnit = jsonMap['distance_unit'] ?? 'km';
      commission = double.tryParse(jsonMap['commission']) ?? 0.0;
      defaultTax = double.tryParse(jsonMap['default_tax']) ?? 0.0;


    } catch (e) {
      print(e);
    }
  }

//  ValueNotifier<Locale> initMobileLanguage(String defaultLanguage) {
//    SharedPreferences.getInstance().then((prefs) {
//      return new ValueNotifier(Locale(prefs.get('language') ?? defaultLanguage, ''));
//    });
//    return new ValueNotifier(Locale(defaultLanguage ?? "en", ''));
//  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["app_name"] = appName;
    map["phone"] = phone;
    map["default_currency"] = defaultCurrency;
    map["currency_right"] = currencyRight;
    map["address"] = address;
    map["default_tax"] = defaultTax;
    map["mobile_language"] = mobileLanguage.value.languageCode;
    return map;
  }
}

class AdminGeneral{
  String systemName;
  String systemTitle;
  String email;
  String address;
  String description;
  String phone;
  String api;
  String timeZone;
  String defaultLang;
  String dialCode;
  String countryCode;
  String customerSupport;
  String featuredText;





  // used for indicate if client logged in or not
  bool auth;

//  String role;

  AdminGeneral();

  AdminGeneral.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      systemName = jsonMap['systemName'] != null ? jsonMap['systemName'] : '';
      systemTitle = jsonMap['systemTitle'] != null ? jsonMap['systemTitle'] : '';
      email = jsonMap['email'] != null ? jsonMap['email'] : '';
      phone = jsonMap['phone'] != null ? jsonMap['phone'] : '';
      api = jsonMap['api'] != null ? jsonMap['api'] : '';
      description = jsonMap['description'] != null ? jsonMap['description'] : '';
      address = jsonMap['address'] != null ? jsonMap['address'] : '';
      timeZone = jsonMap['timeZone'] != null ? jsonMap['timeZone'] : '';
      defaultLang = jsonMap['defaultLang'] != null ? jsonMap['defaultLang'] : '';
      dialCode = jsonMap['dialCode'] != null ? jsonMap['dialCode'] : '';
      countryCode = jsonMap['countryCode'] != null ? jsonMap['countryCode'] : '';
      customerSupport = jsonMap['customerSupport'] != null ? jsonMap['customerSupport'] : '';
      featuredText = jsonMap['featuredText'] != null ? jsonMap['featuredText'] : '';

    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["systemName"] = systemName;
    map["systemTitle"] = systemTitle;
    map["email"] = email;
    map["phone"] = phone;
    map["api"] = api;
    map["address"] = address;
    map["description"] = description;
    map["timeZone"] = timeZone;
    map["defaultLang"] = defaultLang;
    map["countryCode"] = countryCode;
    map["dialCode"] = dialCode;
    map["countryCode"] = countryCode;
    map["customerSupport"] = customerSupport;
    map["featuredText"] = featuredText;

    return map;
  }



}
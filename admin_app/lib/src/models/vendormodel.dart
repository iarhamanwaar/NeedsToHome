import '../helpers/custom_trace.dart';

class Vendor {
  String shopId;
  String shopName;
  String subtitle;
  String locationMark;
  String ratingNum;
  String ratingTotal;
  String distance;
  String logo;
  String cover;
  String phone;
  bool openStatus;
  String longitude;
  String latitude;
  String shopType;
  String focusType;
  String marketKey;
  String marketValue;
  String address;
  bool takeaway;
  bool schedule;
  bool 	instant;


  Vendor();

  Vendor.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      shopId = jsonMap['shopId'];
      shopName = jsonMap['shopName'];
      subtitle = jsonMap['subtitle'];
      locationMark = jsonMap['locationMark'];
      ratingNum = jsonMap['ratingNum'];
      ratingTotal = jsonMap['ratingTotal'];
      distance = jsonMap['distance'];
      address = jsonMap['address'];
      logo = jsonMap['logo'];
      cover = jsonMap['cover'];
      phone = jsonMap['phone'];
      openStatus = jsonMap['openStatus'];
      longitude = jsonMap['longitude'];
      latitude = jsonMap['latitude'];
      shopType = jsonMap['shopType'];
      focusType = jsonMap['focusType'];
      marketValue = jsonMap['marketValue'] != null ? jsonMap['marketValue'] :  '';
      marketKey = jsonMap['marketKey'] != null ? jsonMap['marketKey'] :  '';
      takeaway = jsonMap['takeaway'] != null ? jsonMap['takeaway'] :  false;
      schedule = jsonMap['schedule'] != null ? jsonMap['schedule'] :  false;
      instant = jsonMap['instant'] != null ? jsonMap['instant'] :  false;

    } catch (e) {
      shopId = '';
      shopName = '';
      subtitle = '';
      locationMark = '';
      ratingNum = '';
      ratingTotal = '';
      distance = '';
      logo = '';
      cover = '';
      openStatus = false;
      longitude = '';
      latitude = '';
      focusType = '';
      shopType = '';
      marketValue = '';
      marketKey = '';
      takeaway = false;
      schedule = false;
      instant = false;
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["shopId"] = shopId;
    map["shopName"] = shopName;
    map["subtitle"] = subtitle;
    map["ratingNum"] = ratingNum;
    map["ratingTotal"] = ratingTotal;
    map["distance"] = distance;
    map["logo"] = logo;
    map["cover"] = cover;
    map["openStatus"] = openStatus;
    map["longitude"] = longitude;
    map["latitude"] = latitude;
    map["latitude"] = latitude;
    map["focusType"] = focusType;
    map["shopType"] = shopType;
    map["instant"] = instant;
    map["schedule"] = schedule;
    map["takeaway"] = takeaway;
    map["address"] = address;
    map["phone"] = phone;


    return map;
  }
}

import '../helpers/custom_trace.dart';
import 'holidays.dart';

class Vendor {
  String shopId;
  String shopName;
  String subtitle;
  String locationMark;
  String ratingNum;
  String ratingTotal;
  String distance;
  bool bestSeller;
  String logo;
  String cover;
  bool openStatus;
  String longitude;
  String latitude;
  String shopType;
  String focusType;
  String marketKey;
  String marketValue;
  bool takeaway;
  bool schedule;
  bool 	instant;
  String openingTime;
  String closingTime;
  HolidaysModel holidays = new HolidaysModel();
  String handoverTime;


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
      logo = jsonMap['logo'];
      cover = jsonMap['cover'];
      openStatus = jsonMap['openStatus'];
      longitude = jsonMap['longitude'];
      latitude = jsonMap['latitude'];
      shopType = jsonMap['shopType'];
      focusType = jsonMap['focusType'];
      handoverTime = jsonMap['handoverTime']!= null ? jsonMap['handoverTime'] :  '0';
      marketValue = jsonMap['marketValue'] != null ? jsonMap['marketValue'] :  '';
      marketKey = jsonMap['marketKey'] != null ? jsonMap['marketKey'] :  '';
      takeaway = jsonMap['takeaway'] != null ? jsonMap['takeaway'] :  false;
      schedule = jsonMap['schedule'] != null ? jsonMap['schedule'] :  false;
      instant = jsonMap['instant'] != null ? jsonMap['instant'] :  false;
      bestSeller = jsonMap['bestSeller'] != null ? jsonMap['bestSeller'] :  false;
      openingTime = jsonMap['openingTime'] != null ? jsonMap['openingTime'] :  '';
      closingTime = jsonMap['closingTime'] != null ? jsonMap['closingTime'] :  '';
      holidays=jsonMap['holidays'] != null ? HolidaysModel.fromJSON(
          jsonMap['holidays']) : HolidaysModel.fromJSON({});

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
      bestSeller = false;
      holidays=HolidaysModel.fromJSON({});
      handoverTime = '0';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["shopId"] = shopId;
    map["shopName"] = shopName;
    map["subtitle"] = subtitle;
    map["locationMark"] = locationMark;
    map["ratingNum"] = ratingNum;
    map["ratingTotal"] = ratingTotal;
    map["bestSeller"] = bestSeller;
    map["distance"] = distance;
    map["logo"] = logo;
    map["cover"] = cover;
    map["openStatus"] = openStatus;
    map["longitude"] = longitude;
    map["latitude"] = latitude;
    map["latitude"] = latitude;
    map["focusType"] = focusType;
    map["shopType"] = shopType;
    map["marketKey"] = marketKey;
    map["marketValue"] = marketValue;
    map["instant"] = instant;
    map["schedule"] = schedule;
    map["takeaway"] = takeaway;
    map["bestSeller"] = bestSeller;
    map["openingTime"] = openingTime;
    map["closingTime"] = closingTime;
    map["holidays"] = holidays.toMap();
    map["handoverTime"] = handoverTime;


    return map;
  }
}

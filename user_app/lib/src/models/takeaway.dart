import '../helpers/custom_trace.dart';

class TakeawayModel {
  String shopId;
  String shopName;
  String rating;
  double shopLatitude= 0.0;
  double shopLongitude = 0.0;
  String shopPhone;
  String shopAddress;
  String ratingNum;
  String status;
  String shopLogo;


  TakeawayModel();

  TakeawayModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      shopId = jsonMap['shopId'].toString();
      shopName = jsonMap['shopName']!= null ? jsonMap['shopName'] : '';
      shopLatitude = jsonMap['shopLatitude'].toDouble()!= null ? jsonMap['shopLatitude'].toDouble() :  0.0;
      shopLongitude = jsonMap['shopLongitude'].toDouble() != null ? jsonMap['shopLongitude'].toDouble() :  0.0;
      rating = jsonMap['rating']!= null ? jsonMap['rating'] : '';
      shopPhone = jsonMap['shopPhone']!= null ? jsonMap['shopPhone'] : '';
      shopAddress = jsonMap['shopAddress']!= null ? jsonMap['shopAddress'] : '';
      ratingNum = jsonMap['ratingNum']!= null ? jsonMap['ratingNum'] : '';
      status = jsonMap['status']!= null ? jsonMap['status'] : false;
      shopLogo = jsonMap['shopLogo']!= null ? jsonMap['shopLogo'] : '';

    } catch (e) {
      shopId = '';
      shopName = '';
      shopLatitude = 0.0;
      shopLongitude = 0.0;
      rating = '';
      shopPhone = '';
      shopAddress = '';
      ratingNum = '';
      status = '';
      shopLogo = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map<String, dynamic> toJson() => {
    "shopId": shopId,
    "shopName": shopName,
    "shopLatitude": shopLatitude,
    "shopLongitude": shopLongitude,
    "rating": rating,
    "shopPhone": shopPhone,
    "shopAddress": shopAddress,
    "ratingNum": ratingNum,
    "status": status,
    "shopLogo":shopLogo
  };

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["shopId"] = shopId;
    map["shopName"] = shopName;
    map["shopLatitude"] = shopLatitude;
    map["shopLongitude"] = shopLongitude;
    map["rating"] = rating;
    map["shopPhone"] = shopPhone;
    map["shopAddress"] = shopAddress;
    map["ratingNum"] = ratingNum;
    map["status"] = status;
    map["shopLogo"] = shopLogo;

    return map;
  }
}

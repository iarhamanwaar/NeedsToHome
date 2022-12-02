
import 'package:login_and_signup_web/src/models/generalmodel.dart';

class VendorModel {
  double rating;
  String coverImage;
  String image;
  General general;
  bool status;
  bool liveStatus;
  String shopName;
  int shopId;
  String planName;
  String planId;
  String profileStatus;
  String profileComplete;
  bool bestSeller;





  // used for indicate if client logged in or not
  bool auth;

//  String role;

  VendorModel();

  VendorModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      shopId = jsonMap['shopId'];
      rating = jsonMap['rating'].toDouble() ;
      general = jsonMap['general'] != null ? General.fromJSON(jsonMap['general']) : General.fromJSON({});
      image = jsonMap['image'] != null ? jsonMap['image'] : '';
      coverImage = jsonMap['coverImage'] != null ? jsonMap['coverImage'] : '';
      status = jsonMap['status'];
      liveStatus = jsonMap['liveStatus']!= null ? jsonMap['liveStatus'] : false;
      shopName = jsonMap['shopName']!= null ? jsonMap['shopName'] : '';
      planName = jsonMap['planName']!= null ? jsonMap['planName'] : '';
      planId = jsonMap['planId']!= null ? jsonMap['planId'] : '';
      profileStatus = jsonMap['profileStatus']!= null ? jsonMap['profileStatus'] : '';
      profileComplete = jsonMap['profileComplete']!= null ? jsonMap['profileComplete'] : '';
      bestSeller = jsonMap['bestSeller']!= null ? jsonMap['bestSeller'] : false;

    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["rating"] = rating;
    map["general"] = general;
    map["image"] = image;
    map["coverImage"] = coverImage;
    map["status"] = status;
    map["shopName"] = shopName;
    map["planId"] = planId;
    map["liveStatus"] = liveStatus;



    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}


import 'package:login_and_signup_web/src/models/delivery_setting.dart';
import 'package:login_and_signup_web/src/models/shopbasicinformation.dart';
import 'package:login_and_signup_web/src/models/shopsellerkyc.dart';
import 'package:login_and_signup_web/src/models/socialmedia_link.dart';

class ProfileResponse {
  ShopBasicInformation general;
  ShopSellerKyc bankDetails;
  SocialMediaLink socialMedialLink;
  DeliverySettingsModel deliverySettings;
  String ratingNum ='0';
  String ratingTotal = '0';
  int totalOrders =0;
  int totalProducts =0;



  ProfileResponse();

  ProfileResponse.fromJSON(Map<String, dynamic> jsonMap) {
    try{
      general =  jsonMap['general'] != null ? ShopBasicInformation.fromJSON(jsonMap['general']) : ShopBasicInformation.fromJSON({});
      bankDetails =  jsonMap['bankDetails'] != null ? ShopSellerKyc.fromJSON(jsonMap['bankDetails']) : ShopSellerKyc.fromJSON({});
      socialMedialLink =  jsonMap['socialMedialLink'] != null ? SocialMediaLink.fromJSON(jsonMap['socialMedialLink']) : SocialMediaLink.fromJSON({});
      deliverySettings =  jsonMap['deliverySettings'] != null ? DeliverySettingsModel.fromJSON(jsonMap['deliverySettings']) : DeliverySettingsModel.fromJSON({});
      ratingNum =  jsonMap['ratingNum'];
      ratingTotal =  jsonMap['ratingTotal'];
      totalOrders =  jsonMap['totalOrders'];
      totalProducts =  jsonMap['totalProducts'];



    } catch (e) {
      ratingNum ='';
      ratingTotal ='';
      totalOrders =0;
      totalProducts =0;
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["general"] = general.toMap();
    map["bankDetails"] =  bankDetails.toMap();
    map["deliverySettings"] =  deliverySettings.toMap();

    map["socialMedialLink"] =  socialMedialLink.toMap();



    return map;
  }


}


import 'package:login_and_signup_web/src/helpers/custom_trace.dart';
import 'package:login_and_signup_web/src/models/shopbasicinformation.dart';
import 'package:login_and_signup_web/src/models/vendor_sociallink.dart';
class VendorBusinessCard{
  ShopBasicInformation basicInformation;
  VendorSocialLinks socialLinks;
  String coverImage;
  String preview;


  VendorBusinessCard();

  VendorBusinessCard.fromJSON(Map<String,dynamic> jsonMap){
    try {
      basicInformation =
      jsonMap['basicInformation'] != null ? ShopBasicInformation.fromJSON(
          jsonMap['basicInformation']) : ShopBasicInformation.fromJSON({});

      socialLinks = jsonMap['socialLinks'] != null ? VendorSocialLinks.fromJSON(
          jsonMap['socialLinks']) : VendorSocialLinks.fromJSON({});
      coverImage =  jsonMap['coverImage'];
      preview =  jsonMap['preview'];

    } catch(e) {

      basicInformation = ShopBasicInformation.fromJSON({});

      socialLinks = VendorSocialLinks.fromJSON({});
      print(e);
      print(CustomTrace(StackTrace.current, message: e));
    }

  }

  Map toMap(){
    var map=new Map<String,dynamic>();
    map['basicInformation']=basicInformation.toMap();
    map['sellerKyc']=socialLinks.toMap();


    return map;
  }



}
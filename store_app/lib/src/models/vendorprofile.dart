

import 'package:login_and_signup_web/src/helpers/custom_trace.dart';
import 'package:login_and_signup_web/src/models/shopsellerkyc.dart';
import 'package:login_and_signup_web/src/models/shopsettings.dart';

import 'shopbankdetails.dart';
import 'shopbasicinformation.dart';


class VendorProfile{
  ShopBasicInformation basicInformation;

  ShopSellerKyc sellerKyc;
  ShopBankDetails bankDetails;
  ShopSettings settings;


  VendorProfile();

  VendorProfile.fromJson(Map<String,dynamic> jsonMap){
    try {
      basicInformation =
      jsonMap['basicInformation'] != null ? ShopBasicInformation.fromJSON(
          jsonMap['basicInformation']) : ShopBasicInformation.fromJSON({});

      sellerKyc = jsonMap['sellerKyc'] != null ? ShopSellerKyc.fromJSON(
          jsonMap['sellerKyc']) : ShopSellerKyc.fromJSON({});
      bankDetails = jsonMap['bankDetails'] != null ? ShopBankDetails.fromJSON(
          jsonMap['bankDetails']) : ShopBankDetails.fromJSON({});
      settings = jsonMap['settings'] != null
          ? ShopSettings.fromJSON(jsonMap['settings'])
          : ShopSettings.fromJSON({});
    } catch(e) {

      basicInformation = ShopBasicInformation.fromJSON({});

      sellerKyc = ShopSellerKyc.fromJSON({});
      bankDetails = ShopBankDetails.fromJSON({});
      settings = ShopSettings.fromJSON({});
      print(CustomTrace(StackTrace.current, message: e));
    }

  }

  Map toMap(){
    var map=new Map<String,dynamic>();
    map['basicInformation']=basicInformation.toMap();

    map['sellerKyc']=sellerKyc.toMap();
    map['bankDetails']=bankDetails.toMap();
    map['settings']=settings.toMap();
    return map;
  }

}
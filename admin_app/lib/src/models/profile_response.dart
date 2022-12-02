
import 'bank.dart';
import 'generalmodel.dart';

class ProfileResponse {
  General general;
  Bank bankDetails;
  double rating;
  int totalOrders =0;
  int totalProducts =0;
  String registerDate;
  String zoneId;
  String zoneName;
  String shopType;



  ProfileResponse();

  ProfileResponse.fromJSON(Map<String, dynamic> jsonMap) {
    try{
      general =  jsonMap['general'] != null ? General.fromJSON(jsonMap['general']) : General.fromJSON({});
      bankDetails =  jsonMap['bankDetails'] != null ? Bank.fromJSON(jsonMap['bankDetails']) : Bank.fromJSON({});
      rating =  jsonMap['rating'].toDouble();
      totalOrders =  jsonMap['totalOrders'];
      totalProducts =  jsonMap['totalProducts'];
      registerDate = jsonMap['registerDate'];
      zoneId = jsonMap['zoneId'];
      zoneName = jsonMap['zoneName'];
      shopType = jsonMap['shopType'];


    } catch (e) {
      rating =0;
      totalOrders =0;
      totalProducts =0;
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["general"] = General.fromJSON({});
    map["bankDetails"] = Bank.fromJSON({});





    return map;
  }


}

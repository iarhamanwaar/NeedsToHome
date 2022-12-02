import 'package:login_and_signup_web/src/helpers/custom_trace.dart';
import 'package:login_and_signup_web/src/models/holidays.dart';

class ShopBasicInformation{
  String id;
  String storeName;
  String email;
  String companyLegalName;
  String ownerName;
  String subtitle;
  String proofId;
  String mobile;
  String alterMobile;
  var logo;
  String pickupAddress;
  String pinCode;
  String city;
  String state;
  String landmark;
  String latitude;
  String longitude;
  var addressProofImage;
  String openingTime;
  String closingTime;
  String business;
  HolidaysModel holidays = new HolidaysModel();
  String zoneId;
  String handOverTime;

  ShopBasicInformation();

  ShopBasicInformation.fromJSON(Map<String,dynamic> jsonMap){
      try {
        id = jsonMap['id'];
        storeName = jsonMap['storeName'] != null ? jsonMap['storeName'] : '';
        email = jsonMap['email'] != null ? jsonMap['email'] : '';
        subtitle = jsonMap['subtitle'] != null ? jsonMap['subtitle'] : '';
        companyLegalName = jsonMap['companyLegalName'] != null ? jsonMap['companyLegalName'] : '';
        ownerName  = jsonMap['ownerName'] != null ? jsonMap['ownerName'] : '';
        proofId  = jsonMap['proofId'] != null ? jsonMap['proofId'] : '';
        mobile  = jsonMap['mobile'] != null ? jsonMap['mobile'] : '';
        alterMobile  = jsonMap['alterMobile'] != null ? jsonMap['alterMobile'] : '';
        pickupAddress=jsonMap['pickupAddress'] != null ? jsonMap['pickupAddress'] : '';
        pinCode=jsonMap['pinCode'] != null ? jsonMap['pinCode'] : '';
        landmark=jsonMap['landmark'] != null ? jsonMap['landmark'] : '';
        latitude=jsonMap['latitude'] != null ? jsonMap['latitude'] : '';
        longitude=jsonMap['longitude'] != null ? jsonMap['longitude'] : '';
        addressProofImage=jsonMap['addressProofImage'];
        openingTime=jsonMap['openingTime'] != null ? jsonMap['openingTime'] : '';
        closingTime=jsonMap['closingTime'] != null ? jsonMap['closingTime'] : '';
        business=jsonMap['business'] != null ? jsonMap['business'] : '';
        holidays=jsonMap['holidays'] != null ? HolidaysModel.fromJSON(
            jsonMap['holidays']) : HolidaysModel.fromJSON({});
        zoneId=jsonMap['zoneId'] != null ? jsonMap['zoneId'] : '';
        handOverTime=jsonMap['handOverTime'] != null ? jsonMap['handOverTime'] : '';
      } catch (e) {
        id = '';
        storeName = '';
        companyLegalName = '';
        ownerName = '';
        proofId= '';
        alterMobile = '';
        mobile = '';
        openingTime='';
        openingTime='';
        holidays=HolidaysModel.fromJSON({});
        business = '';

        print(CustomTrace(StackTrace.current, message: e));
      }
    }

  Map<String, dynamic> toJson() => {
    "id": id,
    "storeName": storeName,
    "subtitle": subtitle,
    "email": email,
    "ownerName": ownerName,
    "companyLegalName": companyLegalName,
    "mobile": mobile,
    "alterMobile" : alterMobile,
    "pickupAddress": pickupAddress,
    "pinCode": pinCode,
    "landmark": landmark,
    "latitude": latitude,
    "longitude": longitude,
    "openingTime": openingTime,
    "closingTime": closingTime,
    "holidays": holidays.toMap(),
    "business": business,
    'zoneId': zoneId,
    "handOverTime": handOverTime,
  };

  Map toMap() {
      var map = new Map<String, dynamic>();
      map["id"] = id;
      map["storeName"] = storeName;
      map["subtitle"] = subtitle;
      map["email"] = email;
      map["ownerName"] = ownerName;
      map["companyLegalName"] = companyLegalName;
      map["proofId"] = proofId;
      map["logo"] = logo;
      map["mobile"] = mobile;
      map["alterMobile"] = alterMobile;
      map['pickupAddress']=pickupAddress;
      map['pinCode']=pinCode;
      map['landmark']=landmark;
      map['latitude']=latitude;
      map['longitude']=longitude;
      map['addressProofImage']=addressProofImage;
      map['openingTime']=openingTime;
      map['closingTime']=closingTime;
      map['holidays']=holidays.toMap();
      map['business']=business;
      map['zoneId']=zoneId;
      map['handOverTime']=handOverTime;
      return map;
    }


  @override
  String toString() {
    var map = this.toMap();
    return map.toString();
  }




  }
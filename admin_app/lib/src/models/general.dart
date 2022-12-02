
class General {

  String id;
  String storeName;
  String companyLegalName;
  String ownerName;
  String subtitle;
  String proofId;
  String mobile;
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
  String holidays;
  String business;






  // used for indicate if client logged in or not
  bool auth;

//  String role;

  General();

  General.fromJSON(Map<String, dynamic> jsonMap) {
    try {

      id = jsonMap['id'];
      storeName = jsonMap['storeName'] != null ? jsonMap['storeName'] : '';
      subtitle = jsonMap['subtitle'] != null ? jsonMap['subtitle'] : '';
      companyLegalName = jsonMap['companyLegalName'] != null ? jsonMap['companyLegalName'] : '';
      ownerName  = jsonMap['ownerName'] != null ? jsonMap['ownerName'] : '';
      proofId  = jsonMap['proofId'] != null ? jsonMap['proofId'] : '';
      logo  = jsonMap['logo'];
      mobile  = jsonMap['mobile'] != null ? jsonMap['mobile'] : '';
      pickupAddress=jsonMap['pickupAddress'] != null ? jsonMap['pickupAddress'] : '';
      pinCode=jsonMap['pinCode'] != null ? jsonMap['pinCode'] : '';
      landmark=jsonMap['landmark'] != null ? jsonMap['landmark'] : '';
      latitude=jsonMap['latitude'] != null ? jsonMap['latitude'] : '';
      longitude=jsonMap['longitude'] != null ? jsonMap['longitude'] : '';
      addressProofImage=jsonMap['addressProofImage'];
      openingTime=jsonMap['openingTime'] != null ? jsonMap['openingTime'] : '';
      openingTime=jsonMap['closingTime'] != null ? jsonMap['closingTime'] : '';
      business=jsonMap['business'] != null ? jsonMap['business'] : '';
      holidays=jsonMap['holidays'];



    } catch (e) {
      id = '';
      storeName = '';
      companyLegalName = '';
      ownerName = '';
      proofId= '';
      logo= '';
      mobile = '';
      openingTime='';
      openingTime='';
      holidays='';
      business = '';
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();

    map["id"] = id;
    map["storeName"] = storeName;
    map["subtitle"] = subtitle;
    map["ownerName"] = ownerName;
    map["companyLegalName"] = companyLegalName;
    map["proofId"] = proofId;
    map["logo"] = logo;
    map["mobile"] = mobile;
    map['pickupAddress']=pickupAddress;
    map['pinCode']=pinCode;
    map['landmark']=landmark;
    map['latitude']=latitude;
    map['longitude']=longitude;
    map['addressProofImage']=addressProofImage;
    map['openingTime']=openingTime;
    map['closingTime']=closingTime;
    map['holidays']=holidays;
    map['business']=business;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}

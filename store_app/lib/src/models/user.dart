
class User {
  String id;
  String name;
  String email;
  String apiToken;
  String phone;
  String about;
  String image;
  String password;
  String shopName;
  String shopType;
  String coverImage;
  int shopTypeId;
  String registerDate;
  bool liveStatus;
  bool autoAssign;
  bool driverAllAccess;
  int focusID;
  String colorCode;
  String focusName;
  bool profileStatus;
  String planName;
  String expiredTime;
  String profileComplete;
  String productLimit;
  String address;
  int previousOrder = 0;
  String zoneId;
  String zoneName;

  // used for indicate if client logged in or not
  bool auth;

//  String role;

  User();

  User.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'] != null ? jsonMap['name'] : '';
      email = jsonMap['email'] != null ? jsonMap['email'] : '';
      phone = jsonMap['phone'] != null ? jsonMap['phone'] : '';
      apiToken = jsonMap['api_token'] != null ? jsonMap['api_token'] : '';
      password = jsonMap['password'] != null ? jsonMap['password'] : '';

      shopName = jsonMap['shopName'] != null ? jsonMap['shopName'] : '';
      shopType = jsonMap['shopType'] != null ? jsonMap['shopType'] : '';
      focusID = jsonMap['focusID'] != null ? jsonMap['focusID'] : '';
      colorCode = jsonMap['colorCode'] != null ? jsonMap['colorCode'] : '';
      image = jsonMap['image'] != null ? jsonMap['image'] : '';
      coverImage = jsonMap['coverImage'] != null ? jsonMap['coverImage'] : '';
      focusName = jsonMap['focusName'] != null ? jsonMap['focusName'] : '';
      shopTypeId = jsonMap['shopTypeId'];
      registerDate = jsonMap['registerDate'];
      liveStatus = jsonMap['liveStatus'];
      auth = jsonMap['auth'] != null ? jsonMap['auth'] : false;
      autoAssign = jsonMap['autoAssign'] != null ? jsonMap['autoAssign'] : false;
      driverAllAccess = jsonMap['driverAllAccess'] != null ? jsonMap['driverAllAccess'] : false;
      profileStatus = jsonMap['profileStatus'] != null ? jsonMap['profileStatus'] : false;
      profileComplete = jsonMap['profileComplete'] != null ? jsonMap['profileComplete'] : '';
      planName = jsonMap['planName'] != null ? jsonMap['planName'] : false;
      expiredTime = jsonMap['expiredTime'] != null ? jsonMap['expiredTime'] : false;
      productLimit = jsonMap['productLimit'] != null ? jsonMap['productLimit'] : false;
      address = jsonMap['address'] != null ? jsonMap['address'] : false;
      previousOrder = jsonMap['previousOrder'] != null ? jsonMap['previousOrder'] : 0;
      zoneId = jsonMap['zoneId'];
      zoneName = jsonMap['zoneName'];
    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;

    map["api_token"] = apiToken;

    map["password"] = password;


    map["phone"] = phone;
    map["shopName"] = shopName;

    map["image"] = image;
    map["shopType"] = shopType;
    map["coverImage"] = coverImage;
    map["shopTypeId"] = shopTypeId;
    map["registerDate"] = registerDate;
    map["liveStatus"] = liveStatus;
    map["focusName"] = focusName;
    map["focusID"] = focusID;
    map["colorCode"] = colorCode;
    map["autoAssign"] = autoAssign;
    map["driverAllAccess"] = driverAllAccess;
    map["profileStatus"] = profileStatus;
    map["profileComplete"] = profileComplete;
    map["planName"] = planName;
    map["expiredTime"] = expiredTime;
    map["productLimit"] = productLimit;
    map["address"] = address;
    map["previousOrder"] = previousOrder;
    map["zoneId"] = zoneId;
    map["zoneName"] = zoneName;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}

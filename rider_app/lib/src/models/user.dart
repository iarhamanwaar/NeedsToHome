class User {
  String id;
  String name;
  String email;
  String apiToken;
  String deviceToken;
  String phone;
  String image;
  String password;
  String gender;
  String address;
  double latitude;
  double longitude;
  bool liveStatus = false;
  String currentOrderID ;
  String walletAmount;
  bool firstLoad = false;
  bool block;
  bool approveState;

  // used for indicate if client logged in or not
  bool auth;

//  String role;

  User();

  User.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'] != null ? jsonMap['name'] : '';
      email = jsonMap['email'] != null ? jsonMap['email'] : '';
      gender = jsonMap['gender'] != null ? jsonMap['gender'] : '';
      phone = jsonMap['phone'];
      apiToken = jsonMap['api_token'];
      deviceToken = jsonMap['device_token'];
      password = jsonMap['password'];
      auth = jsonMap['auth'];
      liveStatus = jsonMap['liveStatus'];
      latitude = jsonMap['latitude'];
      longitude = jsonMap['longitude'];
      currentOrderID = jsonMap['currentOrderID'];
      block = jsonMap['block']!= null ? jsonMap['block'] : false;
      approveState = jsonMap['approveState']!= null ? jsonMap['approveState'] : false;
      try {
        phone = jsonMap['phone'];
      } catch (e) {
        phone = "";
      }
      try {
        address = jsonMap['address'];
      } catch (e) {
        address = "";
      }

      image = jsonMap['image'];
      walletAmount = jsonMap['walletAmount']!=null?jsonMap['walletAmount']:'';
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    map["liveStatus"] = liveStatus;
    map["gender"] = gender;
    map["api_token"] = apiToken;
    if (deviceToken != null) {
      map["device_token"] = deviceToken;
    }
    map["address"] = address;
    map["password"] = password;
    map["phone"] = phone;
    map["image"] = image;
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    map["walletAmount"] = walletAmount;
    map["firstLoad"] = firstLoad;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}

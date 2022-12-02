

class User {
  String id;
  String name;
  String email;
  String apiToken;
  String deviceToken;
  String phone;
  String about;
  String image;
  String password;
  String address;
  bool liveStatus;
  // used for indicate if client logged in or not
  bool auth;
  String zoneId;
  String walletAmount;
  bool firstLoad = false;


//  String role;

  User();

  User.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'] != null ? jsonMap['name'] : '';
      email = jsonMap['email'] != null ? jsonMap['email'] : '';
      phone = jsonMap['phone'];
      apiToken = jsonMap['api_token'];
      deviceToken = jsonMap['device_token'];
      password = jsonMap['password'];
      about = jsonMap['about'];
      auth = jsonMap['auth'];
      zoneId = jsonMap['zoneId'];
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
      liveStatus = jsonMap['liveStatus'];
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

    map["api_token"] = apiToken;
    if (deviceToken != null) {
      map["device_token"] = deviceToken;
    }
    map["address"] = address;
    map["about"] = about;
    map["password"] = password;
    map["phone"] = phone;
    map["image"] = image;
    map["liveStatus"] = liveStatus;
    map["zoneId"] = zoneId;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}

import 'address.dart';

class UserLocal {
  String id;
  String name;
  String email;
  String apiToken;
  String phone;
  String about;
  String image;
  String password;
  // ignore: deprecated_member_use
  List<Address> address = List<Address>();
  // ignore: non_constant_identifier_names
  String selected_address;
  double latitude;
  double longitude;
  String recommendation;
  bool firstLoad = false;
  int popupLocker = 0;
  List favoriteShop = [];
  String walletAmount;
  String loginVia;
  String zoneId;
  String description;
  String paymentType = 'COD';
  String paymentImage = 'assets/img/cod.png';
  String locationType;
  String filterId;


  // used for indicate if client logged in or not
  bool auth;

//  String role;

  UserLocal();

  UserLocal.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'] != null ? jsonMap['name'] : '';
      email = jsonMap['email'] != null ? jsonMap['email'] : '';
      phone = jsonMap['phone'];
      auth = jsonMap['auth'];
      apiToken = jsonMap['api_token'];
      password = jsonMap['password'];
      selected_address = jsonMap['selected_address'];
      address = jsonMap['address']
          != null ? List.from(jsonMap['address']).map((element) => Address.fromJSON(element)).toList() : [];

      image = jsonMap['image'];
      recommendation = jsonMap['recommendation'];
      latitude = jsonMap['latitude'].toDouble()!= null ? jsonMap['latitude'].toDouble() :  0.0;
      longitude = jsonMap['longitude'].toDouble() != null ? jsonMap['longitude'].toDouble() :  0.0;
      favoriteShop = jsonMap['favoriteShop'];
      walletAmount = jsonMap['walletAmount']!=null?jsonMap['walletAmount']:'';
      loginVia = jsonMap['loginVia'];
      zoneId = jsonMap['zoneId'];
      description = jsonMap['description'] != null ? jsonMap['description'] :  '';
    } catch (e) {
      favoriteShop =[];
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    map["locationType"] = locationType;
    map["api_token"] = apiToken;
    map["favoriteShop"] = favoriteShop;
    map["password"] = password;
    map["selected_address"] = selected_address;
    map["address"] = address.map((element) => element.toMap()).toList();
    map["phone"] = phone;
    map["auth"] = auth;
    map["media"] = image;
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    map["recommendation"] = recommendation;
    map["walletAmount"] = walletAmount;
    map["firstLoad"] = firstLoad;
    map["loginVia"] = loginVia;
    map["zoneId"] = zoneId;
    map["paymentType"] = paymentType;
    map["paymentImage"] = paymentImage;
    map["filterId"] = filterId;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}

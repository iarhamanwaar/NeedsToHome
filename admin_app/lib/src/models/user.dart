
class User {
  String id;
  String name;
  String email;
  String apiToken;
  String phone;
  String image;
  String password;
  String coverImage;
  String status;
  String address;
  bool driverAllAccess;
  bool autoAssign = false;



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
      coverImage = jsonMap['coverImage'] != null ? jsonMap['coverImage'] : '';
      image = jsonMap['image'] != null ? jsonMap['image'] : '';
      auth = jsonMap['auth'] != null ? jsonMap['auth'] : false;
      status = jsonMap['status'] != null ? jsonMap['status'] : '';
      address = jsonMap['address'] != null ? jsonMap['address'] : '';
      driverAllAccess = jsonMap['driverAllAccess'] != null ? jsonMap['driverAllAccess'] : '';
      autoAssign = jsonMap['autoAssign'] != null ? jsonMap['autoAssign'] : false;

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


    map["image"] = image;
    map["coverImage"] = coverImage;
    map["address"] = address;
    map["autoAssign"] = autoAssign;


    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}

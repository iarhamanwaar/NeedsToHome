
class DriverModel {
  String userName;
  String email;
  String date;
  String gender;
  int age;
  String id;
  String type;
  String image;
  String phone;
  String address;
  String mode;
  String storeId;
  String status;
  String liveStatus;
  // ignore: non_constant_identifier_names
  String 	last_name;
  bool block;



  // used for indicate if client logged in or not
  bool auth;

//  String role;

  DriverModel();

  DriverModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      userName = jsonMap['userName'] != null ? jsonMap['userName'] : '';
      email = jsonMap['email'] != null ? jsonMap['email'] : '';
      date = jsonMap['date'] != null ? jsonMap['date'] : '';
      gender = jsonMap['gender']!= null ? jsonMap['gender'] : '';
      id = jsonMap['id'] != null ? jsonMap['id'] : '';
      age = jsonMap['age'] != null ? jsonMap['age'] : '';
      type = jsonMap['type'] != null ? jsonMap['type'] : '';
      image = jsonMap['image'] != null ? jsonMap['image'] : '';
      phone = jsonMap['phone'] != null ? jsonMap['phone'] : '';
      address = jsonMap['address'] != null ? jsonMap['address'] : '';
      mode = jsonMap['mode'] != null ? jsonMap['mode'] : '';
      storeId = jsonMap['storeId'] != null ? jsonMap['storeId'] : '';
      status = jsonMap['status'] != null ? jsonMap['status'] : '';
      liveStatus = jsonMap['liveStatus'] != null ? jsonMap['liveStatus'] : '';
      last_name = jsonMap['last_name'] != null ? jsonMap['last_name'] : '';
      block = jsonMap['block'] != null ? jsonMap['block'] : '';

    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["userName"] = userName;
    map["email"] = email;
    map["date"] = date;
    map["id"] = id;
    map["image"] = image;
    map["phone"] = phone;
    map["gender"] = gender;
    map["age"] = age;
    map["type"] = type;
    map["mode"] = mode;
    map["storeId"] = storeId;
    map["status"] = status;
    map["liveStatus"] = liveStatus;



    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}

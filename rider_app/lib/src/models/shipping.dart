class Shipping {
  String id;
  String username;
  String phone;
  // ignore: non_constant_identifier_names
  String address_l1;
  // ignore: non_constant_identifier_names
  String address_l2;
  String city;
  String state;
  String pincode;
  bool isDefault = true;
  String userid;
  Shipping();

  Shipping.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      username = jsonMap['username'];
      phone = jsonMap['phone'];
      address_l1 = jsonMap['address_l1'];
      address_l2 = jsonMap['address_l2'];
      city = jsonMap['city'];
      state = jsonMap['state'];
      pincode = jsonMap['pincode'];
      isDefault = jsonMap['isDefault'];
      userid = jsonMap['userid'];
    } catch (e) {
      id = '';
      username = '';
      phone = '';
      address_l1 = '';
      address_l2 = '';
      city = '';
      state = '';
      pincode = '';
      isDefault = true;
      userid = '';
      print(e);
    }
  }

  // ignore: missing_return
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["username"] = username;
    map["phone"] = phone;
    map["address_l1"] = address_l1;
    map["address_l2"] = address_l2;
    map["city"] = city;
    map["state"] = state;
    map["pincode"] = pincode;
    map["isDefault"] = isDefault;
    map["userid"] = userid;
  }
}

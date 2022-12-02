import '../helpers/custom_trace.dart';

class Registermodel {
  String name;
  String emailId;
  String phone;
  String password;
  String shopTypeId;

  Registermodel();

  Registermodel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      name = jsonMap['name'];
      emailId = jsonMap['emailId'];
      phone = jsonMap['phone'];
      password = jsonMap['password'];
      shopTypeId = jsonMap['shopTypeId'];
    } catch (e) {
      name = '';
      emailId = '';
      phone = '';
      password = '';
      shopTypeId = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["emailId"] = emailId;
    map["phone"] = phone;
    map["password"] = password;
    map["shopTypeId"] = shopTypeId;
    return map;
  }
}

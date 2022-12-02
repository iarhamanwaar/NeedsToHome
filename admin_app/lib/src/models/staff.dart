import 'package:login_and_signup_web/src/helpers/custom_trace.dart';

class StaffModel{
  String id;
  String name;
  String phone;
  String address;
  String email;
  String password;
  String role;
  var uploadImage;

  StaffModel();
  StaffModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'];
      name = jsonMap['name'];
      phone = jsonMap['phone'];
      address  = jsonMap['address'];
      email  = jsonMap['email'];
      password  = jsonMap['password'];
      role  = jsonMap['role'];
      uploadImage = jsonMap['uploadImage'];
    } catch (e) {
      id = '';
      name = '';
      phone = '';
      address = '';
      password= '';
      role = '';
      email= '';

      uploadImage = '';

      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["phone"] = phone;
    map["email"] = email;
    map["address"] = address;
    map["password"] = password;
    map["role"] = role;
    map["uploadImage"] = uploadImage;

    return map;
  }
}
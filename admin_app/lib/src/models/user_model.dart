
class UserModel {
  String userName;
  String email;
  String date;
  double totalSale;
  int id;
  var image;
  String password;
  String phone;
  String status;
  String address;


  // used for indicate if client logged in or not
  bool auth;

//  String role;

  UserModel();

  UserModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      userName = jsonMap['userName'] != null ? jsonMap['userName'] : '';
      email = jsonMap['email'] != null ? jsonMap['email'] : '';
      date = jsonMap['date'] != null ? jsonMap['date'] : '';
      totalSale = jsonMap['totalSale'].toDouble();
      id = jsonMap['id'] != null ? jsonMap['id'] : '';
      image = jsonMap['image'] != null ? jsonMap['image'] : '';
      phone = jsonMap['phone'] != null ? jsonMap['phone'] : '';
      status = jsonMap['status'] != null ? jsonMap['status'] : '';
      password = jsonMap['password'] != null ? jsonMap['password'] : '';
      address = jsonMap['address'] != null ? jsonMap['address'] : '';
    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["userName"] = userName;
    map["email"] = email;
    map["date"] = date;
    map["totalSale"] = totalSale;
    map["id"] = id;
    map["image"] = image;
    map["phone"] = phone;



    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}


class ProfileModel {

  String name;
  String shopName;
  String subTitle;
  String email;
  String password;
  String alternativeMobile;
  String phone;
  String startedYear;
  String description;
  String bankName;
  String accountNo;
  String swiftCode;




  // used for indicate if client logged in or not
  bool auth;

//  String role;

  ProfileModel();

  ProfileModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {

      name = jsonMap['name'] != null ? jsonMap['name'] : '';
      shopName = jsonMap['shopName'] != null ? jsonMap['shopName'] : '';
      subTitle = jsonMap['subTitle'] != null ? jsonMap['subTitle'] : '';
      email = jsonMap['email'] != null ? jsonMap['email'] : '';
      phone = jsonMap['phone'];
      alternativeMobile = jsonMap['alternativeMobile'];
      startedYear = jsonMap['startedYear'];
      description = jsonMap['description'];
      password = jsonMap['password'];
      bankName = jsonMap['bankName'] != null ? jsonMap['bankName'] : '';
      accountNo = jsonMap['accountNo'] != null ? jsonMap['accountNo'] : '';
      swiftCode = jsonMap['swiftCode'] != null ? jsonMap['swiftCode'] : '';



    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();

    map["email"] = email;
    map["name"] = name;
    map['shopName'] = shopName;
    map["subTitle"] = subTitle;
    map["alternativeMobile"] = alternativeMobile;
    map["description"] = description;
    map["startedYear"] = startedYear;
    map["password"] = password;
    map["phone"] = phone;
    map["bankName"] = bankName;
    map["accountNo"] = accountNo;
    map["swiftCode"] = swiftCode;


    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}

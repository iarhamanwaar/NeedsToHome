

class RegisterModel {
  String firstname;
  String lastname;
  String dob;
  String gender;
  String address1;
  String address2;
  String city;
  String state;
  String zipcode;
  double latitude;
  double longitude;
  String email;
  int mobile;
  String password;
  String profile;
  String licenseno;
  String aboutyou;
  String drivingMode;
  String storeId;
  String zoneId;
  String model;
  String color;
  String vehicleType;
  String proofType ='National Id';
  String bankName;
  String accountName;
  String accountNo;
  String bankCode;


  RegisterModel();

  RegisterModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      firstname = jsonMap['firstname'];
      lastname = jsonMap['lastname'] != null ? jsonMap['lastname'].toString() : null;
      dob = jsonMap['dob'];
      drivingMode = jsonMap['drivingMode'];
      storeId = jsonMap['storeId'];
      gender = jsonMap['gender'] != null ? jsonMap['gender'] : null;
      address1 = jsonMap['address1'] != null ? jsonMap['address1'] : null;
      address2 = jsonMap['address2'];
      city = jsonMap['city'];
      state = jsonMap['state'];
      zipcode = jsonMap['zipcode'];
      latitude = jsonMap['latitude'];
      longitude = jsonMap['longtitude'];
      email = jsonMap['email'];
      mobile = jsonMap['mobile'];
      password = jsonMap['password'];
      profile = jsonMap['profile'];
      licenseno = jsonMap['licenseno'];
      aboutyou = jsonMap['aboutyou'];
      zoneId = jsonMap['zoneId'];
      color = jsonMap['color'];
      model = jsonMap['model'];
      vehicleType = jsonMap['vehicleType'];


    } catch (e) {
      firstname = '';
      lastname = '';
      drivingMode = '';
      storeId = '';
      dob = '';
      gender = '';
      address1 = '';
      address2 = '';
      city = '';
      state = '';
      zipcode = '';
      latitude = 0.0;
      longitude = 0.0;
      email = '';
      mobile = 0;
      password = '';
      profile = '';
      licenseno = '';
      aboutyou = '';
      zoneId = '';

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["firstname"] = firstname;
    map["lastname"] = lastname;
    map["dob"] = dob;
    map["gender"] = gender;
    map["address1"] = address1;
    map["address2"] = address2;
    map["city"] = city;
    map["state"] = state;
    map["zipcode"] = zipcode;
    map["latitude"] = latitude;
    map["longtitude"] = longitude;
    map["email"] = email;
    map["mobile"] = mobile;
    map["password"] = password;
    map["profile"] = profile;
    map["licenseno"] = licenseno;
    map["drivingMode"] = drivingMode;
    map["storeId"] = storeId;
    map["zoneId"] = zoneId;
    map["model"] = model;
    map["color"] = color;
    map["vehicleType"] = vehicleType;
    map["proofType"] = proofType;
    map["bankName"] = bankName;
    map["accountName"] = accountName;
    map["accountNo"] = accountNo;
    map["bankCode"] = bankCode;

    return map;
  }
}

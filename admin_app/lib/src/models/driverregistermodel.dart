class DriverRegistermodel {
  String id;
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
  double longtitude;
  String email;
  String mobile;
  String password;
  String profile;
  var image;
  String zone;
  String licenseno;
  String aboutyou;
  String drivingMode;
  String storeId;
  String status;
  String liveStatus;
  String date;
  String age;
  bool block;
  String proofType;
  String accountHolder;
  String accountNo;
  String bankName;
  String bankCode;
  String proof;





  DriverRegistermodel();

  DriverRegistermodel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      firstname = jsonMap['firstname'];
      id = jsonMap['id'];
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
      longtitude = jsonMap['longtitude'];
      zone = jsonMap['zone'];
      email = jsonMap['email'];
      mobile = jsonMap['mobile'];
      password = jsonMap['password'];
      profile = jsonMap['profile'];
      licenseno = jsonMap['licenseno'];
      aboutyou = jsonMap['aboutyou'];
      image = jsonMap['image'] != null ? jsonMap['image'] : '';
      status=jsonMap['status'];
      date=jsonMap['date'];
      age=jsonMap['age'];
      liveStatus = jsonMap['livestatus'] != null ? jsonMap['livestatus'] : '';
      block = jsonMap['block'] != null ? jsonMap['block'] : '';
      proofType = jsonMap['proofType'] != null ? jsonMap['proofType'] : '';
      accountHolder = jsonMap['accountHolder'] != null ? jsonMap['accountHolder'] : '';
      accountNo = jsonMap['accountNo'] != null ? jsonMap['accountNo'] : '';
      bankName = jsonMap['bankName'] != null ? jsonMap['bankName'] : '';
      bankCode = jsonMap['bankCode'] != null ? jsonMap['bankCode'] : '';
      proof = jsonMap['proof'] != null ? jsonMap['proof'] : '';



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
      longtitude = 0.0;
      email = '';
      mobile = '';
      password = '';
      profile = '';
      licenseno = '';
      aboutyou = '';

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['id']=id;
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
    map["longtitude"] = longtitude;
    map["email"] = email;
    map["mobile"] = mobile;
    map["password"] = password;
    map["profile"] = profile;
    map["licenseno"] = licenseno;
    map["drivingMode"] = drivingMode;
    map["storeId"] = storeId;
    map["zone"] = zone;
    map['image']=image;
    return map;
  }
}
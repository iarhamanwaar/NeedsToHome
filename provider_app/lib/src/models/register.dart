import 'category.dart';

class Registermodel {
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
  int mobile;
  String password;
  String profile;
  String workexp;
  String aboutyou;
  List<Category> category = <Category>[];
  String zoneId;
  String proofType ='National Id';
  String bankName;
  String accountName;
  String accountNo;
  String bankCode;


  Registermodel();

  Registermodel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      firstname = jsonMap['firstname'];
      lastname = jsonMap['lastname'] != null ? jsonMap['lastname'].toString() : null;
      dob = jsonMap['dob'];
      gender = jsonMap['gender'] != null ? jsonMap['gender'] : null;
      address1 = jsonMap['address1'] != null ? jsonMap['address1'] : null;
      address2 = jsonMap['address2'];
      city = jsonMap['city'];
      state = jsonMap['state'];
      zipcode = jsonMap['zipcode'];
      latitude = jsonMap['latitude'];
      longtitude = jsonMap['longtitude'];
      email = jsonMap['email'];
      mobile = jsonMap['mobile'];
      password = jsonMap['password'];
      profile = jsonMap['profile'];
      workexp = jsonMap['workexp'];
      aboutyou = jsonMap['aboutyou'];
      zoneId = jsonMap['zoneId'];

      category = jsonMap['category'] != null ? List.from(jsonMap['category']).map((element) => Category.fromJSON(element)).toList() : [];
    } catch (e) {
      firstname = '';
      lastname = '';
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
      mobile = 0;
      password = '';
      profile = '';
      workexp = '';
      aboutyou = '';
      category = [];
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
    map["longtitude"] = longtitude;
    map["email"] = email;
    map["mobile"] = mobile;
    map["password"] = password;
    map["profile"] = profile;
    map["workexp"] = workexp;
    map["aboutyou"] = aboutyou;
    map["zoneId"] = zoneId;
    map['category'] = category?.map((element) => element.toMap())?.toList();
    map["bankName"] = bankName;
    map["accountName"] = accountName;
    map["accountNo"] = accountNo;
    map["bankCode"] = bankCode;
    map["proofType"] = proofType;

    return map;
  }
}

class ProviderModel{
  String id;
  String username;
  String lastname;
  String dob;
  String gender;
  String email;
  String password;
  String mobile;
  String address1;
  String address2;
  String city;
  String state;
  String zipcode;
  String about;
  String workingexperience;
  String registerdate;
  bool status;
  var uploadImage;
  String deviceid;
  //String approvedate;
  String latitude;
  String longitude;
  String liveStatus;



  // used for indicate if client logged in or not
  bool auth;

//  String role;

  ProviderModel();

  ProviderModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : '';
      username = jsonMap['username'] != null ? jsonMap['username'] : '';
      dob = jsonMap['dob'] != null ? jsonMap['dob'] : '';
      gender = jsonMap['gender']!= null ? jsonMap['gender'] : '';
      email = jsonMap['email'] != null ? jsonMap['email'] : '';
      mobile = jsonMap['mobile'] != null ? jsonMap['mobile'] : '';
      address1 = jsonMap['address1'] != null ? jsonMap['address1'] : '';
      address2 = jsonMap['address2'] != null ? jsonMap['address2'] : '';
      zipcode = jsonMap['zipcode'] != null ? jsonMap['zipcode'] : '';
      about = jsonMap['aboutyou'] != null ? jsonMap['aboutyou'] : '';
      workingexperience = jsonMap['work_exp'] != null ? jsonMap['work_exp'] : '';
      registerdate = jsonMap['date'] != null ? jsonMap['date'] : '';
      status = jsonMap['status'] != null ? jsonMap['status'] : '';
      //approvedate = jsonMap['about'] != null ? jsonMap['approvedate'] : '';
      latitude = jsonMap['latitude'] != null ? jsonMap['latitude'] : '';
      longitude = jsonMap['longitude'] != null ? jsonMap['longitude'] : '';
      liveStatus = jsonMap['lifestatus'] != null ? jsonMap['lifestatus'] : '';
      deviceid = jsonMap['device_id'] != null ? jsonMap['device_id'] : '';
      uploadImage = jsonMap['image'];


    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["dob"] =  dob;
    map["gender"] = gender;
    map["email"] = email;
    map["mobile"] = mobile;
    map["address1"] = address1;
    map["address2"] = address2;
    map["zipcode"] =  zipcode;
    map["aboutyou"] = about;
    map["work_exp"] = workingexperience;
    map["date"] = registerdate;
    map["status"] = status;
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    map["device_id"] = deviceid;
    map["livestatus"] = liveStatus;
    map["image"] = uploadImage;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }

}
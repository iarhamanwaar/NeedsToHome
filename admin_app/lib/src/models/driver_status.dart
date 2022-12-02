
class DriverStatus {
  String driverId;
  String driverName;
  String phone;
  String latitude;
  String longitude;



  DriverStatus();

  DriverStatus.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      driverId = jsonMap['driverId'] != null ? jsonMap['driverId'] : '';
      driverName = jsonMap['driverName'] != null ? jsonMap['driverName'] : '';
      phone = jsonMap['phone'] != null ? jsonMap['phone'] : '';
      latitude = jsonMap['latitude'] != null ? jsonMap['latitude'] : '';
      longitude = jsonMap['longitude'] != null ? jsonMap['longitude'] : '';


    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["driverId"] = driverId;
    map["driverName"] = driverName;
    map["phone"] = phone;
    map["latitude"] = latitude;
    map["longitude"] = longitude;

    return map;
  }


}

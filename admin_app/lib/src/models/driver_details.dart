
class DriverDetailsModel {
  String driverName;
  String phone;
  String status;
  String orderDate;
  String id;



  // used for indicate if client logged in or not
  bool auth;

//  String role;

  DriverDetailsModel();

  DriverDetailsModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      driverName = jsonMap['driverName'] != null ? jsonMap['driverName'] : '';
      phone = jsonMap['phone'] != null ? jsonMap['phone'] : '';
      status = jsonMap['status'] != null ? jsonMap['status'] : '';
      orderDate = jsonMap['orderDate'] != null ? jsonMap['orderDate'] : '';
      id = jsonMap['id'] != null ? jsonMap['id'] : '';


    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["driverName"] = driverName;
    map["phone"] = phone;
    map["status"] = status;
    map["orderDate"] = orderDate;
    map["id"] = id;


    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}

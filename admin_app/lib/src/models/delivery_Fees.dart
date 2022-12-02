class DeliveryFees{

  String name;
  String fromRange;
  String toRange;
  String fees;
  int id;



  // used for indicate if client logged in or not
  bool auth;

//  String role;

  DeliveryFees();

  DeliveryFees.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      name = jsonMap['name'] != null ? jsonMap['name'] : '';
      fromRange = jsonMap['fromRange'] != null ? jsonMap['fromRange'] : '';
      toRange = jsonMap['toRange'] != null ? jsonMap['toRange'] : '';
      fees = jsonMap['fees'] != null ? jsonMap['fees'] : '';
      id = jsonMap['id'] != null ? jsonMap['id'] : '';


    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["fromRange"] = fromRange;
    map["toRange"] = toRange;
    map["fees"] = fees;
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
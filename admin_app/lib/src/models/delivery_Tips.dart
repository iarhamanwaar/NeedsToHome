class DeliveryTipsModel{

  String name;
  String tips;
  int id;



  // used for indicate if client logged in or not
  bool auth;

//  String role;

  DeliveryTipsModel();

  DeliveryTipsModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      name = jsonMap['name'] != null ? jsonMap['name'] : '';
      tips = jsonMap['tips'] != null ? jsonMap['tips'] : '';
      id = jsonMap['id'] != null ? jsonMap['id'] : '';


    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["tips"] = tips;
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

class DropDownModel {
  String id;
  String name;




  // used for indicate if client logged in or not
  bool auth;

//  String role;

  DropDownModel();

  DropDownModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'] : '';
      name = jsonMap['name'] != null ? jsonMap['name'] : '';


    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;




    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}

class Addon2Model{

  String name;
  String price;
  String foodType;
  String productId;
  String type;
  String id;




  // used for indicate if client logged in or not
  bool auth;

//  String role;

  Addon2Model();

  Addon2Model.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      name = jsonMap['name'] != null ? jsonMap['name'] : '';
      productId = jsonMap['productId'] != null ? jsonMap['productId'] : '';
      price = jsonMap['price']!= null ? jsonMap['price'] : 0;
      foodType = jsonMap['foodType'] != null ? jsonMap['foodType'] : '';
      type = jsonMap['type'] != null ? jsonMap['type'] : 0;
      id = jsonMap['id'] != null ? jsonMap['id'] : 0;


    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["productId"] =  productId;
    map["foodType"] = foodType;
    map["type"] = type;
    map["price"] = price;







    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }

}
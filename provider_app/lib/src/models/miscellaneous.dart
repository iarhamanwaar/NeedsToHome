
class Miscellaneous {
  String name;
  double price;

  Miscellaneous();

  Miscellaneous.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      name = jsonMap['name'].toString();
      price = jsonMap['price'];
    } catch (e) {
      name = '';
      price = 0;
      print(e);
    }
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["price"] = price;
    return map;
  }
}


class Currency{
  String id;
  String currencyName;
  String currencySymbol;
  String country;
  var uploadImage;




  // used for indicate if client logged in or not
  bool auth;

//  String role;

  Currency();

  Currency.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'] : '';
      currencyName = jsonMap['currencyName'] != null ? jsonMap['currencyName'] : '';
      currencySymbol = jsonMap['currencySymbol'] != null ? jsonMap['currencySymbol'] : '';
      country = jsonMap['country'] != null ? jsonMap['country'] : '';
      uploadImage = jsonMap['uploadImage'] != null ? jsonMap['uploadImage'] : '';

    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["currencyName"] = currencyName;
    map["currencySymbol"] = currencySymbol;
    map["country"] = country;





    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }

}

class Servicemodel{
  // ignore: non_constant_identifier_names
  String services_name;
  String amount;
  String type;
  // ignore: non_constant_identifier_names
  String servicesid;

  Servicemodel();

  Servicemodel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      services_name = jsonMap['services_name'];
      amount = jsonMap['amount'];
      servicesid = jsonMap['servicesid'];
      type = jsonMap['type'];
    } catch (e) {
      services_name = '';
      amount = '';
      servicesid = '';
      type = '';
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["services_name"] = services_name;
    map["amount"] = amount;
    map["servicesid"] = servicesid;
    map["type"] = type;
    return map;
  }
}
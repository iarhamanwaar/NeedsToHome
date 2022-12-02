

import '../helpers/custom_trace.dart';

class CashOnHandModel {
  String id;
  String name;
  String amount;

  CashOnHandModel();

  CashOnHandModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['Id'] != null ? jsonMap['Id'] : '0';
      name = jsonMap['name'] != null ? jsonMap['name'] : '';
      amount = jsonMap['amount'] != null ? jsonMap['amount'] : '';
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["vendorId"] = id;
    map["name"] = name;
    map["amount"] = amount;

    return map;
  }


}

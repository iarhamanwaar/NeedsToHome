

import '../helpers/custom_trace.dart';

class ShopRatingModel {
  String rating;
  String taste;
  String packing;
  String id;
  String message;
  String portion;
  String buyerId;
  String vendorId;
  String date;
  bool status;

  ShopRatingModel();

  ShopRatingModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      rating = jsonMap['rating'].toString();
      taste = jsonMap['taste'].toString();
      packing = jsonMap['packing'].toString();
      id  = jsonMap['id'].toString();
      message  = jsonMap['message'].toString();
      portion = jsonMap['portion'].toString();
      buyerId = jsonMap['buyerId'].toString();
      vendorId = jsonMap['vendorId'].toString();
      date = jsonMap['date'];
      status = jsonMap['status'];
    } catch (e) {
      rating = '';
      taste = '';
      packing = '';
      id = '';
      portion = '';
      message = '';
      vendorId = '';
      status = false;
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["rating"] = rating;
    map["taste"] = taste;
    map["packing"] = packing;
    map["id"] = id;
    map["portion"] = portion;
    map["redirectType"] = message;
    map["buyerId"] = buyerId;
    map["vendorId"] = vendorId;
    map["date"] = date;

    return map;
  }


}

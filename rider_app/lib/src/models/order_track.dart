import 'package:products_deliveryboy/src/models/status_manager.dart';

import '../helpers/custom_trace.dart';
import 'address.dart';

class OrderTrack {
  String id;
  String status;
  Address address;
  String dateTime;
  StatusManager statusManager;

  OrderTrack();

  OrderTrack.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      status = jsonMap['status'];
      address = jsonMap['address'] != null && (jsonMap['address'] as List).length > 0 ? Address.fromJSON(jsonMap['address'][0]) : new Address();
      statusManager = jsonMap['statusManager'] != null && (jsonMap['statusManager'] as List).length > 0
          ? StatusManager.fromJSON(jsonMap['statusManager'][0])
          : new StatusManager();
      dateTime = jsonMap['dateTime'];
    } catch (e) {
      id = '';
      status = '';
      address = Address.fromJSON({});
      statusManager = StatusManager.fromJSON({});
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["status"] = status;
    map["address"] = address?.toMap();
    map["statusManager"] = statusManager?.toMap();
    map["dateTime"] = dateTime;
    return map;
  }
}

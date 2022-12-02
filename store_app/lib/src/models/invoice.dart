


import 'package:login_and_signup_web/src/models/address.dart';

import '../helpers/custom_trace.dart';
import 'cart_responce.dart';

class InvoiceModel {

  String orderId;
  Address userDetails;
  Address vendorDetails;
  List<CartResponce> cart = <CartResponce>[];

  // ignore: non_constant_identifier_names
  int grand_total;
  // ignore: non_constant_identifier_names
  int sub_total;
  String userId;
  String paymentStatus;
  String paymentType;


  InvoiceModel();

  InvoiceModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      orderId = jsonMap['orderId'].toString();
      cart = jsonMap['cart'] != null ? List.from(jsonMap['cart']).map((element) => CartResponce.fromJSON(element)).toList() : [];
      userDetails = jsonMap['userDetails'] != null ? Address.fromJSON(jsonMap['userDetails']) : Address.fromJSON({});
      vendorDetails = jsonMap['vendorDetails'] != null ? Address.fromJSON(jsonMap['vendorDetails']) : Address.fromJSON({});
      grand_total = jsonMap['quantity'] != null ? jsonMap['quantity'].toDouble() : 0;
      sub_total = jsonMap['sub_total'];
      userId = jsonMap['userID'];
      paymentStatus = jsonMap['paymentStatus'];
      paymentType = jsonMap['paymentType'];

    } catch (e) {
      orderId = '';
      grand_total = 0;
      cart = [];
      userId = '';
      userDetails = Address.fromJSON({});
      vendorDetails = Address.fromJSON({});
      paymentStatus = '';
      paymentType = '';

      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["orderId"] = orderId;
    map["cart"] = cart?.map((element) => element.toMap())?.toList();
    map["grand_total"] = grand_total;
    map["sub_total"] = sub_total;
    map["userId"] = userId;
    map["paymentStatus"] = paymentStatus;
    map["paymentType"] = paymentType;

    return map;
  }



}

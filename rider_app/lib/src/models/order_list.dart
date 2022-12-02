import 'package:products_deliveryboy/src/models/payment.dart';

import '../models/address.dart';
import 'cart_responce.dart';
import 'delivery_status.dart';

class OrderList {
  String userid;
  // ignore: non_constant_identifier_names
  String sale_code;
  String status;
  // ignore: non_constant_identifier_names
  List<CartResponce> product_details;
  Address shop;
  Address address;
  Payment paymentDetails  = new Payment();

  // ignore: non_constant_identifier_names
  String payment_type;
  // ignore: non_constant_identifier_names
  String payment_status;
  // ignore: non_constant_identifier_names
  String payment_timestamp;
  // ignore: non_constant_identifier_names
  String grand_total;
  // ignore: non_constant_identifier_names
  String sale_datetime;
  // ignore: non_constant_identifier_names
  String delivery_datetime;
  // ignore: non_constant_identifier_names
  List<DeliveryStatus> delivery_status;
  // ignore: non_constant_identifier_names
  String deliver_assignedtime;
  // ignore: non_constant_identifier_names
  String delivery_state;
  String shopTypeId;
  OrderList();

  OrderList.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      userid = jsonMap['userid'].toString();
      sale_code = jsonMap['sale_code'] != null ? jsonMap['sale_code'] : null;
      status = jsonMap['status'] != null ? jsonMap['status'] : null;
      product_details =
          jsonMap['product_details'] != null ? List.from(jsonMap['product_details']).map((element) => CartResponce.fromJSON(element)).toList() : [];
      shop = jsonMap['shop'] != null ? Address.fromJSON(jsonMap['shop']) : Address.fromJSON({});
      address =  jsonMap['address'] != null ? Address.fromJSON(jsonMap['address']) : Address.fromJSON({});
      paymentDetails = jsonMap['paymentDetails'] != null ? Payment.fromJSON(jsonMap['paymentDetails']) : Payment.fromJSON({});
      payment_type = jsonMap['payment_type'] != null ? jsonMap['payment_type'] : null;
      payment_status = jsonMap['payment_status'] != null ? jsonMap['payment_status'] : null;
      payment_timestamp = jsonMap['payment_timestamp'] != null ? jsonMap['payment_timestamp'] : null;
      grand_total = jsonMap['grand_total'] != null ? jsonMap['grand_total'] : null;
      sale_datetime = jsonMap['sale_datetime'] != null ? jsonMap['sale_datetime'] : null;
      delivery_datetime = jsonMap['delivery_datetime'] != null ? jsonMap['delivery_datetime'] : null;
      delivery_status =
          jsonMap['delivery_status'] != null ? List.from(jsonMap['delivery_status']).map((element) => DeliveryStatus.fromJSON(element)).toList() : [];
      deliver_assignedtime = jsonMap['deliver_assignedtime'];
      delivery_state = jsonMap['delivery_state'];
      shopTypeId = jsonMap['shopTypeId'] != null ? jsonMap['shopTypeId'] : null;
    } catch (e) {
      userid = '';
      sale_code = '';
      status = '';
      shop =  Address.fromJSON({});
      address = Address.fromJSON({});
      product_details = [];
      payment_type = '';
      payment_status = '';
      payment_timestamp = '';
      grand_total = '';
      sale_datetime = '';
      delivery_datetime = '';
      delivery_status = [];
      deliver_assignedtime = '';
      delivery_state = '';
      print('error 1');
      print(e);
      print(jsonMap);
    }
  }
}

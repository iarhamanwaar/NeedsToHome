import 'address.dart';
import 'payment.dart';
import '../helpers/custom_trace.dart';
import 'cart_responce.dart';

class OrderDetailsModel {
  String id;
  List<CartResponce> productDetails = <CartResponce>[];
  Address addressUser = new Address();
  Address addressShop = new Address();
  Payment payment = new Payment();
  String orderDate;
  String orderType;
  String userId;
  String saleCode;
  String status;
  bool instanceDelivery;
  String shopTypeId;
  String rating;
  String deliveryTime;
  String driverName;
  String driverRating;
  String driverId;
  String deliverySlot;



  OrderDetailsModel();

  OrderDetailsModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      productDetails = jsonMap['productDetails'] != null ? List.from(jsonMap['productDetails']).map((element) => CartResponce.fromJSON(element)).toList() : [];

      addressUser = jsonMap['addressUser'] != null ? Address.fromJSON(jsonMap['addressUser']) : Address.fromJSON({});
      addressShop = jsonMap['addressShop'] != null ? Address.fromJSON(jsonMap['addressShop']) : Address.fromJSON({});
      payment = jsonMap['payment'] != null ? Payment.fromJSON(jsonMap['payment']) : Payment.fromJSON({});
      userId = jsonMap['userID']!= null ? jsonMap['userID'] : '';
      saleCode = jsonMap['saleCode']!= null ? jsonMap['saleCode'] : '';
      orderDate = jsonMap['orderDate']!= null ? jsonMap['orderDate'] : '';
      status = jsonMap['status']!= null ? jsonMap['status'] : '';
      orderType = jsonMap['orderType']!= null ? jsonMap['orderType'] : '';
      shopTypeId = jsonMap['shopTypeId']!= null ? jsonMap['shopTypeId'] : '';
      deliveryTime = jsonMap['deliveryTime']!= null ?jsonMap['deliveryTime'] : '';
      driverName = jsonMap['driverName']!= null ?jsonMap['driverName'] : '';
      rating = jsonMap['rating']!= null ?jsonMap['rating'] : '';
      driverRating = jsonMap['driverRating']!= null ?jsonMap['driverRating'] : '';
      instanceDelivery = jsonMap['instanceDelivery'];
      driverId = jsonMap['driverId']!= null ?jsonMap['driverId'] : '';
      deliverySlot = jsonMap['deliverySlot']!= null ?jsonMap['deliverySlot'] : '';

    } catch (e) {
      id = '';
      productDetails = [];
      addressUser = Address.fromJSON({});
      addressShop = Address.fromJSON({});
      payment = Payment.fromJSON({});
      userId = '';
      orderDate = '';
      orderType = '';
      saleCode = '';
      status = '';
      instanceDelivery = false;
      print(CustomTrace(StackTrace.current, message: e));
    }
  }



  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["cart"] = productDetails?.map((element) => element.toMap())?.toList();
    map["addressUser"] = addressUser.toMap();
    map["addressShop"] = addressShop.toMap();
    map["payment"] = payment.toMap();
    map["userId"] = userId;
    map["saleCode"] = saleCode;
    map["orderType"] = orderType;
    map["instanceDelivery"] = instanceDelivery;
    map["shopTypeId"] = shopTypeId;
    return map;
  }

  @override
  bool operator ==(dynamic other) {
    return other.id == this.id;
  }

  @override
  int get hashCode => this.id.hashCode;
}

import 'address.dart';
import 'payment.dart';
import '../helpers/custom_trace.dart';
import 'cart_responce.dart';
import 'package:login_and_signup_web/src/models/coupon_model.dart';

class Checkout {
  String id;
  List<CartResponce> productDetails = <CartResponce>[];
  Address addressUser = new Address();
  Address addressShop = new Address();
  CouponModel couponData = new CouponModel();
  Payment payment = new Payment();
  String orderDate;
  String userId;
  String saleCode;
  bool instanceDelivery;




  Checkout();

  Checkout.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      productDetails = jsonMap['productDetails'] != null ? List.from(jsonMap['productDetails']).map((element) => CartResponce.fromJSON(element)).toList() : [];

   addressUser = jsonMap['addressUser'] != null ? Address.fromJSON(jsonMap['addressUser']) : Address.fromJSON({});
addressShop = jsonMap['addressShop'] != null ? Address.fromJSON(jsonMap['addressShop']) : Address.fromJSON({});
     payment = jsonMap['payment'] != null ? Payment.fromJSON(jsonMap['payment']) : Payment.fromJSON({});
      couponData = jsonMap['couponData'] != null ? CouponModel.fromJSON(jsonMap['couponData']) : CouponModel.fromJSON({});
      userId = jsonMap['userID']!= null ? jsonMap['userID'] : '';
     saleCode = jsonMap['saleCode']!= null ? jsonMap['saleCode'] : '';
      orderDate = jsonMap['orderDate']!= null ? jsonMap['orderDate'] : '';
     instanceDelivery = jsonMap['instanceDelivery'];

    } catch (e) {
      id = '';
      productDetails = [];
      addressUser = Address.fromJSON({});
    addressShop = Address.fromJSON({});
      payment = Payment.fromJSON({});
      couponData =  CouponModel.fromJSON({});
      userId = '';
      orderDate = '';
      saleCode = '';
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
     map["instanceDelivery"] = instanceDelivery;
    return map;
  }

  @override
  bool operator ==(dynamic other) {
    return other.id == this.id;
  }

  @override
  int get hashCode => this.id.hashCode;
}

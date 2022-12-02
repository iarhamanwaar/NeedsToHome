
class OrderList {
  String orderId;
  String status;
  String price;
  String contact;
  String username;
  String userId;
  String paymentType;
  String details;
  String itemImage;
  int itemTotal;
  String itemName;
  String date;
  String orderType;
  String deliverSlot;
  String shopTypeId;
  String pImage;
  String shopId;
  String shopName;
  String shopAddress;




  // used for indicate if client logged in or not
  bool auth;

//  String role;

  OrderList();

  OrderList.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      orderId = jsonMap['orderId'] != null ? jsonMap['orderId'] : '';
      shopId = jsonMap['shopId'] != null ? jsonMap['shopId'] : '';
      status = jsonMap['status'] != null ? jsonMap['status'] : '';
      price = jsonMap['price'] != null ? jsonMap['price'] : '';
      contact = jsonMap['contact'] != null ? jsonMap['contact'] : '';
      username = jsonMap['username'] != null ? jsonMap['username'] : '';
      userId = jsonMap['userId'] != null ? jsonMap['userId'] : '';
      paymentType = jsonMap['paymentType'] != null ? jsonMap['paymentType'] : '';
      details = jsonMap['details'] != null ? jsonMap['details'] : '';
      itemImage = jsonMap['itemImage'] != null ? jsonMap['itemImage'] : '';
      itemTotal = jsonMap['itemTotal'] != null ? jsonMap['itemTotal'] : '';
      itemName = jsonMap['itemName'] != null ? jsonMap['itemName'] : '';
      date = jsonMap['date'] != null ? jsonMap['date'] : '';
      orderType = jsonMap['orderType'] != null ? jsonMap['orderType'] : '';
      deliverSlot = jsonMap['deliverSlot'] != null ? jsonMap['deliverSlot'] : '';
      shopTypeId = jsonMap['shopTypeId'] != null ? jsonMap['shopTypeId'] : '';
      pImage = jsonMap['pImage'] != null ? jsonMap['pImage'] : '';
      shopName = jsonMap['shopName'] != null ? jsonMap['shopName'] : '';
      shopAddress = jsonMap['shopAddress'] != null ? jsonMap['shopAddress'] : '';

    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["orderId"] = orderId;
    map["shopId"] = shopId;
    map["status"] = status;
    map["price"] = price;
    map["contact"] = contact;
    map["username"] = username;
    map["userId"] = userId;
    map["paymentType"] = paymentType;
    map["details"] = details;
    map["itemImage"] = itemImage;
    map["itemTotal"] = itemTotal;
    map["itemName"] = itemName;
    map["date"] = date;
    map["orderType"] = orderType;
    map["deliverSlot"] = deliverSlot;
    map["shopName"] = shopName;
    map["shopAddress"] = shopAddress;



    return map;
  }


}

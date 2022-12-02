
class OrderTracking {
  int count;
  String orderID;
  String name;
  String amount;



  // used for indicate if client logged in or not
  bool auth;

//  String role;

  OrderTracking();

  OrderTracking.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      count = jsonMap['count'];
      orderID = jsonMap['orderID'] != null ? jsonMap['orderID'] : '';
      name = jsonMap['name'] != null ? jsonMap['name'] : '';
      amount = jsonMap['amount'] != null ? jsonMap['amount'] : '';


    } catch (e) {

      print(e);
    }
  }




}

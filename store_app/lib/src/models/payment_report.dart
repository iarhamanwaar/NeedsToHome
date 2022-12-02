
class PaymentReport {

  int id;
  String invoiceID;
  String itemAmount;
  String settlementAmount;
  String commission;
  String paymentMethod;
  String status;
  String date;
  String transactionID;


  // used for indicate if client logged in or not
  bool auth;

//  String role;

  PaymentReport();

  PaymentReport.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'] : '';
      invoiceID = jsonMap['invoiceID'] != null ? jsonMap['invoiceID'] : '';
      itemAmount = jsonMap['itemAmount'] != null ? jsonMap['itemAmount'] : '';
      settlementAmount = jsonMap['settlementAmount'] != null ? jsonMap['settlementAmount'] : '';
      commission = jsonMap['commission'] != null ? jsonMap['commission'] : '';
      paymentMethod = jsonMap['paymentMethod'] != null ? jsonMap['paymentMethod'] : '';
      status = jsonMap['status'] != null ? jsonMap['status'] : '';
      date = jsonMap['date'] != null ? jsonMap['date'] : '';
      transactionID = jsonMap['transactionID'] != null ? jsonMap['transactionID'] : '';


    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["invoiceID"] = invoiceID;
    map["itemAmount"] = itemAmount;
    map["settlementAmount"] = settlementAmount;
    map["commission"] = commission;
    map["paymentMethod"] = paymentMethod;
    map["status"] = status;
    map["date"] = date;
    map["transactionID"] = transactionID;
    return map;
  }



}


import 'miscellaneous.dart';

class PaymentDetails {
  String providerName;
  String providerId;
  String billingName;
  String bookingId;
  String date;
  String workedHours;
  String time;
  String paymentStatus;
  String paymentType;
  double chargeperhrs = 0;
  double discount = 0;
  double subtotal = 0;
  double total = 0;
  double grandTotal = 0;
  double commission = 0;
  double tax = 0;
  double chargePreMin = 0;
  double taxAmount = 0;
  double commissionAmount = 0;
  List<Miscellaneous> miscellaneous = <Miscellaneous>[];
  double miscellaneousAmount = 0;
  int totalMin;
  PaymentDetails();

  PaymentDetails.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      providerName = jsonMap['providerName'].toString();
      providerId = jsonMap['providerId'];
      billingName = jsonMap['billingName'];
      bookingId = jsonMap['bookingId'];
      date = jsonMap['date'];
      workedHours = jsonMap['workedHours'];
      time = jsonMap['time'];
      paymentStatus = jsonMap['paymentStatus'];
      paymentType = jsonMap['paymentType'];
      chargeperhrs = jsonMap['chargeperhrs'];
      discount = jsonMap['discount'];
      total = jsonMap['total'];
      subtotal = jsonMap['subtotal'];
      grandTotal = jsonMap['grandTotal'];
      commission = jsonMap['commission'];
      tax = jsonMap['tax']!=null?jsonMap['tax']:0;
      miscellaneous =
          jsonMap['miscellaneous'] != null ? List.from(jsonMap['miscellaneous']).map((element) => Miscellaneous.fromJSON(element)).toList() : null;
      miscellaneousAmount = jsonMap['miscellaneousAmount'];
      totalMin = jsonMap['totalMin'];
      chargePreMin = jsonMap['chargePreMin'];
      taxAmount = jsonMap['taxAmount'];
      commissionAmount = jsonMap['commissionAmount'];
    } catch (e) {
      providerName = '';
      providerId = '';
      billingName = '';
      bookingId = '';
      date = '';
      workedHours = '';
      time = '';
      paymentType = '';
      paymentStatus = '';
      chargeperhrs = 0.0;
      discount = 0.0;
      subtotal = subtotal;
      total = 0.0;
      grandTotal = 0.0;
      commission = 0.0;
      tax = 0.0;
      miscellaneous = [];
      miscellaneousAmount = 0;
      totalMin = 0;
      chargePreMin = 0;
      taxAmount = 0.0;
      commissionAmount = 0.0;
      print(e);
    }
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["providerName"] = providerName;
    map["providerId"] = providerId;
    map["billingName"] = billingName;
    map["bookingId"] = bookingId;
    map["date"] = date;
    map["workedHours"] = workedHours;
    map["time"] = time;
    map["paymentType"] = paymentType;
    map["paymentStatus"] = paymentStatus;
    map["chargeperhrs"] = chargeperhrs;
    map["discount"] = discount;
    map["total"] = total;
    map["grandTotal"] = grandTotal;
    map["commission"] = commission;
    map["tax"] = tax;
    map["miscellaneous"] = miscellaneous?.map((element) => element.toMap())?.toList();
    map["miscellaneousAmount"] = miscellaneousAmount;
    map["totalMin"] = totalMin;
    map["taxAmount"] = taxAmount;
    map["commissionAmount"] = commissionAmount;
    return map;
  }
}

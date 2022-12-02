import '../helpers/custom_trace.dart';

class OrderHistoryModel {
  String id;
  String status;
  String shopName;
  String shopAddress;
  String amount;
  String date;
  String vendorId;

  OrderHistoryModel();

  OrderHistoryModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      status = jsonMap['status'] != null ? jsonMap['status'] : '';
      shopName = jsonMap['shopName'] != null ? jsonMap['shopName'] : '';
      shopAddress = jsonMap['shopAddress'] != null ? jsonMap['shopAddress'] : '';
      amount = jsonMap['amount'] != null ? jsonMap['amount'] : '';
      date = jsonMap['date'] != null ? jsonMap['date'] : '';
      vendorId = jsonMap['vendorId'] != null ? jsonMap['vendorId'] : '';
    } catch (e) {
      id = '';
      status = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}

import 'package:login_and_signup_web/src/models/vendor.dart';

import '../helpers/custom_trace.dart';

class VendorAllModel {
  String id;
  String shopType;
  String profileComplete;
  List<VendorModel> vendor;
  String status;
  VendorAllModel();

  VendorAllModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
vendor =
          jsonMap['vendor'] != null ? List.from(jsonMap['vendor']).map((element) => VendorModel.fromJSON(element)).toList() : [];
      shopType = jsonMap['shopType'];
      profileComplete = jsonMap['profileStatus'];
      status = jsonMap['status'];
    } catch (e) {
      id = '';
      vendor = [];
      shopType = '';
       status ='';
      profileComplete = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}

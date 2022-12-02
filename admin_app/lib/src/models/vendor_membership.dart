

import '../helpers/custom_trace.dart';

class VendorMembershipModel {
  String id;
  String planname;
  String price;
  String commission;
  String productlimit;
  String validity;
  String shoptype;
  String typeName;
  var  uploadImage;

  VendorMembershipModel();

  VendorMembershipModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id=jsonMap['id'];
      planname = jsonMap['planname'];
      price = jsonMap['price'];
      commission = jsonMap['commission'];
      productlimit  = jsonMap['productlimit'];
      validity  = jsonMap['validity'];
      shoptype  = jsonMap['shoptype'];

      uploadImage = jsonMap['uploadImage'];
      typeName = jsonMap['typeName'];
    } catch (e) {
      planname = '';
      price = '';
      commission = '';
      productlimit = '';
      validity = '';
      shoptype = '';
      uploadImage = '';
      typeName = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["planname"] = planname;
    map["price"] = price;
    map["commission"] = commission;
    map["productlimit"] = productlimit;
    map["validity"] = validity;
    map["shoptype"] = shoptype;
    map["typeName"] = typeName;
    map["uploadImage"] = uploadImage;

    return map;
  }


}

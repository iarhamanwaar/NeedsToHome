import 'package:login_and_signup_web/src/helpers/custom_trace.dart';
import 'package:login_and_signup_web/src/models/addon.dart';
import 'variant.dart';



class ProductDetails2 {
  String id;
  // ignore: non_constant_identifier_names
  String product_name;
  int rating;

  // ignore: non_constant_identifier_names
  int num_of_imgs;
  variantModel variant;
  List<AddonModel> addon;
  String productType;
  bool 	status;
  bool todayDeal;
  String fromTime;
  String toTime;
  String description;


  ProductDetails2();

  ProductDetails2.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      product_name = jsonMap['product_name'];

      rating = jsonMap['rating'];

      num_of_imgs = jsonMap['num_of_imgs'];
      variant = jsonMap['variant'] != null ? variantModel.fromJSON(jsonMap['variant']) : variantModel.fromJSON({});
      addon =
      jsonMap['addon'] != null ? List.from(jsonMap['addon']).map((element) => AddonModel.fromJSON(element)).toList() : [];
      productType = jsonMap['productType'];
      status = jsonMap['status'];
      todayDeal = jsonMap['todayDeals'];
      fromTime = jsonMap['fromTime'];
      toTime = jsonMap['toTime'];
      description = jsonMap['description']!= null?jsonMap['description']:'';
    } catch (e) {
      id = '';
      product_name = '';

      rating = 0;

      num_of_imgs = 0;
      variant = variantModel.fromJSON({});
      productType = '';
      addon = [];
      status = false;
      todayDeal = false;
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["product_name"] = product_name;
    map["rating"] = rating;
    map["num_of_imgs"] = num_of_imgs;
    map["productType"] = productType;
    map["status"] = 	status;
    map["fromTime"] = fromTime;
    map["toTime"] = 	toTime;
    return map;
  }
}

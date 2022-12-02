


import 'product_details2.dart';

import '../helpers/custom_trace.dart';

class Product {
  String id;
  String categoryName;
  List<ProductDetails2> productdetails;

  Product();

  Product.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      productdetails =
          jsonMap['productdetails'] != null ? List.from(jsonMap['productdetails']).map((element) => ProductDetails2.fromJSON(element)).toList() : [];
      categoryName = jsonMap['categoryName'];
    } catch (e) {
      id = '';
      productdetails = [];

      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}

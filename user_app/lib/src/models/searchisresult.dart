import 'package:multisuperstore/src/models/vendor.dart';
import 'product_details2.dart';
import '../helpers/custom_trace.dart';

class SearchISResult {
  List<ItemDetails> item;
  List<Vendor> vendor;

  SearchISResult();

  SearchISResult.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      item = jsonMap['item']  != null ? List.from(jsonMap['item']).map((element) => ItemDetails.fromJSON(element)).toList() : [];
      vendor = jsonMap['vendor']  != null ? List.from(jsonMap['vendor']).map((element) => Vendor.fromJSON(element)).toList() : [];

    } catch (e) {

      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}


class ItemDetails {
   List<ProductDetails2> productList = [];
   Vendor vendor;

   ItemDetails();

   ItemDetails.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      vendor = jsonMap['vendor'] != null ? Vendor.fromJSON(jsonMap['vendor']) : Vendor.fromJSON({});
      productList =
      jsonMap['productList'] != null ? List.from(jsonMap['productList']).map((element) => ProductDetails2.fromJSON(element)).toList() : [];



    } catch (e) {
      print(e);
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}


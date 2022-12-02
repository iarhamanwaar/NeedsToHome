import '../helpers/custom_trace.dart';

// ignore: camel_case_types
class variantModel {
  // ignore: non_constant_identifier_names
  String variant_id;
  // ignore: non_constant_identifier_names
  String product_id;
  String name;
  // ignore: non_constant_identifier_names
  String sale_price;
  // ignore: non_constant_identifier_names
  String strike_price;
  String quantity;
  String unit;
  String type;
  bool selected;
  String foodType;
  String image;
  String stock;
  String minPurchase;
  String maxPurchase = '0';
  double tax;
  String discount;
  double packingCharge;


  variantModel();

  variantModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      variant_id = jsonMap['variant_id'];
      product_id = jsonMap['product_id'];
      name = jsonMap['name'];
      sale_price = jsonMap['sale_price'];
      strike_price = jsonMap['strike_price'];
      quantity = jsonMap['quantity'];
      unit = jsonMap['unit'];
      type = jsonMap['type'];
      selected = jsonMap['selected'];
      foodType = jsonMap['foodType'];
      image = jsonMap['image'];
      stock = jsonMap['stock'];

      tax =  jsonMap['tax'].toDouble()!= null ? jsonMap['tax'].toDouble() :  0.0;
      minPurchase = jsonMap['minPurchase'] != null ? jsonMap['minPurchase'] :  '';
      maxPurchase = jsonMap['maxPurchase'] != null ?jsonMap['maxPurchase'] :  '0';
      discount = jsonMap['discount'] != null ?jsonMap['discount'] :  '';
      packingCharge = jsonMap['packingCharge'].toDouble() != null ?jsonMap['packingCharge'].toDouble() :  0.0;
    } catch (e) {
      variant_id = '';
      product_id = '';
      name = '';
      sale_price = '';
      strike_price = '';
      quantity = '';
      unit = '';
      type = '';
      selected = false;
      foodType = '';
      image = '';
      stock = '';
      tax = 0;
      maxPurchase = '';
      minPurchase = '';
      discount = '';
      print('show error1');
      print(CustomTrace(StackTrace.current, message: e));
    }
  }



}

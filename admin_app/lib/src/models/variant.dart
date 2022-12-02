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
  String tax;
  String packingCharge;
  double discount;
  var uploadImage;
  String maxQty;

  variantModel();

  variantModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      variant_id = jsonMap['variant_id']!= null ? jsonMap['variant_id'] : '';
      product_id = jsonMap['product_id']!= null ? jsonMap['product_id'] : '';
      name = jsonMap['name']!= null ? jsonMap['name'] : '';
      sale_price = jsonMap['sale_price']!= null ? jsonMap['sale_price'] : '';
      strike_price = jsonMap['strike_price']!= null ? jsonMap['strike_price'] : '';
      quantity = jsonMap['quantity']!= null ? jsonMap['quantity'] : '';
      unit = jsonMap['unit']!= null ? jsonMap['unit'] : '';
      type = jsonMap['type']!= null ? jsonMap['type'] : '';
      selected = jsonMap['selected'];
      foodType = jsonMap['foodType'];
      packingCharge = jsonMap['packingCharge']!= null ? jsonMap['packingCharge'] : '';
      tax = jsonMap['tax'];
      discount = jsonMap['discount']!= null ? jsonMap['discount'].toDouble() :  0.0;
      uploadImage = jsonMap['uploadImage'];
      maxQty = jsonMap['maxQty'];
    } catch (e) {
      variant_id = '';
      product_id = '';
      name = '';
      sale_price = '';
      strike_price = '';
      quantity = '';
      unit = '';
      type = '';
      uploadImage = '';
      selected = false;
      foodType = '';
      tax ='';
      discount = 0;
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["variant_id"] = variant_id;
    map["product_id"] = product_id;
    map["name"] = name;
    map["sale_price"] = sale_price;
    map["strike_price"] = strike_price;
    map["quantity"] = quantity;
    map["unit"] = unit;
    map["type"] = type;
    map["uploadImage"] = uploadImage;
    map["selected"] = selected;
    map["foodType"] = foodType;
    map["tax"] = tax;
    map["discount"] = discount;
    map["maxQty"] = maxQty;
    return map;
  }



}

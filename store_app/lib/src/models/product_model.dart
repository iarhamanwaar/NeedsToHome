import '../helpers/custom_trace.dart';

class ProductModel {
  String id;
  String productTitle;
  String category;
  String subCategory;
  String quantity;
  String unit;
  double salePrice;
  double strikePrice;
  double discount;
  String tax;
  String description;
  String stock;
  String itemType;
  String fromTime;
  String toTime;
  String maxQty;
  String packingCharge;

  var  uploadImage;

  ProductModel();

  ProductModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'];
      productTitle = jsonMap['productTitle'];
      category = jsonMap['category'];
      subCategory = jsonMap['subCategory'];
      quantity = jsonMap['quantity'];
      unit = jsonMap['unit'];
      salePrice = jsonMap['salePrice'];
      strikePrice = jsonMap['strikePrice'];
      discount = jsonMap['discount'];
      description = jsonMap['description'];
      stock = jsonMap['stock'];
      uploadImage = jsonMap['uploadImage'];
      itemType = jsonMap['itemType'];
      maxQty = jsonMap['maxQty'];
      fromTime=jsonMap['fromTime'] != null ? jsonMap['fromTime'] : '';
      toTime=jsonMap['toTime'] != null ? jsonMap['toTime'] : '';
      packingCharge = jsonMap['packingCharge']!= null ? jsonMap['type'] : '';
      tax = jsonMap['tax'];
    } catch (e) {
      id = '';
      productTitle = '';
      category ='';
      subCategory = '';
      quantity = '';
      discount = 0.0;
      unit = '';
      salePrice = 0.0;
      strikePrice = 0.0;
      description = '';
      stock = '';
      uploadImage = '';
      itemType = '';
      tax = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }


  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["productTitle"] = productTitle;
    map["category"] = category;
    map["subCategory"] = subCategory;
    map["quantity"] = quantity;
    map["unit"] = unit;
    map["salePrice"] = salePrice;
    map["strikePrice"] = strikePrice;
    map["description"] = description;
    map["stock"] = stock;
    map["itemType"] = itemType;
    map["discount"] = discount;
    map["tax"] = tax;
    map['fromTime']=fromTime;
    map['toTime']=toTime;
    map['maxQty']=maxQty;

    return map;
  }

}

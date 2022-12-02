import '../helpers/custom_trace.dart';

class ShopRatingModel {
  double rate;
  bool  taste = false;
  bool  packing = false;
  bool portion = false;
  String message;
  String buyer;
  String vendor;
  var image;

  ShopRatingModel();

  ShopRatingModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      rate = jsonMap['rate'].toDouble() != null ? jsonMap['rate'].toDouble()  : 0;
      taste = jsonMap['taste']!=null ?jsonMap['taste']:false;
      packing = jsonMap['packing'] !=null ?jsonMap['packing']:false;
      portion = jsonMap['portion'] !=null ?jsonMap['portion']:false;
      message = jsonMap['message'] !=null ?jsonMap['message']:'';
      buyer = jsonMap['buyer'] !=null ?jsonMap['buyer']:'';
      vendor = jsonMap['vendor'] !=null ?jsonMap['vendor']:'';
      image = jsonMap['image'] !=null ?jsonMap['image']:'';
    } catch (e) {


      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["rate"] = rate;
    map["taste"] = taste;
    map["packing"] = packing;
    map["portion"] = portion;
    map["message"] = message;
    map["buyer"] = buyer;
    map["vendor"] = vendor;

    return map;
  }
}



import '../helpers/custom_trace.dart';

class TopProduct {
  String name;
  String id;
  var  image;
  String count;
  //String  logo;

  TopProduct();

  TopProduct.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      name = jsonMap['name']!= null ? jsonMap['name'] : '';
      id = jsonMap['id']!= null ? jsonMap['id'] : '';
      image = jsonMap['image']!= null ? jsonMap['image'] : '';
      count = jsonMap['count']!= null ? jsonMap['count'] : '';
      //logo = jsonMap['logo']!= null ? jsonMap['logo'] : '';
    } catch (e) {
      name = '';
      id = '';
      image = '';
      count='';
      //logo = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }


}

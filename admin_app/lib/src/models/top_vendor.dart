

import '../helpers/custom_trace.dart';

class TopVendor {
  String name;
  String id;
  var  image;
  String  logo;

  TopVendor();

  TopVendor.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      name = jsonMap['name']!= null ? jsonMap['name'] : '';
      id = jsonMap['id']!= null ? jsonMap['id'] : '';
      image = jsonMap['image']!= null ? jsonMap['image'] : '';
      logo = jsonMap['logo']!= null ? jsonMap['logo'] : '';
    } catch (e) {
      name = '';
      id = '';
      image = '';
      logo = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }


}

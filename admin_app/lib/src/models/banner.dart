

import '../helpers/custom_trace.dart';

class BannerModel {
  String type;
  String title;
  String para;
  String id;
  var  uploadImage;
  String redirectType;
  String shopType;



  BannerModel();

  BannerModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      type = jsonMap['type'];
      title = jsonMap['title'];
      para = jsonMap['para'];
      id  = jsonMap['id'];
      redirectType  = jsonMap['redirectType'];
      uploadImage = jsonMap['uploadImage'];
      shopType=jsonMap['shopType'];
    } catch (e) {
      type = '';
      title = '';
      para = '';
      id = '';
      uploadImage = '';
      redirectType = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["type"] = type;
    map["title"] = title;
    map["para"] = para;
    map["id"] = id;
    map["uploadImage"] = uploadImage;
    map["redirectType"] = redirectType;
    map['shopType']=shopType;
    return map;
  }


}

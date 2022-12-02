import '../helpers/custom_trace.dart';

class BannerModel {
  String type;
  String title;
  String redirectType;
  String para;
  String id;
  String categoryId;
  var  uploadImage;

  BannerModel();

  BannerModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      type = jsonMap['type'];
      title = jsonMap['title'];
      redirectType = jsonMap['redirectType'];
      para = jsonMap['para'];
      id  = jsonMap['id'];
      uploadImage = jsonMap['uploadImage'];
      categoryId = jsonMap['categoryId'];
    } catch (e) {
      type = '';
      title = '';
      redirectType = '';
      para = '';
      id = '';
      uploadImage = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["type"] = type;
    map["title"] = title;
    map["redirectType"] = redirectType;
    map["para"] = para;
    map["id"] = id;
    map["uploadImage"] = uploadImage;
    map["categoryId"] = categoryId;

    return map;
  }


}

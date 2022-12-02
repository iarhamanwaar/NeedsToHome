import 'package:login_and_signup_web/src/helpers/custom_trace.dart';

class SuperCategoryModel{
  String categoryName;
  String sortBy;
  String shopType;
  String id;
  String uploadImage;
  bool status;

  SuperCategoryModel();

  SuperCategoryModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      categoryName = jsonMap['categoryName'];
      sortBy=jsonMap['sortBy'];
      shopType=jsonMap['shopType'];
      id = jsonMap['id'];
      uploadImage = jsonMap['uploadImage'];
      status = jsonMap['status'];
    } catch (e) {
      categoryName = '';
      id = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}
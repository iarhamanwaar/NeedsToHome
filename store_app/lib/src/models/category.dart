import '../helpers/custom_trace.dart';

class CategoryModel {
  String categoryName;
  String userId;
  var  uploadImage;

  CategoryModel();

  CategoryModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      categoryName = jsonMap['categoryName'];
      userId = jsonMap['userId'];
      uploadImage = jsonMap['uploadImage'];
    } catch (e) {
      categoryName = '';
      userId = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }


}

import '../helpers/custom_trace.dart';

class CategoryModel {
  String categoryName;
  String id;
  var  uploadImage;

  CategoryModel();

  CategoryModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      categoryName = jsonMap['categoryName'];
      id = jsonMap['id'];
      uploadImage = jsonMap['uploadImage'];
    } catch (e) {
      categoryName = '';
      id = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }


}

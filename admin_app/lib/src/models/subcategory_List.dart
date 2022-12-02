import '../helpers/custom_trace.dart';

class SubCategoryListModel {
  String subcategoryName;
  String categoryId;
  //String userId;
  //String image;
  var uploadImage;
  String id;

  SubCategoryListModel();

  SubCategoryListModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      subcategoryName = jsonMap['subcategoryName'];
      //userId = jsonMap['userId'];
      //image = jsonMap['image'];
      id = jsonMap['id'];
      categoryId = jsonMap['categoryId'];

      uploadImage = jsonMap['uploadImage'];
    } catch (e) {
      subcategoryName = '';
      //userId = '';
      //image = '';
      id  ='';
      categoryId = '';
      uploadImage = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }


}

import '../helpers/custom_trace.dart';

class CategoryListModel {
  String categoryName;
  String userId;
  String image;
  String id;

  CategoryListModel();

  CategoryListModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      categoryName = jsonMap['categoryName'];
      userId = jsonMap['userId'];
      image = jsonMap['image'];
      id = jsonMap['id'];
    } catch (e) {
      categoryName = '';
      userId = '';
      image = '';
      id  ='';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }


}

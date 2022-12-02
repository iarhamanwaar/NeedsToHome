import 'package:login_and_signup_web/src/models/category_List.dart';
import 'package:login_and_signup_web/src/models/order_list.dart';
import 'package:login_and_signup_web/src/models/subcategory_List.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toast/toast.dart';
import '../repository/product_repository.dart' as repository;

class SearchController extends ControllerMVC {
  //GlobalKey<FormState> bannerFormKey;

  List<OrderList> orderList = <OrderList>[];
  SearchController() {

    //  bannerFormKey = new GlobalKey<FormState>();

  }








  filterList( List<CategoryListModel> users, String filterString) {
    List<CategoryListModel> tempUsers = users;
    List<CategoryListModel> _users = tempUsers
        .where((u) =>
    (u.categoryName.toLowerCase().contains(filterString.toLowerCase())) ||
        (u.id.toLowerCase().contains(filterString.toLowerCase())))
        .toList();

    return _users;
  }

  filterListSubcategory( List<SubCategoryListModel> users, String filterString) {
    List<SubCategoryListModel> tempUsers = users;
    List<SubCategoryListModel> _users = tempUsers
        .where((u) =>
    (u.subcategoryName.toLowerCase().contains(filterString.toLowerCase())) ||
        (u.id.toLowerCase().contains(filterString.toLowerCase())))
        .toList();

    return _users;
  }



  deleteSearch(table, id, context, list){

    repository.globalDelete(table, id).then((value) {

      showToast("Delete Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }).catchError((e) {
      // loader.remove();
      // ignore: deprecated_member_use

    }).whenComplete(() {
      // Helper.hideLoader(loader);



    });
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }

}
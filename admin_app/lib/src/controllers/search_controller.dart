import 'package:login_and_signup_web/src/models/category.dart';
import 'package:login_and_signup_web/src/models/driverregistermodel.dart';
import 'package:login_and_signup_web/src/models/order_list.dart';
import 'package:login_and_signup_web/src/models/subcategory_List.dart';
import 'package:login_and_signup_web/src/models/user_model.dart';
import 'package:login_and_signup_web/src/models/vendor.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toast/toast.dart';

class SearchController extends ControllerMVC {
  //GlobalKey<FormState> bannerFormKey;

  List<OrderList> orderList = <OrderList>[];
  SearchController() {

    //  bannerFormKey = new GlobalKey<FormState>();

  }






  filterListVendor( List<VendorModel> vendor, String filterString) {
    List<VendorModel> tempVendors = vendor;
    List<VendorModel> _vendors = tempVendors
        .where((u) =>
    (u.general.storeName.toLowerCase().contains(filterString.toLowerCase())) ||
        (u.general.id.toString().toLowerCase().contains(filterString.toLowerCase())))
        .toList();

    return _vendors;
  }

  filterListUser( List<UserModel> users, String filterString) {
    List<UserModel> tempUsers = users;
    List<UserModel> _users = tempUsers
        .where((u) =>
    (u.userName.toLowerCase().contains(filterString.toLowerCase())) ||
        (u.id.toString().toLowerCase().contains(filterString.toLowerCase())))
        .toList();

    return _users;
  }
  filterListcategory( List<CategoryModel> users, String filterString) {
    List<CategoryModel> tempUsers = users;
    List<CategoryModel> _users = tempUsers
        .where((u) =>
    (u.categoryName.toLowerCase().contains(filterString.toLowerCase())) ||
        (u.id.toString().toLowerCase().contains(filterString.toLowerCase())))
        .toList();

    return _users;
  }
  filterListSubcategory( List<SubCategoryListModel> users, String filterString) {
    List<SubCategoryListModel> tempUsers = users;
    List<SubCategoryListModel> _users = tempUsers
        .where((u) =>
    (u.subcategoryName.toLowerCase().contains(filterString.toLowerCase())) ||
        (u.id.toString().toLowerCase().contains(filterString.toLowerCase())))
        .toList();

    return _users;
  }



  filterListDriver( List<DriverRegistermodel> users, String filterString) {
    List<DriverRegistermodel> tempUsers = users;
    List<DriverRegistermodel> _users = tempUsers
        .where((u) =>
    (u.firstname.toLowerCase().contains(filterString.toLowerCase())) ||
        (u.id.toString().toLowerCase().contains(filterString.toLowerCase())))
        .toList();

    return _users;
  }




  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }

}